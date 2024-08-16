
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfviwer/model/lockpdf_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService{

  static Database? _db;
  static const DB_Name = 'pdfAB_db.db';

  final String _pdfTableLockName = 'tblLockPdf';
  final String _pdfLockId = 'id';
  final String _pdfLockName = 'fileName';
  final String _pdfLockPath = 'filePath';
  final String _pdfLockPassword = 'filePassword';


  Future<Database?> get db async
  {
    if(_db != null)
    {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  initDb() async
  {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,DB_Name);
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db,int version)
  async
  {
    await db.execute("CREATE TABLE $_pdfTableLockName ($_pdfLockId INTEGER PRIMARY KEY,$_pdfLockName TEXT,$_pdfLockPath TEXT,$_pdfLockPassword TEXT )");

  }

  /// insertLockPDF-----------------------------------------------------------------

Future<LockpdfModel> insertlockpdf(LockpdfModel lockpdfModel) async
{
  var dbClient = await db;
  lockpdfModel.id = await dbClient!.insert(_pdfTableLockName, lockpdfModel.toMap());
  return lockpdfModel;
}

 /// savedLockPDF------------------------------------------------------------------

Future<List<LockpdfModel>>getSavedLockPdfList()async
{
  var dbClient = await db;

  List<Map> maps = await dbClient!.query(_pdfTableLockName,columns: [_pdfLockId,_pdfLockName,_pdfLockPath,_pdfLockPassword ]);

  List<LockpdfModel>pdfList = [];

  if(maps.isNotEmpty)
    {
      for(int i = 0; i<maps.length; i++)
        {
          pdfList.add(LockpdfModel.fromMap(Map<String,dynamic>.from(maps[i])));
        }
    }
  return pdfList;
}

/// delete pdf------------------------------------------------------------------

  Future<int> deleteLockPDF(int id) async {

    var dbClient = await db;

    return await dbClient!

        .delete(_pdfTableLockName, where: '$_pdfLockId = ?', whereArgs: [id]);
  }


}
