import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:latlong2/latlong.dart'; // Required for geographic coordinates

class RiderDashboardScreen extends StatefulWidget {
  const RiderDashboardScreen({super.key});

  @override
  _RiderDashboardScreenState createState() => _RiderDashboardScreenState();
}

class _RiderDashboardScreenState extends State<RiderDashboardScreen> {
  LatLng coordinates = LatLng(30.3753, 69.3451); // Coordinates for Pakistan
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  String selectedTransport = '';
  List<Map<String, dynamic>> drivers = []; // Use dynamic to handle various types

  // Function to fetch drivers dynamically from the backend
  Future<void> fetchDrivers() async {
    try {
      final response = await http.get(Uri.parse('https://your-backend-api.com/drivers'));
      
      if (response.statusCode == 200) {
        // Parse the response body if request is successful
        List<dynamic> driverList = json.decode(response.body);
        
        // Map each driver into a structured format
        setState(() {
          drivers = driverList.map((driver) {
            return {
              'name': driver['name'],
              'car': driver['car'],
              'price': driver['price'],
              'minutes': driver['minutes'],
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load drivers');
      }
    } catch (e) {
      print("Error fetching drivers: $e");
      // Optionally show an error message to the user
    }
  }

  // Function to show the address dialog
  void _showAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Address Details', style: TextStyle(color: Colors.pinkAccent)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentAddressController,
                decoration: const InputDecoration(
                  labelText: 'Your Current Address',
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent)),
                  labelStyle: TextStyle(color: Colors.pinkAccent),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: destinationController,
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent)),
                  labelStyle: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showTransportOptions();
              },
              child: const Text('OK', style: TextStyle(color: Colors.pinkAccent)),
            ),
          ],
        );
      },
    );
  }

  // Function to show transport options
  void _showTransportOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Transport', style: TextStyle(color: Colors.pinkAccent)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Ride Mini', style: TextStyle(color: Colors.pinkAccent)),
                leading: const Icon(Icons.directions_car, color: Colors.pinkAccent),
                onTap: () {
                  setState(() {
                    selectedTransport = 'Ride Mini';
                  });
                  Navigator.pop(context);
                  _showDriverSelection();
                },
              ),
              ListTile(
                title: const Text('Ride AC', style: TextStyle(color: Colors.pinkAccent)),
                leading: const Icon(Icons.ac_unit, color: Colors.pinkAccent),
                onTap: () {
                  setState(() {
                    selectedTransport = 'Ride AC';
                  });
                  Navigator.pop(context);
                  _showDriverSelection();
                },
              ),
              ListTile(
                title: const Text('Ride Premium', style: TextStyle(color: Colors.pinkAccent)),
                leading: const Icon(Icons.local_taxi, color: Colors.pinkAccent),
                onTap: () {
                  setState(() {
                    selectedTransport = 'Ride Premium';
                  });
                  Navigator.pop(context);
                  _showDriverSelection();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.pinkAccent)),
            ),
          ],
        );
      },
    );
  }

  // Function to show available drivers
  void _showDriverSelection() {
    // Fetch drivers from backend
    fetchDrivers();
    
    // Show the dialog while waiting for drivers to be fetched
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Driver', style: TextStyle(color: Colors.pinkAccent)),
          content: drivers.isEmpty
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: drivers.map((driver) {
                      return ListTile(
                        title: Text(driver['name']!, style: TextStyle(color: Colors.pinkAccent)),
                        subtitle: Text('${driver['car']} - ${driver['price']}', style: TextStyle(color: Colors.pinkAccent)),
                        trailing: Text(driver['minutes']!, style: TextStyle(color: Colors.pinkAccent)),
                        onTap: () {
                          Navigator.pop(context);
                          _confirmSelection(driver['name']!);
                        },
                      );
                    }).toList(),
                  ),
                ),
        );
      },
    );
  }

  // Function to confirm the selection of the driver
  void _confirmSelection(String driver) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selection Confirmed', style: TextStyle(color: Colors.pinkAccent)),
          content: Text('You have selected $driver for your $selectedTransport.', style: TextStyle(color: Colors.pinkAccent)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to another screen or perform other actions if needed
              },
              child: const Text('OK', style: TextStyle(color: Colors.pinkAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rider Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Welcome to the Rider Dashboard!', style: TextStyle(color: Colors.pinkAccent, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Geoapify Map Section
              Container(
                height: 300, // Set a fixed height for the map
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: FlutterMap(
                  options: MapOptions(
                    center: coordinates,
                    zoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://maps.geoapify.com/v1/staticmap?style=osm-bright-smooth&width=600&height=400&center=lonlat%3A-122.29009844646316%2C47.54607447032754&zoom=14.3497&marker=lonlat%3A-122.29188334609739%2C47.54403990655936%3Btype%3Aawesome%3Bcolor%3A%23bb3f73%3Bsize%3Ax-large%3Bicon%3Apaw",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: coordinates,
                          builder: (context) => const Icon(
                            Icons.location_on,
                            color: Colors.pink,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showAddressDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Select Transport'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
