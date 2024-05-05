import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oway/UndsenNuur/vendor_home/add_product/VendorAddProduct.dart';
import 'package:oway/UndsenNuur/vendor_home/vendorpro_pages/VendorProfile.dart';

class VendorHomePage extends StatefulWidget {
  final String userId;

  VendorHomePage({required this.userId});

  @override
  _VendorHomePageState createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  int _selectedIndex = 0;
  String _userName = "";
  int amjilttai = 0;
  int tsutslagdsan = 0;
  int huleegdej = 0;
  @override
  void initState() {
    super.initState();
    getUserData(widget.userId);
  }

  // Method to fetch user data from Firestore
  Future<void> getUserData(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('Vendor').doc(userId).get();
    setState(() {
      _userName = userSnapshot['Нэр'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/oway.png',
            height: 100,
            width: 100,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Implement search functionality
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/ehleh.png',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text("Тавтай морил $_userName"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Миний борлуулалт',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Борлуулалтын Төлөв')),
                        DataColumn(label: Text('Тоо')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('Амжилттай борлуулсан')),
                          DataCell(StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('AllowedOrders')
                            .where('vendorID', isEqualTo: widget.userId)
                            .snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                // Process snapshot data and display statistics
                                amjilttai = snapshot.data!.docs.length;
                                return Column(
                                  children: [
                                    Text('${snapshot.data!.docs.length}'),
                                    // Display other statistics similarly
                                  ],
                                );
                              }
                            },
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Цуцлагдсан')),
                          DataCell(StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('CancelledOrders')
                            .where('vendorID', isEqualTo: widget.userId)
                            .snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                tsutslagdsan = snapshot.data!.docs.length;
                                return Column(
                                  children: [
                                    Text('${snapshot.data!.docs.length}'),
                                    // Display other statistics similarly
                                  ],
                                );
                              }
                            },
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Хүлээгдэж байгаа')),
                          DataCell(StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('Orders')
                                .where('vendorID', isEqualTo: widget.userId)
                                .where('status', isEqualTo: 'Pending')
                                .snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                huleegdej = snapshot.data!.docs.length;
                                return Column(
                                  children: [
                                    Text('${snapshot.data!.docs.length}'),
                                    // Display other statistics similarly
                                  ],
                                );
                              }
                            },
                          ),),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Нүүр',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Бүтээгдэхүүн нэмэх',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профайл',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromRGBO(33, 150, 243, 1),
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              if (index == 1) {
                // Navigate to VendorAddProduct page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VendorAddProduct(userId: widget.userId)),
                );
              } else if (index == 2) {
                // Navigate to VendorProfile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VendorProfile(userId: widget.userId)),
                );
              }
            });
          },
        ),
      ),
    );
  }
}