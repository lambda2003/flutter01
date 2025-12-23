
# FastApi는 async를 제공
from fastapi import FastAPI,APIRouter
# from database.database import Dbconn
# from router.user import userRouter
# from router.auth import authRouter

app = FastAPI()

# @app.route("/test", )

@app.get("/")
def home():
  return {"message":"Hello World!------"}

@app.get("/items/{item_id}")
async def read_item(item_id:int, query_param:str=None):

  return {"item_id":item_id, "query_param": query_param}

# app.include_router(userRouter,prefix='/user')
# app.include_router(authRouter,prefix='/auth')

# python에서 메인 함수
if __name__ == "__main__":
  import uvicorn
  uvicorn.run(app, host="172.16.250.187",port=8000)