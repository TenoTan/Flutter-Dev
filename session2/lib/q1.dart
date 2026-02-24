import 'package:flutter/material.dart';

void main() {
  runApp(const MyProfileApp());
}

class MyProfileApp extends StatelessWidget {
  const MyProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 60),
            ),
            SizedBox(height: 20),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('Name'),
              subtitle: Text('John Doe'),
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('Designation'),
              subtitle: Text('Software Engineer'),
            ),
            ListTile(
              leading: Icon(Icons.business),
              title: Text('Company'),
              subtitle: Text('ABC Technologies'),
            ),
            ListTile(
              leading: Icon(Icons.timeline),
              title: Text('Experience'),
              subtitle: Text('3 Years'),
            ),
          ],
        ),
      ),
    );
  }
}
