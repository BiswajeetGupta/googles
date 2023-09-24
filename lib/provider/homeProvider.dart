// import 'package:flutter/material.dart';
// import 'package:googles/repo/apiCall.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeProvider with ChangeNotifier {
//   final List _selectedItems = [];
//   final ApiCall _api = ApiCall();

//   List _usersList = [];
//     List _usersListOf = [];

//   List get selectedItem => _selectedItems;

//   List get usersList => _usersList;
//     List get usersListOf => _usersListOf;

//   void addItem(value) {
//     _selectedItems.add(value);
//     notifyListeners();
//   }

//   void removeItem(value) {
//     _selectedItems.remove(value);
//     notifyListeners();
//   }

//   Future<void> fetchData() async {
//     _usersList.clear();
//     final users = await _api.fetchUsers();

//     _usersList.addAll(users);
//     saveUsersData();
//     notifyListeners();
//   }

//   // Deserialize and load data from SharedPreferences
//   void getUser(List<String> savedData) {
//     _usersList = savedData;
//     notifyListeners();
//   }

//   Future<void> saveUsersData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('usersList');
//     await prefs.setStringList(
//         'usersList', _usersList.map((data) => data.toString()).toList());
//   }

//   Future<void> loadOfflineData(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     final favProvider = Provider.of<HomeProvider>(context, listen: false);

//     final List<String>? savedData = prefs.getStringList('usersList');

//     if (savedData != null) {
//       // Deserialize the saved data if available
//       favProvider.loadUsersData(savedData);
//     } else {
//       // Handle the case where there is no saved data
//       // You can set a default value or take any other action
//       print('No saved data available in SharedPreferences.');
//     }
//   }

//    static connectiontesting(BuildContext context) {
//     InternetConnectionChecker().hasConnection.then((value) {
// if(value){

// }else{

// }

//     });
//     // InternetConnectionChecker().onStatusChange.listen((status) {
//     //   final value = status == InternetConnectionStatus.connected;
//     // });
//   }
// }

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

    // Simulate fetching data from an API
    await Future.delayed(Duration(seconds: 2));

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
