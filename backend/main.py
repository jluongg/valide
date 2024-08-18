from typing import Union

from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn
import json

import core.supertokens
import core.secret
from supertokens_python import get_all_cors_headers
from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from supertokens_python.framework.fastapi import get_middleware
from supertokens_python import InputAppInfo, SupertokensConfig, init
from supertokens_python.ingredients.emaildelivery.types import (
    EmailDeliveryConfig,
    SMTPSettings,
    SMTPSettingsFrom,
)
from supertokens_python.recipe import dashboard, passwordless, session
from supertokens_python.recipe.passwordless import ContactEmailOrPhoneConfig


secrets_data = json.loads(core.secret.decrypt_json("./core/keys.enc"))

init(
    app_info=InputAppInfo(
        app_name="frontend",
        api_domain="http://localhost:8080",
        website_domain="http://localhost:3000",
        api_base_path="/auth",
        website_base_path="/auth",
    ),
    supertokens_config=SupertokensConfig(
        connection_uri="http://localhost:3567",
        api_key="3yYtogFHbRJKL3mBwMIj",  # API KEY TO CHANGE AND HIDE
    ),
    framework="fastapi",
    recipe_list=[
        session.init(),  # initializes session features
        passwordless.init(
            flow_type="USER_INPUT_CODE",
            contact_config=ContactEmailOrPhoneConfig(),
            email_delivery=EmailDeliveryConfig(
                service=passwordless.SMTPService(
                    smtp_settings=SMTPSettings(
                        host=secrets_data["email_credentials"]["smtp_server"],
                        port=secrets_data["email_credentials"]["smtp_port"],
                        from_=SMTPSettingsFrom(
                            name="Objet-du-mail",
                            email=secrets_data["email_credentials"]["email_user"],
                        ),
                        password=secrets_data["email_credentials"]["email_password"],
                        secure=False,
                    )
                )
            ),
        ),
        dashboard.init(),
    ],
    mode="asgi",  # use wsgi if you are running using gunicorn
)


app = FastAPI()
app.add_middleware(get_middleware())


class Item(BaseModel):
    name: str


@app.post("/ping")
async def create_item(item: Item):
    print(item)
    if item.name.lower() == "ping":
        return "pong"
    return item

host = "0.0.0.0" #localhost usually, 0.0.0.0 if running on a real device 

# root pour demander le dernier champ pas rempli


app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        f"http://{host}:3000",
    ],
    allow_credentials=True,
    allow_methods=["GET", "PUT", "POST", "DELETE", "OPTIONS", "PATCH"],
    allow_headers=["Content-Type"] + get_all_cors_headers(),
)

if __name__ == "__main__":
    uvicorn.run(app, port=8080, host=host)
