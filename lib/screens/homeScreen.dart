// import 'package:flutter/material.dart';
// import 'package:googles/provider/homeProvider.dart';
// import 'package:googles/repo/apiCall.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key});

//   Future<void> fetchData(BuildContext context) async {
// final homeProvider = Provider.of<HomeProvider>(context, listen: false);
//     final apiCall = ApiCall();
//     await apiCall.fetchUsers();
//     await homeProvider.fetchData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: FutureBuilder(
//           future: fetchData(context),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//               final favProvider = Provider.of<HomeProvider>(context);

//               if (favProvider.usersList.isEmpty) {
//                 // If the usersList is empty (no internet connection or data fetched yet)
//                 // Try loading data from SharedPreferences
//                 // loadOfflineData(context);
//               }

//               return Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: favProvider.usersList.length,
//                       itemBuilder: (context, index) {
//                         return Consumer<HomeProvider>(
//                           builder: (context, value, child) => ListTile(
//                             onTap: () {
//                               if (value.selectedItem
//                                   .contains(value.usersList[index]['name'])) {
//                                 value
//                                     .removeItem(value.usersList[index]['name']);
//                               } else {
//                                 value.addItem(value.usersList[index]['name']);
//                               }
//                             },
//                             title: Text(value.usersList[index]['name']),
//                             trailing: Icon(value.selectedItem
//                                     .contains(value.usersList[index]['name'])
//                                 ? Icons.favorite
//                                 : Icons.favorite_outline_outlined),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:googles/provider/homeProvider.dart';
import 'package:googles/repo/apiCall.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

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
    // Deserialize the saved data if available
    favProvider.loadUsersData(); // Remove the argument here
  } else {
    // Handle the case where there is no saved data
    // You can set a default value or take any other action
    print('No saved data available in SharedPreferences.');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // An error occurred while fetching data from the internet.
              // Try to load data from SharedPreferences.
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
          },
        ),
      ),
    );
  }
}
