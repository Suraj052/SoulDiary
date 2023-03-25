import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQL{

  static Future<void> createTables(sql.Database database) async
  {
    await database.execute("""
        CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        day TEXT NOT NULL,
        month TEXT NOT NULL,
        time TEXT NOT NULL
        )""");
  }

  static Future<sql.Database> db() async
  {
    return sql.openDatabase(""
      "diarysmile.db",
      version: 1,
      onCreate: (sql.Database database, int version) async
        {
          print("....CREATING TABLE....");
          await createTables(database);
        }
    );
  }

  static Future<int> createItem(String title, String content) async
  {
    final db = await SQL.db();
    final data = {
      'title' : title,
      'content':content,
      'day': DateFormat.d().format(DateTime.now()),
      'month' : DateFormat.MMM().format(DateTime.now()),
      'time' : DateFormat.jm().format(DateTime.now())
    };
    final id = await db.insert('items',data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    showToast("Successfully Added");
    return id;
  }

  static Future<List<Map<String,dynamic>>> getItems() async
  {
    final db = await SQL.db();
    return db.query('items',orderBy: 'id DESC');
  }

  static Future<List<Map<String,dynamic>>> getItem(int id) async
  {
    final db = await SQL.db();
    return db.query('items',where : "id=?", whereArgs: [id],limit: 1);
  }

  static Future<int> updateItem(
      int id,String title,String content) async
  {
    final db = await SQL.db();
    final data = {
      'title' : title,
      'content':content,
      'day': DateFormat.d().format(DateTime.now()),
      'month' : DateFormat.MMM().format(DateTime.now()),
      'time' : DateFormat.jm().format(DateTime.now())
    };

    final result = await db.update('items',data, where: "id=?",whereArgs: [id]);
    showToast("Successfully Updated");
    return result;
  }

  static Future<void> deleteItem(int id) async
  {
    final db = await SQL.db();
    try{
      await db.delete("items",where: "id=?",whereArgs: [id]);
      showToast("Successfully Deleted");
    }
    catch(err)
    {
      showToast("Unable to delete");
      debugPrint("Something went wrong ! : $err");
    }
  }
}

void showToast(String text) => Fluttertoast.showToast
  (
  msg: text,
  fontSize: 13.0,
  backgroundColor: HexColor("#25262d"),
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);