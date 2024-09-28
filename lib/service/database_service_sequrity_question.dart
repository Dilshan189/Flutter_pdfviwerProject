import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../model/sequrity_question_model.dart';

class DatabaseServiceSequrityQuestion {

  static Database? _db;
  static const DB_Name = 'pdfABCDEF_db.db';

  final String _pdfSecurityTable = 'tblSecurity';
  final String _pdfSecurityId = 'id';
  final String _pdfSecurityTextName = 'textName';
  final String _pdfSecurityTextAnswer = 'textAnswer';

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
    await db.execute("CREATE TABLE $_pdfSecurityTable ($_pdfSecurityId INTEGER PRIMARY KEY,$_pdfSecurityTextName TEXT,$_pdfSecurityTextAnswer TEXT)");
  }

  Future<SecurityQuestionModel> insertSecurity(SecurityQuestionModel securityquestionModel) async
  {
    var dbClient = await db;
    securityquestionModel.id = await dbClient!.insert(_pdfSecurityTable, securityquestionModel.toMap());
    return securityquestionModel;
  }


  Future<List<SecurityQuestionModel>>getDataPdfList()async
  {
    var dbClient = await db;
    List<Map> maps = await dbClient!.query(_pdfSecurityTable,columns: [_pdfSecurityId,_pdfSecurityTextName,_pdfSecurityTextAnswer ]);

    List<SecurityQuestionModel>pdfList = [];

    if(maps.isNotEmpty)
      {
        for(int i = 0; i<maps.length;i++)
          {
            pdfList.add(SecurityQuestionModel.fromMap(Map<String,dynamic>.from(maps[i])));
          }
      }
    return pdfList;
  }

}