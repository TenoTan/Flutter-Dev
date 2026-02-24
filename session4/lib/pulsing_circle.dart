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
      home: PulseCircleDemo(),
    );
  }
}

class PulseCircleDemo extends StatefulWidget {
  const PulseCircleDemo({super.key});

  @override
  State<PulseCircleDemo> createState() => _PulseCircleDemoState();
}

class _PulseCircleDemoState extends State<PulseCircleDemo>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 🎯 AnimationController
    _controller = AnimationController(
      vsync: this, // from SingleTickerProviderStateMixin
      duration: const Duration(seconds: 2),
    );

    // 🎯 Tween<double>
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // 🔁 Loop animation (grow ↔ shrink)
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose(); // important!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AnimationController Demo"),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
