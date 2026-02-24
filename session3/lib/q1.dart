import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TECH HEADER + ANIMATED PROFILE
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF0F2027),
                        Color(0xFF203A43),
                        Color(0xFF2C5364),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.code,
                      color: Colors.white24,
                      size: 120,
                    ),
                  ),
                ),

                Positioned(
                  bottom: -50,
                  child: ScaleTransition(
                    scale: _animation,
                    child: CircleAvatar(
                      radius: 58,
                      backgroundColor: Colors.white,
                      child: const CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            const Text(
              'Alex Johnson',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Flutter Developer',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            const Divider(),

            const ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('alex.johnson@email.com'),
            ),
            const ListTile(
              leading: Icon(Icons.work),
              title: Text('Company'),
              subtitle: Text('Tech Solutions Ltd'),
            ),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location'),
              subtitle: Text('San Francisco, CA'),
            ),
          ],
        ),
      ),
    );
  }
}
