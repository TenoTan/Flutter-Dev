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
      home: MultiAnimationDemo(),
    );
  }
}

class MultiAnimationDemo extends StatefulWidget {
  const MultiAnimationDemo({super.key});

  @override
  State<MultiAnimationDemo> createState() => _MultiAnimationDemoState();
}

class _MultiAnimationDemoState extends State<MultiAnimationDemo>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 🎯 Single AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // 🎯 Slide Tween (bottom → center)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // from bottom
      end: Offset.zero,          // to normal position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // 🎯 Opacity Tween (fade in)
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // ▶ Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // important
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multi Animation Demo"),
        centerTitle: true,
      ),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation, // fade
          child: SlideTransition(
            position: _slideAnimation, // slide
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "Hello Flutter!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
