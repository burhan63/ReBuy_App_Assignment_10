import 'package:flutter/material.dart';
import 'home_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Electronics',
      'icon': Icons.phone_android,
      'color': Colors.blue[100],
      'count': 24,
    },
    {
      'name': 'Furniture',
      'icon': Icons.chair,
      'color': Colors.orange[100],
      'count': 16,
    },
    {
      'name': 'Fashion',
      'icon': Icons.checkroom,
      'color': Colors.pink[100],
      'count': 32,
    },
    {
      'name': 'Gaming',
      'icon': Icons.sports_esports,
      'color': Colors.purple[100],
      'count': 12,
    },
    {
      'name': 'Appliances',
      'icon': Icons.kitchen,
      'color': Colors.green[100],
      'count': 18,
    },
    {
      'name': 'Books',
      'icon': Icons.book,
      'color': Colors.brown[100],
      'count': 45,
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_basketball,
      'color': Colors.red[100],
      'count': 28,
    },
    {
      'name': 'Beauty',
      'icon': Icons.face,
      'color': Colors.teal[100],
      'count': 22,
    },
  ];

  CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Browse products by category',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildCategoryCard(
                context,
                categories[index],
              ),
              childCount: categories.length,
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.only(bottom: 16),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> category) {
    return InkWell(
      onTap: () {
        // Navigate to home screen with selected category
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              initialCategory: category['name'] as String,
              initialTab: 0, // Home tab
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: category['color'] ?? Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category['icon'] as IconData,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 12),
            Text(
              category['name'] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${category['count']} items',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 