
import 'package:flutter/material.dart';
import 'package:googles/repo/apiCall.dart';

class HomeProvider with ChangeNotifier {
  final List _selectedItems = [];
  final ApiCall _api = ApiCall();

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
  }
}




