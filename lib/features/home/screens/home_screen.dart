import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../features/cart/controllers/cart_controller.dart';
import '../../../features/cart/screens/cart_screen.dart';
import '../../../features/product/screens/product_details_screen.dart';
import '../../../features/product/models/product.dart';
import '../../../features/home/screens/categories_screen.dart';
import '../../../features/profile/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? initialCategory;
  final int initialTab;

  const HomeScreen({
    Key? key, 
    this.initialCategory,
    this.initialTab = 0,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;
  int _selectedIndex = 0;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _selectedIndex = widget.initialTab;
  }

  // Updated dummy data with more reliable image URLs
  static final List<Product> _products = [
    Product(
      id: '1',
      name: 'Nike Air Max',
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80',
      price: 129.99,
      description: 'Comfortable running shoes with air cushioning.',
      category: 'Fashion',
    ),
    Product(
      id: '2',
      name: 'Wireless Headphones',
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80',
      price: 89.99,
      description: 'High-quality wireless headphones with noise cancellation.',
      category: 'Electronics',
    ),
    Product(
      id: '3',
      name: 'Gaming Chair',
      imageUrl: 'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=500&q=80',
      price: 199.99,
      description: 'Ergonomic gaming chair with lumbar support.',
      category: 'Furniture',
    ),
    Product(
      id: '4',
      name: 'PS5 Controller',
      imageUrl: 'https://images.unsplash.com/photo-1606318801954-d46d46d3360a?w=500&q=80',
      price: 69.99,
      description: 'Next-gen gaming controller with haptic feedback.',
      category: 'Gaming',
    ),
    Product(
      id: '5',
      name: 'Coffee Maker',
      imageUrl: 'https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=500&q=80',
      price: 79.99,
      description: 'Programmable coffee maker with timer.',
      category: 'Appliances',
    ),
    Product(
      id: '6',
      name: 'Smart TV',
      imageUrl: 'https://images.unsplash.com/photo-1593784991095-a205069470b6?w=500&q=80',
      price: 599.99,
      description: '4K Smart TV with HDR support.',
      category: 'Electronics',
    ),
    Product(
      id: '7',
      name: 'Denim Jacket',
      imageUrl: 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=500&q=80',
      price: 59.99,
      description: 'Classic denim jacket with modern fit.',
      category: 'Fashion',
    ),
    Product(
      id: '8',
      name: 'Sofa Set',
      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&q=80',
      price: 899.99,
      description: '3-piece modern sofa set.',
      category: 'Furniture',
    ),
    Product(
      id: '9',
      name: 'Gaming Console',
      imageUrl: 'https://images.unsplash.com/photo-1605901309584-818e25960a8f?w=500&q=80',
      price: 499.99,
      description: 'Next-gen gaming console.',
      category: 'Gaming',
    ),
    Product(
      id: '10',
      name: 'Microwave Oven',
      imageUrl: 'https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?w=500&q=80',
      price: 129.99,
      description: 'Smart microwave with multiple cooking modes.',
      category: 'Appliances',
    ),
  ];

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.phone_android, 'name': 'Electronics'},
    {'icon': Icons.chair, 'name': 'Furniture'},
    {'icon': Icons.checkroom, 'name': 'Fashion'},
    {'icon': Icons.sports_esports, 'name': 'Gaming'},
    {'icon': Icons.kitchen, 'name': 'Appliances'},
  ];

  List<Product> get _filteredProducts {
    return _products.where((product) {
      final matchesCategory = _selectedCategory == null || 
                            product.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
                          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          product.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Update the category item builder
  Widget _buildCategoryItem(Map<String, dynamic> category) {
    final isSelected = category['name'] == _selectedCategory;
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Toggle selection
            if (_selectedCategory == category['name']) {
              _selectedCategory = null; // Deselect if already selected
            } else {
              _selectedCategory = category['name'] as String;
            }
          });
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                category['icon'] as IconData,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category['name'] as String,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : null,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abdullah Commerce'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              Consumer<CartController>(
                builder: (context, cart, _) {
                  if (cart.items.isEmpty) return const SizedBox.shrink();
                  return Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cart.items.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              setState(() {
                _selectedIndex = 3; // Switch to profile tab
              });
              // Force rebuild to ensure tab switch
              if (mounted) {
                Future.microtask(() {
                  setState(() {});
                });
              }
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        sizing: StackFit.expand,
        children: [
          // Home Tab
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SearchBar(
                    hintText: 'Search products...',
                    leading: const Icon(Icons.search),
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                      child: Text(
                        _selectedCategory ?? 'All Products',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) => _buildCategoryItem(_categories[index]),
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildProductCard(context, _filteredProducts[index]),
                    childCount: _filteredProducts.length,
                  ),
                ),
              ),
            ],
          ),
          // Categories Tab
          CategoriesScreen(),
          // Cart Tab
          CartScreen(),
          // Profile Tab
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: NavigationBar(
              height: 65,
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedIndex: _selectedIndex,
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: [
                _buildNavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: 'Home',
                  isSelected: _selectedIndex == 0,
                ),
                _buildNavItem(
                  icon: Icons.category_outlined,
                  selectedIcon: Icons.category,
                  label: 'Categories',
                  isSelected: _selectedIndex == 1,
                ),
                _buildNavItem(
                  icon: Icons.shopping_cart_outlined,
                  selectedIcon: Icons.shopping_cart,
                  label: 'Cart',
                  isSelected: _selectedIndex == 2,
                  badge: Consumer<CartController>(
                    builder: (context, cart, _) {
                      if (cart.items.isEmpty) return const SizedBox.shrink();
                      return Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
                _buildNavItem(
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  label: 'Profile',
                  isSelected: _selectedIndex == 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section with fixed height ratio
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.favorite_border, size: 16),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 32,
                          child: ElevatedButton(
                            onPressed: () {
                              final cart = context.read<CartController>();
                              cart.addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Added to cart'),
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  NavigationDestination _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isSelected,
    Widget? badge,
  }) {
    return NavigationDestination(
      icon: Stack(
        children: [
          Icon(
            icon,
            size: isSelected ? 28 : 24,
            color: isSelected 
                ? Theme.of(context).primaryColor
                : Colors.grey[600],
          ),
          if (badge != null)
            Positioned(
              right: -4,
              top: -4,
              child: badge,
            ),
        ],
      ),
      selectedIcon: Stack(
        children: [
          Icon(
            selectedIcon,
            size: 28,
            color: Theme.of(context).primaryColor,
          ),
          if (badge != null)
            Positioned(
              right: -4,
              top: -4,
              child: badge,
            ),
        ],
      ),
      label: label,
    );
  }
} 