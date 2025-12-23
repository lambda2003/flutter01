from fastapi import APIRouter
from database.database import Dbconn

router = APIRouter()

@router.get('/')
async def read_items():
  rows = await Dbconn().executeQuery('select * from student')
  print(rows)
  # if rows["items"]:
  #   for row in rows["items"]:
  #     print(row['scode'])
  return {
    'message':'Read all items',
    'items':[
      {'id':1,'name':'GT'},
      {'id':2,'name':'Bill Gates'},
      {'id':3,'name':'Bryan'},
      {'id':4,'name':'Lee'},
      {'id':5,'name':'유비'},
      ]
  }

@router.get('/{item_id}')
async def read_item(item_id:int):
  return {'item_id':item_id}