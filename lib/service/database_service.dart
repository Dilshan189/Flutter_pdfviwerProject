import 'package:path/path.dart';
import 'package:pdfviwer/model/task.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _pdfTableName = "pdf";
  final String _pdfIdColumnName = "id";
  final String _pdfContentColumnName = "content";
  final String _pdfStatusColumnName = "status";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_pdfTableName (
          $_pdfIdColumnName INTEGER PRIMARY KEY,
          $_pdfContentColumnName TEXT NOT NULL,
          $_pdfStatusColumnName INTEGER NOT NULL
        )
        ''');
      },
    );
    return database;
  }

  void addTask(String content, String filePath)
  async
  {
    final db = await database;
    await db.insert(
      _pdfTableName,
      {
        _pdfContentColumnName: content,
        _pdfStatusColumnName: filePath,
      },
    );
  }

  Future<List<PDF>> getTasks() async {
    final db = await database;
    final data = await db.query(_pdfTableName);
    List<PDF> tasks = data
        .map(
          (e) => PDF(
        id: e["id"] as int,
        filePath: e["status"] as String,
        fileName: e["content"] as String,
      ),
    )
        .toList();
    return tasks;
  }

  void updateTaskStatus(int id, int status) async {
    final db = await database;
    await db.update(
      _pdfTableName,
      {
        _pdfStatusColumnName : status,
      },
      where: 'id = ?',
      whereArgs: [
        id,
      ],
    );
  }

  void deleteTask(
      int id,
      ) async {
    final db = await database;
    await db.delete(
      _pdfTableName,
      where: 'id = ?',
      whereArgs: [
        id,
      ],
    );
  }
}
