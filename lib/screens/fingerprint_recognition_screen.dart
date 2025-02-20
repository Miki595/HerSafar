import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import HomeScreen

class FingerprintRecognitionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fingerprint Recognition'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.fingerprint, size: 100, color: Colors.pinkAccent),
                  SizedBox(height: 8),
                  Text('Touch ID', style: TextStyle(fontSize: 18)),
                  Text('john.appleseed@apple.com',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Placeholder for fingerprint logic
                    },
                    child: Text('Action', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate to HomeScreen after verification
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Verify',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
