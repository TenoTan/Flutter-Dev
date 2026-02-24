import 'package:flutter/material.dart';
import 'dart:math'; // for pi

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ManualRotateDemo(),
    );
  }
}

class ManualRotateDemo extends StatefulWidget {
  const ManualRotateDemo({super.key});

  @override
  State<ManualRotateDemo> createState() => _ManualRotateDemoState();
}

class _ManualRotateDemoState extends State<ManualRotateDemo>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // 1 full rotation duration
    );

    // 0 → 1 = 0° → 360°
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void rotateOnce() {
    _controller.reset();  // start from 0
    _controller.forward(); // rotate 360° once
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manual Rotation Control"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Rotation animation
            RotationTransition(
              turns: _rotationAnimation,
              child: const Icon(
                Icons.refresh,
                size: 120,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 30),

            // Control button
            ElevatedButton(
              onPressed: rotateOnce,
              child: const Text("Rotate 360°"),
            ),
          ],
        ),
      ),
    );
  }
}
