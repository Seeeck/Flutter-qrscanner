import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (database != null) _database;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'scansdb.db');

    //Crear base de datos

    return await openDatabase(path, version: 1,
        onCreate: (Database db, version) async {
      await db.execute('''

            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipo TEXT,
              valor TEXT
            )

            ''');
      print('TABLA SCANS CREADA');
    });
  }

  nuevoScanRaw(ScanModel scan) async {
    final Database db = await database;
    final id = scan.id;
    final tipo = scan.tipo;
    final valor = scan.valor;

    final res = db.rawInsert('''
    INSERT INTO Scans(id,tipo,valor) VALUES($id,'$tipo','$valor');
    ''');
    return res;
  }

  Future<int> nuevoScan(ScanModel scan) async {
    final db = await database;
    final res = await db
        .insert('Scans', scan.toJson())
        .whenComplete(() => print('insertado'));
    return res;
  }

  Future getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id=?', whereArgs: [id]);
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final tempDir = await getDatabasesPath();
    print(tempDir);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> getScansByTipo(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo=?', whereArgs: [tipo]);
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future updateScan(int id) async {
    final db = await database;
    final res = await db
        .update('Scans', {'valor': 'http://wea400000000.com', 'tipo': 'http'},
            where: 'id=?', whereArgs: [id])
        .whenComplete(() => print('acutalizado'));

    return res;
  }

  Future deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans',
        where: 'id=?',
        whereArgs: [id]).whenComplete(() => print("Scan borrado"));

    return res;
  }

  Future deleteAllScan() async {
    final db = await database;

    await db.rawDelete('''
     DELETE FROM SCANS;
     ''');
  }
}
