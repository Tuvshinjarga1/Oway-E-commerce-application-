import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorProduct extends StatelessWidget {
  final String productId;

  VendorProduct({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('VendorProduct')
            .doc('SEbYOj0bTGlQ77MWBcno')
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('No data found for this product Id.'),
            );
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          // Display your data here, for example:
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Name: ${data['Нэр']}'),
                  Text('Price: \$${data['Үнэ']}'),
                  // Add more fields as needed
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Example usage:
// VendorProduct(productId: 'SEbYOj0bTGlQ77MWBcno');
