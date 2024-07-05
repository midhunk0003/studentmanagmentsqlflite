import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLdb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialisation();
      return _db;
    } else {
      return _db;
    }
  }

  //----------join the db path ------//
  Future<Database> initialisation() async {
    String db_path = await getDatabasesPath();
    String path = join(db_path, "student_db");
    Database mydb = await openDatabase(path, onCreate: _createDB, version: 1,);

    return mydb;
  }

//----------------path and database join end-----------//
//------------------creating database table------------//
  _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "studentdetails"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "age"  INT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE "users"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "username" TEXT NOT NULL,
    "email"  TEXT NOT NULL
    )
    ''');
    print('=============data base created!=========');
  }

//-------------------creating data base table end----------------------//

//==================CRUD OPERATION=======================//

// ----------------------INSERT QUERY--------------------//

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int rep = await mydb!.rawInsert(sql);
    return rep;
  }

//-----------------------INSERT QUERY END ---------------//

// ----------------------FETCH QUERY--------------------//
  Future<List<Map>> getData(String sql) async {
    Database? mydb = await db;
    List<Map> rep = await mydb!.rawQuery(sql);
    return rep;
  }

//-----------------------FETCH QUERY END ---------------//

// ----------------------UPDATE QUERY--------------------//
  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int respup = await mydb!.rawUpdate(sql);
    return respup;
  }

//-----------------------UPDATE QUERY END ---------------//

// ----------------------DELETE QUERY--------------------//
  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

//-----------------------DELETE QUERY END ---------------//

//==================CRUD OPERATION END=======================//
}
