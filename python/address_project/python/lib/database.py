import aiomysql
import asyncio, time

class Dbconn():
  

  pool = None

  def __init__(self):
    print('===db init')

  async def getPool(self):
      return await aiomysql.create_pool(
        host='127.0.0.1', 
        port=3306,
        user='root', 
        password='qwer1234',
        db='python'
      )

    
  async def getConnection(self):
    if self.pool == None:
      self.pool = await self.getPool()

  # @staticmethod
  async def executeQuery(self,sql,args,isCommit=False):
    try:
      await self.getConnection()
    
      async with self.pool.acquire() as conn:
        async with conn.cursor() as curs:
          await curs.execute(sql,args)
          if isCommit:
            r = await conn.commit()
            return (200,)
          else:
            r = await curs.fetchall()
            print(r)
            return (200,list(r))

      # with self.getConnection() as conn:
      #   with conn.cursor() as curs:
        
      #     curs.execute(sql)
      #     r = curs.fatchall()
      #     print(r)
      #     return list(r)
      # await curs.execute(sql)

      
    except Exception as err:
      print(f'error', err.args[0], err.args[1])
      if err.args[0] == 1062:
        return (1062,list(args))
      

    