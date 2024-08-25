import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfviwer/model/merge_pdf_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{

static Database? _db;
static const DB_Name = 'pdfcd_db.db';

final String _mergePdfTableName = 'tblMerge';
final String _mergePdfId = 'id';
final String _mergePdfName = 'fileName';
final String _mergePdfPath = 'filePath';

Future<Database?> get db async
{
  if(_db != null)
    {
      return _db!;
    }


  _db = await initDb();
  return _db;
}
initDb() async {
  io.Directory documentDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentDirectory.path, DB_Name);
  var db = await openDatabase(path, version: 1, onCreate: _onCreate);
  return db;
}

_onCreate(Database db,int version)
  async
  {
    await db.execute("CREATE TABLE $_mergePdfTableName ($_mergePdfId INTEGER PRIMARY KEY,$_mergePdfName TEXT,$_mergePdfPath TEXT )");
  }


Future<MeargePDF> insertMargePdf(MeargePDF meargePDF) async
{
  var dbClient = await db;
  meargePDF.id = await dbClient!.insert(_mergePdfTableName, meargePDF.toMap());
  return meargePDF;
}



Future<List<MeargePDF>>getSavedMargePdf()async
{
  var dbClient = await db;

  List<Map> maps = await dbClient!.query(_mergePdfTableName,columns: [_mergePdfId,_mergePdfName,_mergePdfPath ]);

  List<MeargePDF>pdfList = [];

  if(maps.isNotEmpty)
  {
    for(int i = 0; i<maps.length; i++)
    {
      pdfList.add(MeargePDF.fromMap(Map<String,dynamic>.from(maps[i])));
    }
  }
  return pdfList;
}

Future<int> deleteMearPDF(int id) async {

  var dbClient = await db;

  return await dbClient!

      .delete(_mergePdfTableName, where: '$_mergePdfId = ?', whereArgs: [id]);
}


}