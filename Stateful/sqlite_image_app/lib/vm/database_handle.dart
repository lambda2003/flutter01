import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_image_app/model/address.dart';

class DatabaseHandle {

  
  // Connection 
  Future<Database> initDatabase() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path,'addresses.db'),
      onCreate: (db, version) async  {
        await db.execute(
          """
            create table address (
              id integer primary key autoincrement,
              name text,
              phone text,
              address text,
              relation text,
              image blob
            
            )
          """
        );
      },
      version: 1,
    );
  }

  Future<List<Address>> getAddress(String? kwd) async {
    final Database db = await initDatabase();
    if(kwd == null){
      final queryResult = await db.rawQuery(
        "select * from address"
      );
      return queryResult.map((data)=>Address.fromJson(data)).toList();
    }else{
      final queryResult = await db.rawQuery(
        "select * from address where name like ?",
        ['%$kwd%']
      );
      return queryResult.map((data)=>Address.fromJson(data)).toList();
    }
  }

  Future<int> insertAddress(Address address) async {
    final Database db = await initDatabase();
    return await db.rawInsert(
      """
      insert into address(name,phone,address,relation,image)
      values (?,?,?,?,?)
      """,
      [address.name,address.phone,address.address,address.relation, address.image]
    );

  }

  Future<int> updateAddress(Address address) async {
    final Database db = await initDatabase();
    return await db.rawUpdate(
      """
        update address set name=?,phone=?,address=?,relation=?,image=?
        where id = ?
      """
      ,[address.name,address.phone,address.address,address.relation, address.image, address.id]
    );
  }

  Future<int> deleteAddress(int id) async {
    final Database db = await initDatabase();
    return await db.rawDelete('delete from address where id=?',[id]);

    
  }

}