import 'dart:io';

import 'package:path/path.dart';
import 'package:peliculas/src/models/fav_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';




class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if ( _database != null ) return _database;

    _database = await initDB();

    return _database;

  }

  Future<Database> initDB() async{

    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'ScansDB.db' );
    print( path );

    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) { },
      onCreate: ( Database db, int version ) async {

        await db.execute('''
          CREATE TABLE favorite(
            id INTEGER 
            
          )
        ''');
      }
    );

  }

  Future<int> nuevoScanRaw( int  id ) async {



    // Verificar la base de datos
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO favorite( id )
        VALUES( $id)
    ''');

    return res;
  }

  // Future<int> nuevoScan( ScanModel nuevoScan ) async {

  //   final db = await database;
  //   final res = await db.insert('Scans', nuevoScan.toJson() );

  //   // Es el ID del último registro insertado;
  //   return res;
  // }

  // Future<ScanModel> getScanById( int id ) async {

  //   final db  = await database;
  //   final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

  //   return res.isNotEmpty
  //         ? ScanModel.fromJson( res.first )
  //         : null;
  // }

  Future<List<Favorite>> getTodosLosScans() async {

    final db  = await database;
    final res = await db.query('favorite');

    return res.isNotEmpty
          ? res.map( (s) => Favorite.fromJson(s) ).toList()
          : [];
  }

  // Future<List<ScanModel>> getScansPorTipo( String tipo ) async {

  //   final db  = await database;
  //   final res = await db.rawQuery('''
  //     SELECT * FROM Scans WHERE tipo = '$tipo'    
  //   ''');

  //   return res.isNotEmpty
  //         ? res.map( (s) => ScanModel.fromJson(s) ).toList()
  //         : [];
  // }


  // Future<int> updateScan( ScanModel nuevoScan ) async {
  //   final db  = await database;
  //   final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [ nuevoScan.id ] );
  //   return res;
  // }

  Future<int> deleteScan( int id ) async {
    final db  = await database;
    final res = await db.delete( 'favorite', where: 'id = ?', whereArgs: [id] );
    return res;
  }

  Future<int> deleteAllScans() async {
    final db  = await database;
    final res = await db.rawDelete('''
      DELETE FROM favorite    
    ''');
    return res;
  }


}

