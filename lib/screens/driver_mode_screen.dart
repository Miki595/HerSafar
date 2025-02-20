import 'package:flutter/material.dart';
import '../models/driver_signup_data.dart';
import 'password_setup_screen.dart'; // Ensure this file exists

class DriverModeScreen extends StatelessWidget {
  final DriverSignupData driverSignupData;

  const DriverModeScreen({super.key, required this.driverSignupData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Driver Mode'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _driverModeTile(context, 'Car', Icons.directions_car, 'Car'),
          _driverModeTile(context, 'Car Mini', Icons.directions_car_filled, 'Car Mini'),
          _driverModeTile(context, 'Car A/C', Icons.air, 'Car A/C'),
        ],
      ),
    );
  }

  Widget _driverModeTile(BuildContext context, String title, IconData icon, String mode) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.black),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          // Save the selected mode in driverSignupData
          driverSignupData.vehicleCategory = mode;

          print('🚗 Driver Mode Selected: $mode');

          // Navigate to Password Setup Screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasswordSetupScreen(
                userSignupData: driverSignupData, // Pass DriverSignupData (valid since it extends UserSignupData)
                isSignup: true, // Ensure the signup flag is passed
              ),
            ),
          );
        },
      ),
    );
  }
}
