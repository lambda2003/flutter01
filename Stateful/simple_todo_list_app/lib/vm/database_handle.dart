
import 'package:path/path.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:sqflite/sqflite.dart';

enum TableName {
  todolist,
  todolist_deleted,
}

class DatabaseHandle {

 final int limitNum = 3;

 Future<Database> initDatabase() async {
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'todolists.db'),
    onCreate: (db, version) async {
      await db.execute(
        """
          create table todolist (
            id integer primary key autoincrement,
            title text,
            content text,
            isAlram integer,
            importance integer not null default 5,
            startDate text,
            endDate text
          )
        """
      );
      await db.execute(
        """
          create table todolist_deleted (
            id integer primary key,
            title text,
            content text,
            isAlram integer,
            importance integer,
            startDate text,
            endDate text
          )
        """
      );
     
    },
     version: 1
  );
 } 
 

  Future<List<TodoList>> getTodoList(Map<String,dynamic>? kwd, TableName tableName,int s) async{
    Database db = await initDatabase();
    List<Map<String,Object?>> queryResults = [];
    if(kwd == null){
      
      queryResults = await db.rawQuery("""
        select * from ${tableName.name.toString()} order by startDate DESC limit ?,?
      
      """,[s,limitNum]);
      
      print('================${queryResults.length}');
    }else{
      if(kwd['id']!=null) {

       queryResults = await db.rawQuery("""
          select * from ${tableName.name.toString()} where id=? order by startDate DESC limit ?,?
        """,[kwd['id'],s,limitNum]);
        
      }else if(kwd['name']!=null) {
        queryResults = await db.rawQuery("""
          select * from ${tableName.name.toString()} where title like ? or content like ? order by startDate DESC limit ?,?
        """,['%${kwd["name"]}%','%${kwd["name"]}%',s,limitNum]);
      }else if(kwd['isAlram']!=null){
        queryResults = await db.rawQuery("""
        select * from ${tableName.name.toString()} where isAlram=?  order by startDate DESC limit ?,?
      
      """,[kwd['isAlram'],s,limitNum]);
      
      }else if(kwd['startDate']!=null){
           queryResults = await db.rawQuery("""
        select * from ${tableName.name.toString()} where startDate>=? order by startDate DESC limit ?,?
      
        """,[kwd['startDate'],s,limitNum]);
      }else if(kwd['importance']!=null){
           queryResults = await db.rawQuery("""
        select * from ${tableName.name.toString()} order by importance DESC,startDate DESC limit ?,?
      
        """,[s,limitNum]);
      }


        
    }
    // if(queryResults.length>0)
      return queryResults.map((d)=>TodoList.fromJson(d)).toList();
    // else
    //   return [];
  }

  Future<int> insertTodoList(TodoList todolist, TableName tableName) async {

    final Database db = await initDatabase();
    return await db.rawInsert("""
      insert into ${tableName.name}(title,importance,isAlram,startDate) values (?,?,?,?)
    
    """
    ,[todolist.title,todolist.importance, todolist.isAlram ,todolist.startDate.toString()]);

  }

   Future<int> updateTodoList(TodoList todolist, TableName tableName) async {

    Database db = await initDatabase();
    return await db.rawUpdate("""
      update ${tableName.name.toString()} set title=?,importance=?,isAlram=?,startDate=? where id=?
    
    """
    ,[todolist.title,todolist.importance,todolist.isAlram,todolist.startDate.toString(),todolist.id]);

  }

  Future<int> deleteTodoList(int id) async {

    Database db = await initDatabase();

    // Get ID
    List<TodoList> d = await getTodoList({"id":id},TableName.todolist,0);

    await db.rawDelete("""
      delete from todolist where id=?
    
    """
    ,[id]);

    return await db.rawInsert("""
      insert into todolist_deleted(id,title,startDate) values (?,?,?)
    
    """
    ,[d[0].id, d[0].title,d[0].startDate]);
    

  }


}