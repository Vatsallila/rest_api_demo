import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase{
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'api_db.db');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "api_db.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join('assets/database', 'api_db.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<List<Map<String, Object?>>> getUserListFromUserTable() async {
    Database db = await initDatabase();
    print("before");
    List<Map<String,dynamic> > users= await db.rawQuery("SELECT Tbl_User.Name as UserName,Tbl_City.Name as CityName,UserID,Color FROM Tbl_User INNER JOIN Tbl_City On Tbl_User.CityId = Tbl_City.CityID");
    print("after");
    return users;


    List<Map<String, Object?>> data   = await db.rawQuery('SELECT Tbl_User.Name as UserName,'
        'Tbl_City.Name as CityName,'
        'UserID,'
        'Color '
        'FROM Tbl_User'
        'INNER JOIN Tbl_City '
        'On '
        'Tbl_User.CityId = Tbl_City.CityID',);

    return data;
  }
}