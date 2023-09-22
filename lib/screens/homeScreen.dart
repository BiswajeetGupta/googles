import 'package:flutter/material.dart';
import 'package:googles/provider/homeProvider.dart';
import 'package:googles/repo/apiCall.dart';
import 'package:googles/screens/profile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();

  //   ApiCall().fetchUsers();

  //   Provider.of<HomeProvider>(context, listen: false).fetchData();
  // }


  @override
  void initState() {
    super.initState();

    _loadDataBasedOnConnectivity();
  }

  Future<void> _loadDataBasedOnConnectivity() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    
    try {
      await homeProvider.checkAndLoadData();
    } catch (e) {
      // Handle any exceptions here, e.g., show an error message
      print('Error loading data: $e');
    }
  }

  Widget build(BuildContext context) {
    final favProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: 
        
        
        Column(
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
                          value.removeItem(value.usersList[index]['name']);
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
        ),
      ),
    );
  }
}
