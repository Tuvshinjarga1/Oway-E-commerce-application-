import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorProduct extends StatelessWidget {
  final String userId;

  const VendorProduct({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Products'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('VendorProduct')
            .where('Vendorid', isEqualTo: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No products found for this vendor.'),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['ner'] ?? ''),
                subtitle: Text(data['une'] != null ? '\$${data['une']}' : ''),
                // Add more fields as needed
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
