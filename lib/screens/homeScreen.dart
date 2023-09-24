import 'package:flutter/material.dart';
import 'package:googles/provider/homeProvider.dart';
import 'package:googles/repo/apiCall.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  Future<void> fetchData(BuildContext context) async {
    await ApiCall().fetchUsers();
    await Provider.of<HomeProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final favProvider = Provider.of<HomeProvider>(context);

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: favProvider.usersList.length,
                      itemBuilder: (context, index) {
                        return Consumer<HomeProvider>(
                          builder: (context, value, child) => ListTile(
                            onTap: () {
                              if (value.selectedItem
                                  .contains(value.usersList[index]['name'])) {
                                value
                                    .removeItem(value.usersList[index]['name']);
                              } else {
                                value.addItem(value.usersList[index]['name']);
                              }
                            },
                            title: Text(value.usersList[index]['name']),
                            trailing: Icon(value.selectedItem
                                    .contains(value.usersList[index]['name'])
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
