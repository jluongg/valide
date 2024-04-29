from typing import Union

from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn

app = FastAPI()

class Item(BaseModel):
    name: str

@app.post("/ping")
async def create_item(item: Item):
    print(item)
    if item.name.lower() == "ping":
        return "pong"
    return item

    
if __name__ == '__main__':
    uvicorn.run(app, port=8080, host='0.0.0.0')