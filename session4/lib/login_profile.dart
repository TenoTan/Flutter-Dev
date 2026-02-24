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
      home: CrossFadeDemo(),
    );
  }
}

class CrossFadeDemo extends StatefulWidget {
  const CrossFadeDemo({super.key});

  @override
  State<CrossFadeDemo> createState() => _CrossFadeDemoState();
}

class _CrossFadeDemoState extends State<CrossFadeDemo> {
  bool isLoggedIn = false;

  void toggleView() {
    setState(() {
      isLoggedIn = !isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AnimatedCrossFade Demo"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            AnimatedCrossFade(
              duration: const Duration(seconds: 1), // 1 second
              crossFadeState: isLoggedIn
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,

              firstChild: ElevatedButton(
                onPressed: toggleView,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              secondChild: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person, size: 35),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Welcome, Nigga!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("alwaysaslave@email.com"),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Extra control button (optional)
            ElevatedButton(
              onPressed: toggleView,
              child: const Text("Toggle View"),
            ),
          ],
        ),
      ),
    );
  }
}
