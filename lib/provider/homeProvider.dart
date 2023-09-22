import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:googles/repo/apiCall.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; 

class HomeProvider with ChangeNotifier {
  final List _selectedItems = [];
  final ApiCall _api = ApiCall();
  final DatabaseManager _dbManager = DatabaseManager();

  List _usersList = [];

  List get selectedItem => _selectedItems;

  List get usersList => _usersList;

  void addItem(value) {
    _selectedItems.add(value);
    notifyListeners();
  }

  void removeItem(value) {
    _selectedItems.remove(value);
    notifyListeners();
  }

  Future<void> fetchData() async {
    _usersList.clear();
    final users = await _api.fetchUsers();

    _usersList.addAll(users);
    notifyListeners();

    // Save the fetched users to the local database
    for (var user in users) {
      await _dbManager.insertUser({
        'name': user.name,
        'email': user.email,
      });
    }
  }

  Future<void> loadLocalData() async {
    // Load data from the local database
    final localUsers = await _dbManager.getUsers();
    _usersList.clear();
    _usersList.addAll(localUsers);
    notifyListeners();
  }


  Future<void> checkAndLoadData() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection, load data from the local database
      await loadLocalData();
    } else {
      // Internet connection is available, fetch and load data
      await fetchData();
    }
  }
}






class DatabaseManager {
  Database? _database;

  Future<void> initializeDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = join(directory.path, 'your_database_name.db'); // Use join to create the database path

    _database = await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT
      )
    ''');
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    await _database!.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    return await _database!.query('users');
  }
}
