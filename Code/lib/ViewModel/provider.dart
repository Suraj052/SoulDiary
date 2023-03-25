

import 'package:flutter/material.dart';

import '../Database/sqFlite.dart';

class DiaryProvider extends ChangeNotifier
{

  List<Map<String,dynamic>> diaryList = [];

  bool isLoading = false;

  void getDiary() async
  {
    isLoading = true;
    notifyListeners();

    final data = await SQL.getItems();
    diaryList = data;

    isLoading = false;
    notifyListeners();
  }

  Future<void> addDiary(String title,String content) async
  {
    isLoading = true;
    notifyListeners();

    await SQL.createItem(title, content);
    getDiary();

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateDiary(int id,String title,String content) async
  {
    isLoading = true;
    notifyListeners();

    await SQL.updateItem(id,title,content);
    getDiary();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteDiary(int id) async
  {
    isLoading = true;
    notifyListeners();

    await SQL.deleteItem(id);
    getDiary();

    isLoading = false;
    notifyListeners();
  }
}