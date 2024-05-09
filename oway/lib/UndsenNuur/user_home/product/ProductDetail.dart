import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oway/UndsenNuur/user_home/product/Niiluulegch.dart';

class ProductDetail extends StatelessWidget {
  final String productID;
  final String vendorid;
  final String userid;

  ProductDetail({
    required this.productID,
    required this.vendorid,
    required this.userid,
  });

  String _userId = '';
  final TextEditingController quantityController = TextEditingController(); // Define TextEditingController
  var productName;
  var productImage;

  @override
  Widget build(BuildContext context) {
    _userId = userid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Бүтээгдэхүүний дэлгэрэнгүй'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('VendorProduct').doc(productID).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    var productData = snapshot.data!;
                    productImage = productData['Бүтээгдэхүүний зураг'];
                    productName = productData['Нэр'];
                    var productPrice = productData['Үнэ'];
                    var angilal = productData['Ангилал'];
                    var belen_eseh = productData['Бэлэн болох'];
                    var productDescription = productData['Тайлбар'];
                    var too_shirheg = productData['Тоо ширхэг'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          productImage,
                          height: 200.00,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  productName,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8), // Adding space between name and price
                              Text(
                                productPrice,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyan, // Text color is cyan
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  angilal,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8), // Adding space between category and belen_eseh
                              Text(
                                belen_eseh,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Нэмэлт тайлбар: $productDescription',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Хэмжээ: $too_shirheg',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Тоо ширхэг: $too_shirheg',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    );
                  } else {
                    return Text('No product found');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Нийлүүлэгчийн тухай',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Niiluulegch(vendorID: vendorid),
                  ),
                );
              },
              child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('Vendor').doc(vendorid).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      var vendorData = snapshot.data!;
                      var vendorImageUrl = vendorData['Цээж зураг'];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                            borderRadius: BorderRadius.circular(75), //150 bval tugs dugui bdg
                            child: Image.network(
                              vendorImageUrl,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                            SizedBox(height: 8, width: 8,),
                            Text(
                              '${vendorData['Овог']} ${vendorData['Нэр']}\n${vendorData['Гэрийн хаяг']}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Text('No vendor found');
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: quantityController, // Assign controller to the TextFormField
                decoration: InputDecoration(
                  labelText: 'Тоо ширхэг (хэмжээ)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                // Implement logic to handle quantity input
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  var quantity = int.tryParse(quantityController.text) ?? 0;
                  if (quantity > 0) {
                    var orderData = {
                      'productID': productID,
                      'productName': productName,
                      'productImage': productImage,
                      'userID': _userId,
                      'vendorID': vendorid, // Include vendorid in the order data
                      'quantity': quantity,
                      'status': 'Pending', // Initially set order status to Pending
                      // Add other relevant order details
                    };
                    await FirebaseFirestore.instance.collection('Orders').add(orderData);

                    // Update product quantity
                    // await FirebaseFirestore.instance.collection('VendorProduct').doc(productID).update({
                    //   'Тоо ширхэг': FieldValue.increment(-quantity), // Decrement product quantity
                    // });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Захиалга бүртгэгдлээ.')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Тоо хэмжээ оруулна уу')),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
                ),
                child: Text('Захиалах'),
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   child: Icon(Icons.arrow_back),
      // ),
    );
  }
}
