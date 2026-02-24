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
      home: const MovieSurveyPage(),
    );
  }
}

class MovieSurveyPage extends StatefulWidget {
  const MovieSurveyPage({super.key});

  @override
  State<MovieSurveyPage> createState() => _MovieSurveyPageState();
}

class _MovieSurveyPageState extends State<MovieSurveyPage> {
  final TextEditingController _movieController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  String _rating = 'Excellent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Feedback Survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Name
            TextField(
              controller: _movieController,
              decoration: const InputDecoration(
                labelText: 'Movie Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Feedback
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Rating
            DropdownButtonFormField<String>(
              value: _rating,
              decoration: const InputDecoration(
                labelText: 'Rating',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Excellent', child: Text('Excellent')),
                DropdownMenuItem(value: 'Good', child: Text('Good')),
                DropdownMenuItem(value: 'Average', child: Text('Average')),
                DropdownMenuItem(value: 'Poor', child: Text('Poor')),
              ],
              onChanged: (value) {
                setState(() {
                  _rating = value!;
                });
              },
            ),

            const SizedBox(height: 24),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final movie = _movieController.text;
                  final feedback = _feedbackController.text;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Submitted for "$movie" with rating $_rating',
                      ),
                    ),
                  );
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
