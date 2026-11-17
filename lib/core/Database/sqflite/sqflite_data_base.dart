import 'dart:async';

import 'package:drosak_app/core/Database/sqflite/crud.dart';
import 'package:sqflite/sqflite.dart' as sqfliteDatabase;
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class SqfliteDataBase extends Crud {
  static const String educationStagetable = "educationStagetable";
  static const String educationStageId = "educationStageId";
  static const String educationStageName = "educationStageName";
  static const String educationStageDesc = "educationStageDesc";
  static const String educationStageImage = "educationStageImage";
  static const String educationalStageCreatedAt = "educationalStageCreatedAt";
  static const String educationalStageStatus = "educationalStageStatus";
  ///////////////////////group_table/////////////////////////
  static const String groupsTable = "groupTable";
  static const String groupsId = "groupId";
  static const String groupsName = "groupName";

  static const String groupsNote = "groupNote";
  static const String groupsEducationId = "groupEducationId";

  ////////////////////////appointment_table///////////////////
  static const String appointmentTable = "appointmentTable";
  static const String appointmentId = "appointmentId";
  static const String appointmentTime = "appointmentTime";
  static const String appointmentDay = "appointmentDay";
  static const String appointmentMS = "appointmentMS";
  static const String appointmentGroupsId = "appointmentGroupsId";

  Database? db;
  initDataBase() async {
    String dbPath = await sqfliteDatabase.getDatabasesPath();
    String dpName = "drosak_database_managment.db";
    String realDbPath = join(dbPath, dpName);
    int version = 3;
    db ??= await sqfliteDatabase.openDatabase(
      realDbPath,
      version: version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
    );
  }

  Future<void> _onOpen(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
    
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        "ALTER TABLE $educationStagetable ADD COLUMN $educationalStageCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP",
      );
      if (oldVersion < 3) {
        await db.execute(
          "ALTER TABLE $educationStagetable ADD COLUMN $educationalStageStatus INTEGER DEFAULT 1 ",
        );
      }
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $educationStagetable ($educationStageId INTEGER PRIMARY KEY AUTOINCREMENT,$educationStageName TEXT , educationStageDesc TEXT ,$educationStageImage TEXT,  $educationalStageCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,$educationalStageStatus INTEGER DEFAULT 1)",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $groupsTable ($groupsId INTEGER PRIMARY KEY AUTOINCREMENT, $groupsName TEXT , $groupsNote TEXT , $groupsEducationId  INTEGER)",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $appointmentTable ($appointmentId INTEGER PRIMARY KEY AUTOINCREMENT , $appointmentDay  TEXT , $appointmentTime TEXT , $appointmentMS  TEXT , $appointmentGroupsId INTEGER , CONSTRAINT group_appointment FOREIGN KEY ($appointmentGroupsId) REFERENCES $groupsTable ($groupsId) ON DELETE CASCADE ON UPDATE CASCADE )",
    );
  }

  @override
  Future<bool> insert(String table, Map<String, Object?> values) async {
    await initDataBase();
    int inserted = await db!.insert(table, values);
    return inserted > 0 ? true : false;
  }

  Future<int> insertId(String table, Map<String, Object?> values) async {
    await initDataBase();
    int inserted = await db!.insert(table, values);
    return inserted;
  }

  @override
  Future<List<Map<String, Object?>>> select({
    required String table,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    await initDataBase();
    List<Map<String, Object?>> data = await db!.query(
      table,
      where: where,
      whereArgs: whereArgs,
    );
    db!.close();
    return data;
  }

  @override
  Future<List<Map<String, Object?>>> search(
    String word,
    String columnName,
    String tableName,
  ) async {
    // TODO: implement search
    await initDataBase();
    List<Map<String, Object?>> data = await db!.query(
      tableName,
      where: "$columnName like ?",
      whereArgs: ["%$word%"],
    );
    return data;
  }

  Future<List<Map<String, Object?>>> searchId(
    String word,
    String columnName,
    String tableName,
  ) async {
    // TODO: implement search
    await initDataBase();
    List<Map<String, Object?>> data = await db!.query(
      tableName,
      where: "$columnName == ?",
      whereArgs: [word],
    );
    return data;
  }

  @override
  Future<bool> update(
    String tableName,
    Map<String, Object?> values,
    String? where,
    List<Object?>? whereArgs,
  ) async {
    // TODO: implement update
    await initDataBase();
    int update = await db!.update(
      tableName,
      values,
      where: where,
      whereArgs: whereArgs,
    );
    return update > 0 ? true : false;
  }

  @override
  Future<bool> delete(
    String tableName,

    String? where,
    List<Object?>? whereArgs,
  ) async {
    // TODO: implement delete
    await initDataBase();
    int deleted = await db!.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
    return deleted > 0 ? true : false;
  }
}
