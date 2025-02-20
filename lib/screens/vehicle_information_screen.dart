import 'package:flutter/material.dart';
import '../models/driver_signup_data.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'driver_mode_screen.dart';

class VehicleInformationScreen extends StatefulWidget {
  final DriverSignupData driverSignupData;

  const VehicleInformationScreen({super.key, required this.driverSignupData});

  @override
  _VehicleInformationScreenState createState() => _VehicleInformationScreenState();
}

class _VehicleInformationScreenState extends State<VehicleInformationScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _modelNameController = TextEditingController();
  final TextEditingController _numberPlateController = TextEditingController();

  String? _vehicleImagePath;
  String? _selectedCategory;
  bool _isLoading = false;

  final List<String> _vehicleCategories = ['Car', 'Bike', 'Van', 'Truck'];

  @override
  void initState() {
    super.initState();
    
    // Load existing data if available
    _modelNameController.text = widget.driverSignupData.vehicleModel ?? '';
    _numberPlateController.text = widget.driverSignupData.vehicleNumberPlate ?? '';
    _vehicleImagePath = widget.driverSignupData.vehicleImage;
    _selectedCategory = widget.driverSignupData.vehicleCategory;
  }

  Future<void> _pickVehicleImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _vehicleImagePath = pickedFile.path;
        widget.driverSignupData.vehicleImage = _vehicleImagePath;
      });
    }
  }

  void _submitVehicleInfo() {
    if (_vehicleImagePath == null ||
        _selectedCategory == null ||
        _modelNameController.text.isEmpty ||
        _numberPlateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and upload a vehicle image')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Save input values to driverSignupData
    widget.driverSignupData.vehicleModel = _modelNameController.text;
    widget.driverSignupData.vehicleNumberPlate = _numberPlateController.text;
    widget.driverSignupData.vehicleCategory = _selectedCategory;

    print('✅ Vehicle Information Saved:');
    print('Model: ${widget.driverSignupData.vehicleModel}');
    print('Number Plate: ${widget.driverSignupData.vehicleNumberPlate}');
    print('Category: ${widget.driverSignupData.vehicleCategory}');
    print('Image: ${widget.driverSignupData.vehicleImage}');

    // Navigate to Driver Mode Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DriverModeScreen(driverSignupData: widget.driverSignupData),
      ),
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Information'),
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
              'Enter Your Vehicle Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Upload Vehicle Image
            GestureDetector(
              onTap: _pickVehicleImage,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  image: _vehicleImagePath != null
                      ? DecorationImage(
                          image: FileImage(File(_vehicleImagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _vehicleImagePath == null
                    ? const Icon(Icons.add_a_photo, color: Colors.pinkAccent, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 16),

            // Vehicle Category Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: const Text('Select Vehicle Category'),
              items: _vehicleCategories.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                  widget.driverSignupData.vehicleCategory = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
            const SizedBox(height: 16),

            // Vehicle Model Input
            TextField(
              controller: _modelNameController,
              decoration: InputDecoration(
                labelText: 'Vehicle Model',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            const SizedBox(height: 16),

            // Number Plate Input
            TextField(
              controller: _numberPlateController,
              decoration: InputDecoration(
                labelText: 'Number Plate',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            ElevatedButton(
              onPressed: _isLoading ? null : _submitVehicleInfo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
}
