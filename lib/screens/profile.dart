import 'package:flutter/material.dart';



class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),
          const CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(
                'https://example.com/your-profile-image-url.jpg'),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20.0),
          const ListTile(
            leading: Icon(Icons.email),
            title: Text('johndoe@example.com'),
          ),
          const ListTile(
            leading: Icon(Icons.phone),
            title: Text('+1 (123) 456-7890'),
          ),
          const ListTile(
            leading: Icon(Icons.location_on),
            title: Text('New York, USA'),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Implement edit profile functionality
            },
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}