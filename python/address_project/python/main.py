# BaseModel을 안쓰고 Form을 씀.
from fastapi import FastAPI,APIRouter, UploadFile, File, Form
from fastapi.responses import Response
from lib.database import Dbconn
from typing import Union

app = FastAPI()
# router = APIRouter()
dbconn = Dbconn()

@app.get('/select/{seq}')
async def select(seq:int):
  if seq == 0 : 
    r, rows = await dbconn.executeQuery('select seq,name,phone,address,relation from address',())
  else:
    r, rows = await dbconn.executeQuery('select seq,name,phone,address,relation from address where seq=%s',(seq))

  if r == 200:
    return {"code":r,"data":[{'seq' : row[0],'name' : row[1],'phone' : row[2],'address' : row[3],'relation':row[4]} for row in rows ]}
  else:
    raise ValueError(f'Error(code: {r}) => {rows}')


@app.get('/view/{seq}')
async def view(seq:int):
  # seq번호로 이미지를 가져와서 데이터를 져온다.
  try:
    r, rows = await dbconn.executeQuery('select image from address where seq=%s',(seq,))
    if r == 200:
      if(rows[0] and rows[0][0]):
        return Response(
          content=rows[0][0],
          media_type='image/png',
          headers={"Cache-Control":"no-cache, no-store, must-revalidate"}
        )
      else:
        return {"code":r,"data":'no image'}
    else:
      raise ValueError(f'Error(code: {r}) => {rows}')

  except Exception as err:
    print('---- ERROR: ',err)
    return {'code':-100,'data':'error'}


@app.post('/upload')
async def upload(
  name:str = Form(...),
  phone:str=Form(...),
  address:str=Form(...),
  relation:str=Form(...),
  file:UploadFile = File(...)
):
  try:
    image_data = await file.read()
    r = await dbconn.executeQuery(
      """
        insert into address(name,phone,address,relation,image)
        values (%s,%s,%s,%s,%s)
      """,
      (name,phone,address,relation,image_data),
      True
    )
    print(r[0],'------')
    if r[0] == 200:
      return {"code":r[0],"data":[]}
    else:
      raise ValueError(f'Error(code: {r})')


  except Exception as err:
    print('error',err)
    return {'code':-101,'data':'error'}


@app.post('/update')
async def update(
  seq: int = Form(...),
  name:str = Form(...),
  phone:str=Form(...),
  address:str=Form(...),
  relation:str=Form(...),
  file: Union[UploadFile,None] = None
):
  try:
    print(file,'-----')
    if file is not None:
      image_data = await file.read()
      r = await dbconn.executeQuery(
        """
          update address set name=%s,phone=%s,address=%s,relation=%s,image=%s
          where seq=%s
        """,
        (name,phone,address,relation,image_data,seq),
        True
      )
    else:
      r = await dbconn.executeQuery(
        """
          update address set name=%s,phone=%s,address=%s,relation=%s
          where seq=%s
        """,
        (name,phone,address,relation,seq),
        True
      )
    print(r[0],'------')
    if r[0] == 200:
      return {"code":r[0],"data":[]}
    else:
      raise ValueError(f'Error(code: {r})')


  except Exception as err:
    print('error',err)
    return {'code':-101,'data':'error'}



@app.delete("/delete/{seq}")
async def delete(seq:int):
  try:
    r = await dbconn.executeQuery("delete from address where seq=%s",(seq),True)
    if r and r[0] == 200:
      return {"code":r[0], "data":[]}
    else:
      raise ValueError(f'Error(code: {r})')
    
  except Exception as err:
    print("ERROR: ",err)
    return {"code":-200,"data":"error"}



if __name__ == "__main__" :
  import uvicorn
  uvicorn.run(app,host='172.16.250.187',port=8000)
