// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oway/Register_Login/login.dart';
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
  bool _isLoggedIn = false;
  String _userId = "";
  String _userName = "";

  @override
  void initState() {
    super.initState();
    print("pls orood ireech UserID: ${widget.userId}");
    // Fetch user data when the ProfilePage is initialized
    getUserData(widget.userId);
  }

  // Method to fetch user data from Firestore
  Future<void> getUserData(String userId) async {
    // Retrieve user data from Firestore based on userId
    // For example:
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('Vendor').doc(userId).get();
    setState(() {
      _userName = userSnapshot['Нэр'];
      _userId = userSnapshot['id'];
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
          MaterialPageRoute(builder: (context) => VendorAddProduct(userId: _userId)),
        );
      } else if (index == 2) {
        // Navigate to VendorProfile page
        if (_userId.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VendorProfile(userId: _userId)),
          );
        } else {
          // If not logged in, navigate to the Login page
          Navigator.push(context, MaterialPageRoute(builder: (context) => Login())).then((userId) {
            // Update isLoggedIn status when the user logs in successfully
            if (userId != null) {
              setState(() {
                _isLoggedIn = true;
                _userId = userId;
              });
            }
          });
        }
      }
    });
  },
),

      ),
    );
  }
}

