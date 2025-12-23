import fastapi

userRouter = fastapi.APIRouter()

@userRouter.get("/")
def read_users():
  return {"message":'aaaa'}


