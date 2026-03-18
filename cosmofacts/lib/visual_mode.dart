import 'package:flutter/material.dart';
import 'dart:math' as math;

class VisualMode extends StatefulWidget {
  const VisualMode({super.key});

  @override
  State<VisualMode> createState() => _VisualModeState();
}

class _VisualModeState extends State<VisualMode> {
  late PageController _pageController;
  double _currentPage = 0.0;

  // Ensure these filenames match your 'assets' folder EXACTLY
  final List<Map<String, String>> visualPlanets = const [
    {"name": "MERCURY", "image": "assets/Mercury.avif"},
    {"name": "VENUS", "image": "assets/Venus.avif"},
    {"name": "EARTH", "image": "assets/Earth.jpg"},
    {"name": "MARS", "image": "assets/Mars.jpg"},
    {"name": "JUPITER", "image": "assets/Jupiter.jpg"},
    {"name": "SATURN", "image": "assets/Saturn.jpg"},
    {"name": "URANUS", "image": "assets/Uranus.jpg"},
    {"name": "NEPTUNE", "image": "assets/Neptune.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page ?? 0.0;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: visualPlanets.length,
        itemBuilder: (context, index) {
          double relativePosition = index - _currentPage;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective depth
              ..leftTranslate(relativePosition * 150.0, 0.0, 0.0) // 3D Slide
              ..rotateY(relativePosition * 0.8), // 3D Rotation
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        // Updated to modern Flutter color syntax
                        color: Colors.blueAccent.withValues(alpha: 0.3),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  // CRITICAL FIX: Changed from Image.network to Image.asset
                  child: ClipOval(
                    child: Image.asset(
                      visualPlanets[index]['image']!,
                      width: 280,
                      height: 280,
                      fit: BoxFit.cover,
                      // Safety net if a file is missing or misspelled
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.public,
                        color: Colors.white24,
                        size: 150,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  visualPlanets[index]['name']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 10,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}