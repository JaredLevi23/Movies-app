import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'db_tables.dart';

class DbLocal{

  Future<Database> initDB() async{

    //Path de donde se almacenara la base de datos
    Directory directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/movies.db';

    //Crear la base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db)async{
        await db.execute( DBTables.favoritesTable );
        await db.execute( DBTables.searchsTable );
        await db.execute( DBTables.moviesTable );
      },
      onCreate: ( Database db, int version )async{
        await db.execute( DBTables.favoritesTable );
        await db.execute( DBTables.searchsTable );
        await db.execute( DBTables.moviesTable );
      }
    );
  }

  
}