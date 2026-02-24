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
      home: OpacityDemo(),
    );
  }
}

class OpacityDemo extends StatefulWidget {
  const OpacityDemo({super.key});

  @override
  State<OpacityDemo> createState() => _OpacityDemoState();
}

class _OpacityDemoState extends State<OpacityDemo> {
  double opacityValue = 1.0; // initially visible

  void toggleOpacity() {
    setState(() {
      opacityValue = (opacityValue == 1.0) ? 0.0 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opacity Animation"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Animated opacity text
            AnimatedOpacity(
              opacity: opacityValue,
              duration: const Duration(milliseconds: 800), // 800 ms
              curve: Curves.easeInOut,
              child: const Text(
                "Welcome to Flutter Animations",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Toggle button
            ElevatedButton(
              onPressed: toggleOpacity,
              child: const Text("Toggle Opacity"),
            ),
          ],
        ),
      ),
    );
  }
}
