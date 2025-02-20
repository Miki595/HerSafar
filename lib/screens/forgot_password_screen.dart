import 'package:flutter/material.dart';
import 'password_setup_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_signup_data.dart';
import '../models/driver_signup_data.dart'; // Assuming you have this file

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _selectedTabIndex = 0;

  // API request function for sending forgot password data
  Future<void> _sendForgotPasswordRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String emailOrPhone = _emailPhoneController.text;

    try {
      final response = await http.post(
        Uri.parse('http://10.97.22.2:5008/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'usernameOrPhone': emailOrPhone,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        // Fetch userType from the backend response
        String userType = responseBody['userType'];

        // Create user data based on userType
        UserSignupData userSignupData;
        if (userType == 'driver') {
          userSignupData = DriverSignupData(userType: userType);
        } else {
          userSignupData = UserSignupData(userType: userType);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('A reset link/OTP has been sent to your email/phone')),
        );

        // Navigate to Password Setup Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PasswordSetupScreen(
              userSignupData: userSignupData,
              isSignup: false,
            ),
          ),
        );
      } else {
        final responseBody = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'] ?? 'Error: Unable to send reset link')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred, please try again later')),
      );
    }
  }

  @override
  void dispose() {
    _emailPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trouble with logging in?'),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(Icons.lock, size: 80, color: Colors.pinkAccent),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Trouble with logging in?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Enter your username or email address and we\'ll send you a link to get back into your account.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.pinkAccent,
                      labelColor: Colors.pinkAccent,
                      unselectedLabelColor: Colors.grey,
                      onTap: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                      tabs: const [
                        Tab(text: 'Username'),
                        Tab(text: 'Phone'),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                      child: TabBarView(
                        children: [
                          TextFormField(
                            controller: _emailPhoneController,
                            decoration: const InputDecoration(
                              labelText: 'Username or email address',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username or email';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _emailPhoneController,
                            decoration: const InputDecoration(
                              labelText: 'Phone number',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _sendForgotPasswordRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Can't reset your password?",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
