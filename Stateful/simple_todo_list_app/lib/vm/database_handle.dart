
import 'package:path/path.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';
import 'package:sqflite/sqflite.dart';

enum TableName {
  todolist,
  todolist_deleted,
}

class DatabaseHandle {



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
            startDate text,
            endDate text
          )
        """
      );
     
    },
     version: 1
  );
 } 
 

  Future<List<TodoList>> getTodoList(int? id, String tableName) async{
    Database db = await initDatabase();
    if(id == null){
      
      final List<Map<String,Object?>> queryResults = await db.rawQuery("""
        select * from ${tableName.toString()}
      
      """);
      
      return queryResults.map((d)=>TodoList.fromJson(d)).toList();
    }else{
      final List<Map<String,Object?>> queryResults = await db.rawQuery("""
        select * from ${tableName.toString()} where id=?
      
      """,[id]);
      
      return queryResults.map((d)=>TodoList.fromJson(d)).toList();
    }
  }

  Future<int> insertTodoList(TodoList todolist, String tableName) async {

    final Database db = await initDatabase();
    return await db.rawInsert("""
      insert into ${tableName}(title,startDate) values (?,?)
    
    """
    ,[todolist.title,todolist.startDate]);

  }

   Future<int> updateTodoList(TodoList todolist, String tableName) async {

    Database db = await initDatabase();
    return await db.rawUpdate("""
      update ${tableName.toString()} set title=?,startDate=? where id=?
    
    """
    ,[todolist.title,todolist.startDate,todolist.id]);

  }

  Future<int> deleteTodoList(int id) async {

    Database db = await initDatabase();

    // Get ID
    List<TodoList> d = await getTodoList(id,'todolist');

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