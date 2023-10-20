

import 'package:flutter/material.dart';
import 'package:googles/repo/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {
  final List<String> _selectedItems = [];
  final List _usersList = [];
  bool _isLoading = false;
  final ApiCall _api = ApiCall();
  List<String> get selectedItem => _selectedItems;
  List get usersList => _usersList;
  bool get isLoading => _isLoading;

  void addItem(String value) {
    _selectedItems.add(value);
    notifyListeners();
    saveSelectedItems();
  }

  void removeItem(String value) {
    _selectedItems.remove(value);
    notifyListeners();
    saveSelectedItems();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    _usersList.clear();
    final users = await _api.fetchUsers();

    _usersList.addAll(users);

    _isLoading = false;
    notifyListeners();

    saveUsersData();
  }

  Future<void> saveSelectedItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedItems', _selectedItems);
  }

  Future<void> saveUsersData() async {
    final prefs = await SharedPreferences.getInstance();
    final usersData = _usersList.map((user) => user['name'] as String).toList();
    await prefs.setStringList('usersList', usersData);
  }

  Future<void> loadUsersData() async {
    final prefs = await SharedPreferences.getInstance();
    final usersData = prefs.getStringList('usersList');
    if (usersData != null) {
      _usersList.clear();
      _usersList.addAll(usersData.map((data) => {'name': data}));
      notifyListeners();
    }
  }

  Future<void> loadSelectedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedItems = prefs.getStringList('selectedItems');
    if (selectedItems != null) {
      _selectedItems.clear();
      _selectedItems.addAll(selectedItems);
      notifyListeners();
    }
  }
}
