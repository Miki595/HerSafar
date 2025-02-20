import 'package:flutter/material.dart';
import 'cnic_upload_screen.dart';
import '../models/user_signup_data.dart';

class SignupScreen extends StatefulWidget {
  final UserSignupData userSignupData;

  const SignupScreen({super.key, required this.userSignupData});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  late UserSignupData userSignupData;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userSignupData = widget.userSignupData;
  }

  @override
  void dispose() {
    phoneController.dispose();
    cnicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (value) {
                  userSignupData.fullName = value!.trim();
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  userSignupData.email = value!.trim();
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  }

                  String formattedPhone = value.trim();

                  if (formattedPhone.startsWith('0')) {
                    formattedPhone = '+92' + formattedPhone.substring(1);
                  } else if (!formattedPhone.startsWith('+92')) {
                    return 'Phone number must start with +92 or 03XX';
                  }

                  if (!RegExp(r'^\+923\d{9}$').hasMatch(formattedPhone)) {
                    return 'Enter a valid Pakistani phone number (e.g., +923001234567)';
                  }

                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    String formattedPhone = value.trim();
                    if (formattedPhone.startsWith('0')) {
                      formattedPhone = '+92' + formattedPhone.substring(1);
                    }
                    userSignupData.phoneNumber = formattedPhone;
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: cnicController,
                decoration: const InputDecoration(labelText: 'CNIC Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your CNIC number';
                  }
                  if (!RegExp(r'^\d{13}$').hasMatch(value.trim())) {
                    return 'CNIC must be 13 digits long';
                  }
                  return null;
                },
                onSaved: (value) {
                  userSignupData.cnicFront = value!.trim();
                  userSignupData.cnicBack = value.trim();
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CNICUploadScreen(
                          userSignupData: userSignupData,
                        ),
                      ),
                    );
                  }
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
                    'Next',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
