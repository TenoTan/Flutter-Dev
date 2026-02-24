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
      home: AnimatedCardDemo(),
    );
  }
}

class AnimatedCardDemo extends StatefulWidget {
  const AnimatedCardDemo({super.key});

  @override
  State<AnimatedCardDemo> createState() => _AnimatedCardDemoState();
}

class _AnimatedCardDemoState extends State<AnimatedCardDemo> {
  bool isRight = false;

  void animateCard() {
    setState(() {
      isRight = !isRight; // toggle state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Card"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: animateCard, // Tap anywhere
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: AnimatedAlign(
            alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,

              // BONUS: Animated margin
              margin: isRight
                  ? const EdgeInsets.all(30)
                  : const EdgeInsets.all(10),

              width: 180,
              height: 120,

              decoration: BoxDecoration(
                color: Colors.blueAccent,

                // Border radius animation
                borderRadius: BorderRadius.circular(isRight ? 30 : 0),

                // Shadow animation
                boxShadow: isRight
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  )
                ]
                    : [],
              ),

              child: const Center(
                child: Text(
                  "Tap Me",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
