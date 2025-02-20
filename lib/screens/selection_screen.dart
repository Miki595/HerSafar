import 'package:flutter/material.dart';
import 'welcome_user_screen.dart'; // Import the WelcomeUserScreen


class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/welcomescreen.png', // Replace with your image
              height: 300,
            ),
            const SizedBox(height: 20),
            const Text(
              'Continue As:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Driver Option
            ElevatedButton(
              onPressed: () {
                // Navigate to the WelcomeUserScreen with userType as Driver
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeUserScreen(userType: 'Driver'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              child: const Text('Driver'),
            ),
            const SizedBox(height: 20),
            // Rider Option
            ElevatedButton(
              onPressed: () {
                // Navigate to the WelcomeUserScreen with userType as Rider
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeUserScreen(userType: 'Rider'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              child: const Text('Rider'),
            ),
          ],
        ),
      ),
    );
  }
}