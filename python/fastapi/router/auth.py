from fastapi import APIRouter

authRouter = APIRouter()

@authRouter.get('/')
def read_auth():
  return {"message":"auth"}