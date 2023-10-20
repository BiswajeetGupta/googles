import 'package:flutter/material.dart';
import 'package:googles/provider/homeProvider.dart';
import 'package:googles/repo/apiCall.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> fetchData(BuildContext context) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final apiCall = ApiCall();

    await apiCall.fetchUsers();
    await homeProvider.fetchData();
  }

  Future<void> loadOfflineData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final favProvider = Provider.of<HomeProvider>(context, listen: false);

    final List<String>? savedData = prefs.getStringList('usersList');

    if (savedData != null) {
      favProvider.loadUsersData();
    } else {
      print('No saved data available in SharedPreferences.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              loadOfflineData(context);
            }

            final favProvider = Provider.of<HomeProvider>(context);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: favProvider.usersList.length,
                    itemBuilder: (context, index) {
                      return Consumer<HomeProvider>(
                        builder: (context, value, child) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                value.usersList[index]['firstImage']),
                          ),
                          title: Text(value.usersList[index]['firstLabel']),
                          subtitle: Text(
                              value.usersList[index]['userId']['fullName']),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
