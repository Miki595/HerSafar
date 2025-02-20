import 'package:flutter/material.dart';

class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome, Driver!', style: TextStyle(color: Colors.pinkAccent, fontSize: 24)),
            const SizedBox(height: 20),

            // Earnings Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Today\'s Earnings', style: TextStyle(color: Colors.pinkAccent, fontSize: 18)),
                    const SizedBox(height: 10),
                    const Text('PKR 2,500', style: TextStyle(color: Colors.pinkAccent, fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to earnings details screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                      ),
                      child: const Text('View Details', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Ride Requests
            const Text('Ride Requests', style: TextStyle(color: Colors.pinkAccent, fontSize: 18)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Sample data
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text('Ride Request ${index + 1}', style: const TextStyle(color: Colors.pinkAccent)),
                      subtitle: const Text('5 minutes away', style: TextStyle(color: Colors.pinkAccent)),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Accept ride request
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                        ),
                        child: const Text('Accept', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}