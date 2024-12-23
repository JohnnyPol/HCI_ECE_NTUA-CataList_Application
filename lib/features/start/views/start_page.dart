import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA2A5D4),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // App title
              Column(
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'CataList',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF0A1172),
                      fontSize: 40,
                      fontFamily: 'Lobster',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 150),
                  // Decorative Circle
                  Container(
                    width: 200,
                    height: 82,
                    decoration: BoxDecoration(
                      color: const Color(0xFF63A9CC),
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                ],
              ),
              // Start button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/login'); // Route to login/register
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A1172),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
