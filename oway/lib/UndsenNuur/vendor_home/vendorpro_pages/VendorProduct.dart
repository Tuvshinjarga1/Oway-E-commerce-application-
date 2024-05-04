import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorProduct extends StatelessWidget {
  final String vendorId;

  VendorProduct({required this.vendorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products by Vendor'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('VendorProduct')
            .where('Vendorid', isEqualTo: vendorId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No products found for this vendor.'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              var data = document.data() as Map<String, dynamic>;

              // Display your data here, for example:
              return ListTile(
                title: Text(data['Нэр']),
                subtitle: Text('Price: \$${data['Үнэ']}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}