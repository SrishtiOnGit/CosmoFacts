// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'explore_page.dart'; 
import 'visual_mode.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FactsPage(),
  ));
}

class FactsPage extends StatefulWidget {
  const FactsPage({super.key});

  @override
  State<FactsPage> createState() => _FactsPageState();
}

class _FactsPageState extends State<FactsPage> {
  String currentFact = "Did you know? The largest volcano in the solar system is Olympus Mons on Mars...";
  int _currentIndex = 0;

  final List<String> shortFacts = [
    "Space is completely silent because there is no air to carry sound.",
    "One day on Venus is longer than one year on Earth.",
    "Neutron stars can spin 600 times per second.",
    "Footprints on the Moon will stay there for 100 million years.",
    "There is a planet made of diamonds called 55 Cancri e.",
    "The Sun is so big that 1.3 million Earths could fit inside it.",
    "The sunset on Mars appears blue to the human eye.",
    "There are more stars in the universe than grains of sand on Earth.",
    "Jupiter's Great Red Spot is a storm that has lasted for over 300 years.",
    "A NASA space suit costs roughly \$12 million."
  ];

  void getNextFact() {
    setState(() {
      shortFacts.shuffle();
      currentFact = shortFacts.first;
    });
  }

  @override
  void initState() {
    super.initState();
    getNextFact();
  }

  Widget buildHomeTab() {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Image.asset(
            'assets/Cosmic_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Hello!👋 Welcome to CosmoFacts",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(128),
                  border: Border.all(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(128),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(10.0),
                child: Text(
                  currentFact,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: getNextFact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Get New Fact", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      buildHomeTab(),
      const ExplorePage(), // Now showing the design from your other file
      const VisualMode(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: "Facts"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: "3D View"), // Renamed for your next goal
        ],
      ),
    );
  }
}