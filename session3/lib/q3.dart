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
      home: CategoryGridPage(),
    );
  }
}

class CategoryGridPage extends StatelessWidget {
  const CategoryGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // 2x2 grid
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: const [
            CategoryItem(
              title: 'Electronics',
              icon: Icons.devices,
            ),
            CategoryItem(
              title: 'Fashion',
              icon: Icons.checkroom,
            ),
            CategoryItem(
              title: 'Groceries',
              icon: Icons.shopping_cart,
            ),
            CategoryItem(
              title: 'Sports',
              icon: Icons.sports_soccer,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
