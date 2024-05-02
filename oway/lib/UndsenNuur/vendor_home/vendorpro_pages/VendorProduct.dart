import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorProduct extends StatefulWidget {
  final String userId;

  const VendorProduct({Key? key, required this.userId}) : super(key: key);

  @override
  _VendorProductState createState() => _VendorProductState();
}

class _VendorProductState extends State<VendorProduct> {
  late Stream<QuerySnapshot> _productsStream;

  @override
  void initState() {
    super.initState();
    _productsStream = FirebaseFirestore.instance
        .collection('VendorProduct')
        .where('Vendorid', isEqualTo: widget.userId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Products'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                // Assuming you have a Product model
                // Replace Product with your actual model class
                // and update the field names accordingly
                final productData = doc.data() as Map<String, dynamic>;
                final productId = doc.id;

                // Display product information in a ListTile or custom widget
                return ListTile(
                  title: Text(productData['ner']),
                  subtitle: Text('Price: ${productData['une']}'),
                  // Add more fields as needed
                  // You can also navigate to a detailed product page
                  // when tapping on a product
                  onTap: () {
                    // Implement navigation logic if needed
                  },
                );
              }).toList(),
            );
          }

          return Center(child: Text('No products found.'));
        },
      ),
    );
  }
}
