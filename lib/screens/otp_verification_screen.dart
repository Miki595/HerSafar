import 'package:flutter/material.dart';
import 'otp_entry_screen.dart';
import '../models/user_signup_data.dart';

class OTPVerificationScreen extends StatelessWidget {
  final UserSignupData userSignupData;
  final bool isSignup;

  const OTPVerificationScreen({
    super.key,
    required this.userSignupData,
    required this.isSignup,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController contactController = TextEditingController(
      text: userSignupData.email ?? userSignupData.phoneNumber ?? '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(isSignup ? 'Verify Your Email or Phone (Signup)' : 'Verify Your Email or Phone (Login)'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: contactController,
              decoration: const InputDecoration(
                labelText: 'Email or Phone Number',
                border: OutlineInputBorder(),
              ),
              readOnly: userSignupData.email != null || userSignupData.phoneNumber != null,
              onChanged: (value) {
                if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                  userSignupData.email = value;
                  userSignupData.phoneNumber = null;
                } else {
                  userSignupData.phoneNumber = value;
                  userSignupData.email = null;
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (contactController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter an email or phone number')),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPEntryScreen(userSignupData: userSignupData, isSignup: isSignup),
                  ),
                );
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
                  'Send OTP',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
