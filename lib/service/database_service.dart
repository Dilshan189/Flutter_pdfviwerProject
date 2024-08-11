import 'dart:io'as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfviwer/model/pdf_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService
{
  static Database? _db;
  static const DB_Name = 'pdf_db.db';

  final String _pdfTableName = 'tblPdf';
  final String _pdfId = 'id';
  final String _pdfName = 'fileName';
  final String _pdfPath = 'filePath';

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
    await db.execute("CREATE TABLE $_pdfTableName ($_pdfId INTEGER PRIMARY KEY,$_pdfName TEXT,$_pdfPath TEXT)");
  }


  /// insertPDF-----------------------------------------------------------------

  Future<PDFModel> insertPdf(PDFModel pdfModel) async
  {
    var dbClient = await db;

    pdfModel.id = await dbClient!.insert(_pdfTableName, pdfModel.toMap());

    return pdfModel;
  }

  /// savedPDF------------------------------------------------------------------

  Future<List<PDFModel>>getSavedPDFList()async
  {
    var dbClient = await db;

    List<Map> maps = await dbClient!.query(_pdfTableName,columns: [_pdfId,_pdfName,_pdfPath]);

    List<PDFModel>pdfList = [];

    if(maps.isNotEmpty)
      {

        for(int i = 0; i<maps.length; i++)
          {
            pdfList.add(PDFModel.fromMap(Map<String,dynamic>.from(maps[i])));
          }
      }

    return pdfList;
  }


  /// deletePDF-----------------------------------------------------------------

  Future<int> deletePDF(int id) async
  {
    var dbClient = await db;

    return await dbClient!.delete(_pdfTableName,where: '$_pdfId = ?',whereArgs: [id]);
  }

  ///updatePDF------------------------------------------------------------------

  Future<int> updatePDF(PDFModel pdfModel) async
  {
    var dbClient = await db;

    return await dbClient!.update(_pdfTableName, pdfModel.toMap(),
    where: '$_pdfId = ?',whereArgs: [pdfModel.id]
    );
  }


  /// deleteAllPDF--------------------------------------------------------------

  Future<int> deleteAllPDF() async
  {
    var dbClient = await db;
    return await dbClient!.delete(_pdfTableName);
  }


}