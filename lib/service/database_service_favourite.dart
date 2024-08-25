import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../model/pdf_favourite_model.dart';

class DatabaseService {
  static Database? _db;
  static const DB_Name = 'pdfFa_db.db';

  final String _pdfTableNameFa = 'tblPdfFa';
  final String _pdfIdFa = 'id';
  final String _pdfNameFa = 'fileName';
  final String _pdfPathFa = 'filePath';
  final String _pdfSizeFa = 'size';
  final String _pdfModifiedDateFa = 'modifiedDate';

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_Name);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $_pdfTableNameFa ($_pdfIdFa INTEGER PRIMARY KEY,"
        "$_pdfNameFa TEXT,"
        "$_pdfPathFa TEXT,"
        "$_pdfSizeFa TEXT,"
        "$_pdfModifiedDateFa TEXT)");
  }

  Future<PDFModelFa> insertPdffa(PDFModelFa pdfModelFa) async {

    var dbClient = await db;

    pdfModelFa.id = await dbClient!.insert(_pdfTableNameFa, pdfModelFa.toMap());

    return pdfModelFa;
  }


  Future<List<PDFModelFa>> getSavedPDFListfa() async {

    var dbClient = await db;

    List<Map> maps = await dbClient!.query(_pdfTableNameFa,

        columns: [_pdfIdFa, _pdfNameFa, _pdfPathFa, _pdfSizeFa, _pdfModifiedDateFa]);

    List<PDFModelFa> pdfList = [];

    if (maps.isNotEmpty)
    {
      for (int i = 0; i < maps.length; i++) {
        pdfList.add(PDFModelFa.fromMap(Map<String, dynamic>.from(maps[i])));
      }

    }
    return pdfList;
  }

  Future<int> deletePDFfa(int id) async {

    var dbClient = await db;

    return await dbClient!

        .delete(_pdfTableNameFa, where: '$_pdfIdFa = ?', whereArgs: [id]);
  }

  Future<int> updatePDFfa(PDFModelFa pdfModelFa) async {

    var dbClient = await db;

    return await dbClient!.update(_pdfTableNameFa, pdfModelFa.toMap(),

        where: '$_pdfIdFa = ?', whereArgs: [pdfModelFa.id]);
  }

  Future<int> deleteAllPDFfa() async {

    var dbClient = await db;

    return await dbClient!.delete(_pdfTableNameFa);

  }


  Future<bool> pdfExistsFa(String filePath) async {

    var  dbClient = await db;

    var result = await dbClient!.query(
      _pdfTableNameFa,
      where: '$_pdfPathFa = ?',
      whereArgs: [filePath],
    );

    return result.isNotEmpty;
  }


}
