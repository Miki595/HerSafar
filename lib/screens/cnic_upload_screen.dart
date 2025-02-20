import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'password_setup_screen.dart';
import 'driver_document_screen.dart';
import '../models/user_signup_data.dart';
import '../models/driver_signup_data.dart';
import 'dart:io';

class CNICUploadScreen extends StatefulWidget {
  final UserSignupData userSignupData;

  const CNICUploadScreen({super.key, required this.userSignupData});

  @override
  _CNICUploadScreenState createState() => _CNICUploadScreenState();
}

class _CNICUploadScreenState extends State<CNICUploadScreen> {
  String? frontImagePath;
  String? backImagePath;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _selectImage(String side) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          if (side == 'Front') {
            frontImagePath = pickedImage.path;
            widget.userSignupData.cnicFront = pickedImage.path;
          } else {
            backImagePath = pickedImage.path;
            widget.userSignupData.cnicBack = pickedImage.path;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload image. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateNext() {
    if (frontImagePath == null || backImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload both CNIC images')),
      );
      return;
    }

    // Ensure CNIC images are correctly stored before navigating
    widget.userSignupData.cnicFront = frontImagePath!;
    widget.userSignupData.cnicBack = backImagePath!;

    print('CNIC Front: ${widget.userSignupData.cnicFront}');
    print('CNIC Back: ${widget.userSignupData.cnicBack}');
    print('User Type: ${widget.userSignupData.userType}');

    if (widget.userSignupData.userType == 'Driver') {
      // Ensure correct conversion from UserSignupData to DriverSignupData
      DriverSignupData driverSignupData = DriverSignupData(
        fullName: widget.userSignupData.fullName,
        email: widget.userSignupData.email,
        phoneNumber: widget.userSignupData.phoneNumber,
        password: widget.userSignupData.password,
        userType: widget.userSignupData.userType,
        cnicFront: widget.userSignupData.cnicFront,
        cnicBack: widget.userSignupData.cnicBack,
        city: widget.userSignupData.city,
        district: widget.userSignupData.district,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DriverDocumentsScreen(
            driverSignupData: driverSignupData,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordSetupScreen(
            userSignupData: widget.userSignupData,
            isSignup: true,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supporting Documents'),
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
            const Text(
              'Upload your CNIC Photos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildUploadButton('Front', frontImagePath),
                _buildUploadButton('Back', backImagePath),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isLoading ? null : _navigateNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Center(
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton(String label, String? imagePath) {
    return GestureDetector(
      onTap: _isLoading ? null : () => _selectImage(label),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              image: imagePath != null
                  ? DecorationImage(image: FileImage(File(imagePath)), fit: BoxFit.cover)
                  : null,
            ),
            child: imagePath == null
                ? const Icon(Icons.add, color: Colors.pinkAccent, size: 40)
                : null,
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
