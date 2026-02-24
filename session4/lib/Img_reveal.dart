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
      home: FadeStackDemo(),
    );
  }
}

class FadeStackDemo extends StatefulWidget {
  const FadeStackDemo({super.key});

  @override
  State<FadeStackDemo> createState() => _FadeStackDemoState();
}

class _FadeStackDemoState extends State<FadeStackDemo> {
  bool showImage = false;

  void toggleFade() {
    setState(() {
      showImage = !showImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opacity + Layout"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Stack for overlaying widgets
            Stack(
              alignment: Alignment.center,
              children: [

                // Placeholder icon
                AnimatedOpacity(
                  opacity: showImage ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  child: const Icon(
                    Icons.image_outlined,
                    size: 120,
                    color: Colors.grey,
                  ),
                ),

                // Image
                AnimatedOpacity(
                  opacity: showImage ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  child: Image.network(
                    "https://images.unsplash.com/photo-1522202176988-66273c2fd55f",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Button
            ElevatedButton(
              onPressed: toggleFade,
              child: const Text("Load Image"),
            ),
          ],
        ),
      ),
    );
  }
}
