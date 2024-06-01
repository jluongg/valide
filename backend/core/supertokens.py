from supertokens_python import init, InputAppInfo, SupertokensConfig
from supertokens_python.recipe import passwordless, session, dashboard

from supertokens_python.recipe.passwordless import ContactEmailOrPhoneConfig


init(
    app_info=InputAppInfo(
        app_name="frontend",
        api_domain="http://localhost:8080",
        website_domain="http://localhost:3000",
        api_base_path="/auth",
        website_base_path="/auth"
    ),
    supertokens_config=SupertokensConfig(
        connection_uri="http://localhost:3567",
        api_key="3yYtogFHbRJKL3mBwMIj"
    ),
    framework='fastapi',
    recipe_list=[
        session.init(), # initializes session features
        passwordless.init(
            flow_type="USER_INPUT_CODE",
            contact_config=ContactEmailOrPhoneConfig()
        ),
        dashboard.init(),
    ],
    mode='asgi' # use wsgi if you are running using gunicorn
)
