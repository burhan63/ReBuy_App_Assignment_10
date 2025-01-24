import 'package:ReBuyApp/features/home/screens/MenuButton.dart';
import 'package:flutter/material.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 120),
              painter: WavyCurvePainter(),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ReBuy",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MenuButton(
                icon: Icons.person_outline,
                title: "My Account",
                subtitle: "Edit your details, account settings",
                onTap: () {},
              ),
              MenuButton(
                icon: Icons.shopping_bag_outlined,
                title: "My Orders",
                subtitle: "View all your orders",
                onTap: () {},
              ),
              MenuButton(
                icon: Icons.list_alt,
                title: "My Listings",
                subtitle: "View your product listing for sale",
                onTap: () {},
              ),
              MenuButton(
                icon: Icons.favorite_border,
                title: "Liked Items",
                subtitle: "See the products you have wishlisted",
                onTap: () {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      "Feedback",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text(
                      "Sign out",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                "ReBuy Inc. Version 1.0",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class WavyCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.red.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = Colors.red.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = Colors.red.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    // First curve (higher)
    final path1 = Path();
    path1.moveTo(0, size.height * 0.4); // Start higher
    path1.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.4);
    path1.quadraticBezierTo(
        size.width * 0.75, size.height * 0.1, size.width, size.height * 0.4);
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Second curve (slightly higher)
    final path2 = Path();
    path2.moveTo(0, size.height * 0.6); // Start higher
    path2.quadraticBezierTo(size.width * 0.25, size.height * 0.3,
        size.width * 0.5, size.height * 0.6);
    path2.quadraticBezierTo(
        size.width * 0.75, size.height * 0.9, size.width, size.height * 0.6);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Third curve (higher and deeper)
    final path3 = Path();
    path3.moveTo(0, size.height * 0.7); // Start higher
    path3.quadraticBezierTo(size.width * 0.25, size.height * 1.2,
        size.width * 0.5, size.height * 0.7);
    path3.quadraticBezierTo(
        size.width * 0.75, size.height * 0.4, size.width, size.height * 0.7);
    path3.lineTo(size.width, size.height);
    path3.lineTo(0, size.height);
    path3.close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
