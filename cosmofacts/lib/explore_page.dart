import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  // Ensure these filenames match your 'assets' folder EXACTLY (Caps and extensions)
  final List<Map<String, String>> planetData = const [
    {
      "name": "Mercury",
      "image": "assets/Mercury.avif", 
      "dist": "57.9M km",
      "grav": "3.7 m/s²",
      "desc": "The smallest planet in our solar system."
    },
    {
      "name": "Venus",
      "image": "assets/Venus.avif",
      "dist": "108.2M km",
      "grav": "8.87 m/s²",
      "desc": "The hottest planet in our system."
    },
    {
      "name": "Earth",
      "image": "assets/Earth.jpg",
      "dist": "149.6M km",
      "grav": "9.8 m/s²",
      "desc": "Our home planet, the only one with life."
    },
    {
      "name": "Mars",
      "image": "assets/Mars.jpg",
      "dist": "227.9M km",
      "grav": "3.7 m/s²",
      "desc": "The Red Planet, home to vast deserts."
    },
    {
      "name": "Jupiter",
      "image": "assets/Jupiter.jpg",
      "dist": "778.5M km",
      "grav": "24.79 m/s²",
      "desc": "The largest gas giant in the solar system."
    },
    {
      "name": "Saturn",
      "image": "assets/Saturn.jpg",
      "dist": "1.4B km",
      "grav": "10.44 m/s²",
      "desc": "Famous for its stunning icy rings."
    },
    {
      "name": "Uranus",
      "image": "assets/Uranus.jpg",
      "dist": "2.9B km",
      "grav": "8.69 m/s²",
      "desc": "An ice giant that rotates on its side."
    },
    {
      "name": "Neptune",
      "image": "assets/Neptune.jpg",
      "dist": "4.5B km",
      "grav": "11.15 m/s²",
      "desc": "The most distant, dark, and cold planet."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Color(0xFF0D1B2A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(15, 60, 15, 20), // Adjusted top padding
        itemCount: planetData.length,
        itemBuilder: (context, index) {
          final planet = planetData[index];
          
          return GestureDetector(
            onTap: () {
              // Future: Navigate to detail page
              print("Clicked ${planet['name']}");
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 25),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(15), // Softer transparency
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withAlpha(30)),
              ),
              child: Row(
                children: [
                  // Hero widget for smooth transitions later
                  Hero(
                    tag: 'hero-${planet['name']}', 
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        planet['image']!,
                        fit: BoxFit.contain,
                        // This handles the "File Not Found" error gracefully
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image, 
                            color: Colors.redAccent, 
                            size: 50
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          planet['name']!.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          planet['desc']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70, 
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            _buildStatIcon(Icons.room_outlined, planet['dist']!, Colors.blueAccent),
                            const SizedBox(width: 20),
                            _buildStatIcon(Icons.scuba_diving, planet['grav']!, Colors.orangeAccent),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatIcon(IconData icon, String value, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(
          value, 
          style: TextStyle(
            color: Colors.white, // Changed to white for better readability
            fontSize: 12, 
            fontWeight: FontWeight.w500
          )
        ),
      ],
    );
  }
}