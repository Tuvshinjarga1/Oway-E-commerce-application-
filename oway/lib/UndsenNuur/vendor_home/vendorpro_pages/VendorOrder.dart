import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorOrder extends StatelessWidget {
  final String vendorId;

  VendorOrder({
    required this.vendorId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Захиалгууд'),
      ),
      body: Expanded(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Orders')
              .where('vendorID', isEqualTo: vendorId)
              .get(),
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
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No orders found for this vendor.'),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> orderData = document.data() as Map<String, dynamic>;

                Color borderColor;
                switch (orderData['status']) {
                  case 'Allowed':
                    borderColor = Colors.green;
                    break;
                  case 'Cancelled':
                    borderColor = Colors.red;
                    break;
                  default:
                    borderColor = Colors.yellow;
                    break;
                }

                return Card(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(orderData['productImage']),
                      ),
                      title: Text('Order ID: ${document.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Бүтээгдэхүүний нэр: ${orderData['productName']}'),
                          Text('Quantity: ${orderData['quantity']}'),
                          Text('Status: ${orderData['status']}')
                        ],
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              // Update order status to "Allowed"
                              await FirebaseFirestore.instance
                                  .collection('Orders')
                                  .doc(document.id)
                                  .update({'status': 'Allowed'});

                              // Decrement product quantity in the vendor's inventory
                              await FirebaseFirestore.instance
                                  .collection('VendorProduct')
                                  .doc(orderData['productID'])
                                  .update({
                                'Тоо ширхэг': FieldValue.increment(-orderData['quantity']),
                              });

                              // Save the order to "AllowedOrders" collection
                              await FirebaseFirestore.instance
                                  .collection('AllowedOrders')
                                  .doc(document.id) // Use the same document id
                                  .set(orderData); // Save the order data

                              // Show a snackbar indicating that the order has been allowed and quantity updated
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Бүтээгдэхүүн амжилттай баталгаажлаа.')),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(0, 30)),
                            ),
                            child: Text('Allow'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              // Update order status to "Cancelled"
                              await FirebaseFirestore.instance
                                  .collection('Orders')
                                  .doc(document.id)
                                  .update({'status': 'Cancelled'});

                              // Get the order data
                              Map<String, dynamic> orderData = document.data() as Map<String, dynamic>;

                              // Save the order to "CancelledOrders" collection
                              await FirebaseFirestore.instance
                                  .collection('CancelledOrders')
                                  .doc(document.id) // Use the same document id
                                  .set(orderData); // Save the order data

                              // Show a snackbar indicating that the order has been cancelled
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Захилга цуцлагдлаа.')),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(0, 30)),
                            ),
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Handle order selection
                        // For example, navigate to a detailed order page
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
