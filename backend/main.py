from typing import Union

from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn

import core.supertokens
from supertokens_python import get_all_cors_headers
from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from supertokens_python.framework.fastapi import get_middleware


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


app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:3000",
    ],
    allow_credentials=True,
    allow_methods=["GET", "PUT", "POST", "DELETE", "OPTIONS", "PATCH"],
    allow_headers=["Content-Type"] + get_all_cors_headers(),
)

if __name__ == "__main__":
    uvicorn.run(app, port=8080, host="localhost")
