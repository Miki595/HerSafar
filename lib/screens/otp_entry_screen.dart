import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_signup_data.dart';
import 'rider_dashboard_screen.dart'; // Rider Dashboard Import
import 'driver_dashboard_screen.dart'; // Driver Dashboard Import

class OTPEntryScreen extends StatelessWidget {
  final UserSignupData userSignupData;
  final bool isSignup;

  const OTPEntryScreen({
    super.key,
    required this.userSignupData,
    required this.isSignup,
  });

  Future<void> verifyOTP(BuildContext context) async {
    final String url = isSignup
        ? 'http://192.168.100.144/user/signup'
        : 'http://10.97.22.2:5008/api/users/user/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userSignupData.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        String userType = responseData['userType']?.toLowerCase() ?? 'unknown';

        if (userType == 'rider') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RiderDashboardScreen()),
          );
        } else if (userType == 'driver') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DriverDashboardScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unknown user type. Please contact support.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification Failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSignup ? 'Email/Phone Verification (Sign Up)' : 'Email/Phone Verification (Login)'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => verifyOTP(context),
          child: const Text('Verify & Submit'),
        ),
      ),
    );
  }
}
