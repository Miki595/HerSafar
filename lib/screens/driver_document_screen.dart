import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/driver_signup_data.dart';
import 'vehicle_information_screen.dart';

class DriverDocumentsScreen extends StatefulWidget {
  final DriverSignupData driverSignupData;

  const DriverDocumentsScreen({super.key, required this.driverSignupData});

  @override
  _DriverDocumentsScreenState createState() => _DriverDocumentsScreenState();
}

class _DriverDocumentsScreenState extends State<DriverDocumentsScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _selectImage(String type) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;

        setState(() {
          switch (type) {
            case 'VehicleImage':
              widget.driverSignupData.vehicleImage = imagePath;
              break;
            case 'LicensePicture':
              widget.driverSignupData.licensePicture = imagePath;
              break;
            case 'CarRegistrationFront':
              widget.driverSignupData.carRegistrationFront = imagePath;
              break;
            case 'CarRegistrationBack':
              widget.driverSignupData.carRegistrationBack = imagePath;
              break;
          }
        });

        print('$type Uploaded: $imagePath');
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

  void _submitDocuments() {
    if (!widget.driverSignupData.validateDriverDocuments()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload all required documents')),
      );
      return;
    }

    print('✅ All documents uploaded successfully!');
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VehicleInformationScreen(driverSignupData: widget.driverSignupData)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Driver Documents'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload Your Vehicle & License Documents',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildUploadButton('Vehicle Image', widget.driverSignupData.vehicleImage, 'VehicleImage'),
            _buildUploadButton('License Picture', widget.driverSignupData.licensePicture, 'LicensePicture'),
            const SizedBox(height: 24),
            const Text(
              'Upload Your Car Registration',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildUploadButton('Car Registration Front', widget.driverSignupData.carRegistrationFront, 'CarRegistrationFront'),
                _buildUploadButton('Car Registration Back', widget.driverSignupData.carRegistrationBack, 'CarRegistrationBack'),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitDocuments,
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

  Widget _buildUploadButton(String label, String? imagePath, String type) {
    return GestureDetector(
      onTap: _isLoading ? null : () => _selectImage(type),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              image: imagePath != null
                  ? DecorationImage(
                      image: kIsWeb
                          ? NetworkImage(imagePath)
                          : FileImage(File(imagePath)) as ImageProvider,
                      fit: BoxFit.cover,
                    )
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
