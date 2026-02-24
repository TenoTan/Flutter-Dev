import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AnimatedBoxPage(),
    );
  }
}

class AnimatedBoxPage extends StatefulWidget {
  const AnimatedBoxPage({super.key});

  @override
  State<AnimatedBoxPage> createState() => _AnimatedBoxPageState();
}

class _AnimatedBoxPageState extends State<AnimatedBoxPage> {
  // Initial values
  double boxSize = 100;
  Color boxColor = Colors.blue;

  void animateBox() {
    setState(() {
      // Toggle size
      boxSize = (boxSize == 100) ? 200 : 100;

      // Toggle color
      boxColor = (boxColor == Colors.blue) ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AnimatedContainer Demo"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Animated Square Container
            AnimatedContainer(
              width: boxSize,
              height: boxSize,
              duration: const Duration(seconds: 1), // 1 second
              curve: Curves.easeInOut, // animation curve
              color: boxColor,
            ),

            const SizedBox(height: 30),

            // Button
            ElevatedButton(
              onPressed: animateBox,
              child: const Text("Animate Box"),
            ),
          ],
        ),
      ),
    );
  }
}
