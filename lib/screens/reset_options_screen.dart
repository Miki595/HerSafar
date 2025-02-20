import 'package:flutter/material.dart';

class ResetOptionsScreen extends StatelessWidget {
  const ResetOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with user image
            ),
            const SizedBox(height: 16),
            const Text(
              'manavhil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'We\'ll send you a link or login code to get back into your account.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            // Send Email Option
            ListTile(
              leading: Radio(
                value: 0,
                groupValue: 1,
                onChanged: (value) {},
                activeColor: Colors.pinkAccent,
              ),
              title: const Text(
                'Send an email',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                '*@gmail.com',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const Divider(color: Colors.grey),
            // Send SMS Option
            ListTile(
              leading: Radio(
                value: 1,
                groupValue: 1,
                onChanged: (value) {},
                activeColor: Colors.pinkAccent,
              ),
              title: const Text(
                'Send an SMS message',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                '+** *** *****98',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const Spacer(),
            // Send Login Link Button
            ElevatedButton(
              onPressed: () {
                // Handle sending login link
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Center(
                child: Text(
                  'Send Login Link',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle "Can't reset your password?"
                },
                child: const Text(
                  "Can't reset your password?",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
