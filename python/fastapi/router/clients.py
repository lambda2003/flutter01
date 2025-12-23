from fastapi import APIRouter

router = APIRouter()

@router.get('/')
async def read_items():
  return {'message':'Read all clients'}

@router.get('/{client_id}')
async def read_item(client_id:int):
  return {'client_id':client_id}
