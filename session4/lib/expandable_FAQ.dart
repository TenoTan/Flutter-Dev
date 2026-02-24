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
      home: QAExpansionDemo(),
    );
  }
}

class QAExpansionDemo extends StatefulWidget {
  const QAExpansionDemo({super.key});

  @override
  State<QAExpansionDemo> createState() => _QAExpansionDemoState();
}

class _QAExpansionDemoState extends State<QAExpansionDemo>
    with TickerProviderStateMixin {

  bool isExpanded = false;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crossfade Q&A"),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: toggleExpand,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 400), // bonus smoothness
            curve: Curves.easeInOut,
            child: AnimatedCrossFade(
              duration: const Duration(seconds: 1),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,

              firstChild: _questionOnlyCard(),

              secondChild: _questionAnswerCard(),
            ),
          ),
        ),
      ),
    );
  }

  // Compact view
  Widget _questionOnlyCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "What is Flutter?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Expanded view
  Widget _questionAnswerCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What is Flutter?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Flutter is an open-source UI framework by Google used to build "
                ,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
