import 'package:flutter/material.dart';

class VendorProfile extends StatelessWidget {
  final String userId;

  const VendorProfile({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Нийлүүлэгч'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vendor Profile Page',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'User ID: $userId',
              style: TextStyle(fontSize: 16),
            ),
            // Add more widgets to display vendor profile information
          ],
        ),
      ),
    );
  }
}
