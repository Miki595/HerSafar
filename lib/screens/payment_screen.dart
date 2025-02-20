import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Select Payment Method', style: TextStyle(fontSize: 18)),
            ListTile(
              title: const Text('Cash'),
              leading: Radio(value: 'Cash', groupValue: 'selected', onChanged: (_) {}),
            ),
            ListTile(
              title: const Text('JazzCash'),
              leading: Radio(value: 'JazzCash', groupValue: 'selected', onChanged: (_) {}),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
