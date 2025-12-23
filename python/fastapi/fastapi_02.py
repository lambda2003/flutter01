from fastapi import FastAPI
from router.items import router as items_router
from router.clients import router as clients_router
# from database.database import Dbconn

app = FastAPI()
app.include_router(items_router,prefix='/items',tags=['items'])
app.include_router(clients_router,prefix='/clients',tags=['clients'])


if __name__ == "__main__" :
  import uvicorn
  uvicorn.run(app,host='127.0.0.1',port=8000)