import 'package:must_eat_place_app/model/place.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {


  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path,'musteatplaces.db'),
      onCreate: (db, version) async {
        await db.execute(
          """
          create table musteatplace (
          seq integer primary key autoincrement,
          name text,
          phone text,
          lat real,
          lng real,
          image blob,
          estimate text,
          initDate text,
          likeCount integer not null default 0
          )
          """
        );
        // await db.execute(
        //   """
        //   create table musteatplace_deleted (
        //   seq integer primary key autoincrement,
        //   name text,
        //   phone text,
        //   lat real,
        //   lng real,
        //   image blob,
        //   estimate text,
        //   initDate text
        //   )
        //   """
        // );      
      },
      version: 1

    );
  }

  // 정보
  Future<List<Place>> getData(String? kwd) async {
    Database db = await initDatabase();

    if(kwd == null){
    
    }
     final queryResult = await db.rawQuery(
        'select * from musteatplace'
      );
      return queryResult.map((data) => Place.fromJson(data)).toList();
  }


  // 인서트
  Future<int> insertData(Place place) async {
    Database db = await initDatabase();
    return await db.rawInsert(
      """
        insert into musteatplace(
          name,phone,lat,lng,image,estimate,initDate
        ) values (?,?,?,?,?,?,?)
      """,
      [place.name,place.phone,place.lat,place.lng,place.image,place.estimate,place.initDate.toString()]
    );

  }
  
  // 업데이트
  Future<int> updateData(Place place) async {
    Database db = await initDatabase();
    return await db.rawUpdate(
      """
        update musteatplace set
          name=?,phone=?,lat=?,lng=?,
          image=?,estimate=?,initDate=?,likeCount=?
         where seq=?
      """,
      [
        place.name,
        place.phone,
        place.lat,
        place.lng,
        place.image,
        place.estimate,
        place.initDate.toString(),
        place.likeCount,
        place.seq
      ]
    );

  }


  // 지우기
  Future<int> deleteData(int seq) async {
    Database db = await initDatabase();
    return await db.rawDelete(
      'delete from musteatplace where seq=?',
      [seq]
    );

  }


  

}