import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎶 Giggo', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF7B1FA2),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/img/home_1.jpeg', fit: BoxFit.cover),
          ),

          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Feel The Beat 🎶',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Manage concerts and experience music like never before.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text(
                'Get Started',
                style: TextStyle(color: Color.fromARGB(255, 234, 226, 235)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
