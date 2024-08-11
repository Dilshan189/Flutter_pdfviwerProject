import 'dart:io'as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/pdf_favourite_model.dart';

class DatabaseServiceFavourite
{
  static Database? _db;
  static const DB_Name = 'pdf_db.db';

  final String _pdffavouriteTableName = 'tblfavourite';
  final String _pdffavouriteId = 'id';
  final String _pdffavouriteName = 'fileName';
  final String _pdffavouritePath = 'filePath';

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
    await db.execute("CREATE TABLE $_pdffavouriteTableName ($_pdffavouriteId INTEGER PRIMARY KEY,$_pdffavouriteName TEXT,$_pdffavouritePath TEXT)");
  }


  /// insertPDF-----------------------------------------------------------------

  Future<PdfFavouriteModel> fainsertPdf(PdfFavouriteModel pdfFavouriteModel) async
  {
    var dbClient = await db;

    pdfFavouriteModel.id = await dbClient!.insert(_pdffavouriteTableName, pdfFavouriteModel.toMap());

    return pdfFavouriteModel;
  }

  /// savedPDF------------------------------------------------------------------

  Future<List<PdfFavouriteModel>>fagetSavedPDFList()async
  {
    var dbClient = await db;

    List<Map> maps = await dbClient!.query(_pdffavouriteTableName,columns: [_pdffavouriteId,_pdffavouriteName,_pdffavouritePath]);

    List<PdfFavouriteModel>pdfList = [];

    if(maps.isNotEmpty)
    {

      for(int i = 0; i<maps.length; i++)
      {
        pdfList.add(PdfFavouriteModel.fromMap(Map<String,dynamic>.from(maps[i])));
      }
    }

    return pdfList;
  }


  /// deletePDF-----------------------------------------------------------------

  Future<int> fadeletePDF(int id) async
  {
    var dbClient = await db;

    return await dbClient!.delete(_pdffavouriteTableName,where: '$_pdffavouriteId = ?',whereArgs: [id]);
  }

  ///updatePDF------------------------------------------------------------------

  Future<int> faupdatePDF(PdfFavouriteModel pdfFavouriteModel) async
  {
    var dbClient = await db;

    return await dbClient!.update(_pdffavouriteTableName, pdfFavouriteModel.toMap(),
        where: '$_pdffavouriteId = ?',whereArgs: [pdfFavouriteModel.id]
    );
  }


  /// deleteAllPDF--------------------------------------------------------------

  Future<int> fadeleteAllPDF() async
  {
    var dbClient = await db;
    return await dbClient!.delete(_pdffavouriteTableName);
  }


}