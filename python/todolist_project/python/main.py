from fastapi import FastAPI
from lib.database import Dbconn
from pydantic import BaseModel

app = FastAPI()
dbconn = Dbconn()

class TodolistData(BaseModel):
  seq: int
  title: str
  content: str
  meet_date: str


@app.get('/list')
async def list():
  r,rows = await dbconn.executeQuery('select * from todolist',[])
  if r == 200:
    return {"code":r,"data":[{'seq' : row[0],'title' : row[1],'content' : row[2],'meet_date' : row[3],'created_at':row[4]} for row in rows ]}
  else:
    raise ValueError(f'Error(code: {r}) => {rows}')


@app.post('/add')
async def add(todolistData:TodolistData ):

  r = await dbconn.executeQuery('insert into todolist(title,content,meet_date) values (%s,%s,%s)',(
    todolistData.title,
    todolistData.content,
    todolistData.meet_date
  ), True)
  if r[0] == 200:
    return {"code":r[0],"data":[]}
  else:
    raise ValueError(f'Error(code: {r})')

@app.delete('/delete')
async def delete(todolistData:TodolistData ):

  sqls = [
    """
        insert into todolist_deleted(todolist_seq,title,content,meet_date)
        select seq,title,content,meet_date from todolist where seq=%s
    """,
    'delete from todolist where seq=%s'
  ]
  args = [(todolistData.seq),(todolistData.seq)]
  r = await dbconn.executeQueries(sqls,args,True)

  if r[0] == 200:
    return {"code":r,"data":[]}
  else:
    raise ValueError(f'Error(code: {r})')

@app.post('/update')
async def update(todolistData:TodolistData ):
  r = await dbconn.executeQuery('update todolist set title=%s,content=%s,meet_date=%s where seq=%s',(
    todolistData.title,
    todolistData.content,
    todolistData.meet_date,
    todolistData.seq
  ), True)
  if r[0] == 200:
    return {"code":r[0],"data":[]}
  else:
    raise ValueError(f'Error(code: {r})')



if __name__ == "__main__":
  import uvicorn
  uvicorn.run(app,host="172.16.250.187",port=8000)