import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // For geographic coordinates

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng coordinates = LatLng(30.3753, 69.3451); // Coordinates for Pakistan
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  String selectedTransport = '';

  // Show address input dialog
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
                if (currentAddressController.text.isEmpty || destinationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter both addresses')),
                  );
                } else {
                  Navigator.pop(context);
                  _showTransportOptions();
                }
              },
              child: const Text('OK', style: TextStyle(color: Colors.pinkAccent)),
            ),
          ],
        );
      },
    );
  }

  // Show transport options dialog
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

  // Show driver selection dialog
  void _showDriverSelection() {
    // Sample data for drivers
    List<Map<String, String>> drivers = [
      {'name': 'Ali', 'car': 'Toyota Corolla', 'price': '1000pkr', 'minutes': '5 minutes away'},
      {'name': 'Sara', 'car': 'Honda Civic', 'price': '15000pkr', 'minutes': '8 minutes away'},
      {'name': 'Ahmed', 'car': 'BMW 3 Series', 'price': '800pkr', 'minutes': '10 minutes away'},
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Driver', style: TextStyle(color: Colors.pinkAccent)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: drivers.map((driver) {
              return ListTile(
                title: Text(driver['name']!, style: const TextStyle(color: Colors.pinkAccent)),
                subtitle: Text('${driver['car']} - ${driver['price']}', style: const TextStyle(color: Colors.pinkAccent)),
                trailing: Text(driver['minutes']!, style: const TextStyle(color: Colors.pinkAccent)),
                onTap: () {
                  Navigator.pop(context);
                  _confirmSelection(driver['name']!);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // Confirm driver selection
  void _confirmSelection(String driver) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selection Confirmed', style: TextStyle(color: Colors.pinkAccent)),
          content: Text('You have selected $driver for your $selectedTransport.', style: const TextStyle(color: Colors.pinkAccent)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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
              const Text('Welcome to the Rider Dashboard!', style: TextStyle(color: Colors.pinkAccent, fontSize: 18)),
              const SizedBox(height: 20),

              // Map Section
              Container(
                height: 300,
                child: FlutterMap(
                  options: MapOptions(
                    center: coordinates,
                    zoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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

              // Circular Zone around Marker
              GestureDetector(
                onTap: _showAddressDialog,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.pink.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "Where to?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Transport Button
              ElevatedButton(
                onPressed: _showTransportOptions,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: const Text('Choose Transport', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}