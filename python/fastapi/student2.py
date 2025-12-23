from fastapi import FastAPI
import pymysql
from pydantic import BaseModel
# from router.items import router as items_router
# from router.clients import router as clients_router
from database.database import Dbconn

app = FastAPI()
# app.include_router(items_router,prefix='/items',tags=['items'])
# app.include_router(clients_router,prefix='/clients',tags=['clients'])

class Student(BaseModel):
  code: str
  name: str
  dept: str
  phone: str
  address : str




# conn = pymysql.connect(
#         host='127.0.0.1',
#         user='root',
#         password='qwer1234',
#         database='education',
#         charset='utf8',
#         # cursorclass=pymysql.cursors.DictCursor
#       )


@app.get('/select')
async def select():
  
  r, rows = await Dbconn().executeQuery('select * from student',[])

  if r == 200:
    return {"code":r,"data":[{'code' : row[0],'name' : row[1],'dept' : row[2],'phone' : row[3],'address':row[4]} for row in rows ]}
  else:
    raise ValueError(f'Error(code: {r}) => {rows}')
  # conn.connect()
  # curs = conn.cursor()

  # sql = 'select * from student'
  # curs.execute(sql)
  # rows = curs.fetchall()
  # conn.close()
  # result = []
  # for row in rows:
  #   tempDict = {
  #     'code' : row[0],
  #     'name' : row[1],
  #     'dept' : row[2],
  #     'phone' : row[3]
  #   }
  #   result.append(tempDict)

  # return {"results":[{'code' : row[0],'name' : row[1],'dept' : row[2],'phone' : row[3],'address':row[4]} for row in rows ]}

#@app.get('/insert')
#async def insert(code: str=None, name:str=None, dept:str=None, phone:str=None, address:str=None):

@app.post('/insert')
async def insert(student:Student):
  print(f"{student} --- a")
  r = await Dbconn().executeQuery('insert into student(scode,sname,sdept,sphone,saddress) values(%s,%s,%s,%s,%s)',(student.code,student.name,student.dept,student.phone,student.address),True)
  return {'code':r[0],'data':[]}
  
 

  # conn.connect()
  # curs = conn.cursor()
  # try:
  #   sql = """
  #     insert into student(scode,sname,sdept,sphone,saddress)
  #     values(%s,%s,%s,%s,%s)
  #   """
  #   r = curs.execute(sql, (student.code,student.name,student.dept,student.phone,student.address))
  #   conn.commit()
  #   return {'results':r}
  # except Exception as e:
  #   print("ERROR:",e)
  #   return {'results':-1}
  # finally:
  #   conn.close()


@app.post('/update')
async def update(student:Student):
  print(f"{student} --- a")
  r = await Dbconn().executeQuery('update student set sname=%s,sdept=%s,sphone=%s,saddress=%s where scode=%s',(student.name,student.dept,student.phone,student.address,student.code),True)
  return {'code':r[0],'data':[]}
  # conn.connect()
  # curs = conn.cursor()
  # try:
  #   sql = """
  #     update student set sname=%s,sdept=%s,sphone=%s,saddress=%s where scode=%s
  #   """
  #   r = curs.execute(sql, (student.name,student.dept,student.phone,student.address,student.code))
  #   conn.commit()
  #   return {'results':r}
  # except Exception as e:
  #   print("ERROR:",e)
  #   return {'results':-1}
  # finally:
  #   conn.close()



if __name__ == "__main__" :
  import uvicorn
  uvicorn.run(app,host='172.16.250.187',port=8000)