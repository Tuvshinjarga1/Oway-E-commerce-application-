// Import necessary packages
import 'package:flutter/material.dart';
import 'package:oway/Register_Login/login.dart';
import 'package:oway/UndsenNuur/user_home/ProfilePage.dart';

// Main function
void main() {
  runApp(VendorHomePage());
}

// VendorHomePage StatefulWidget
class VendorHomePage extends StatefulWidget {
  @override
  _VendorHomePageState createState() => _VendorHomePageState();
}

// _VendorHomePageState State
class _VendorHomePageState extends State<VendorHomePage> {
  // Variables
  int _selectedIndex = 0;
  bool _isLoggedIn = false; // Updated variable
  String _userId = "";

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
    // Check if the "Профайл" tab is selected
    if (index == 2) {
      // Check if the user is logged in
      if (_isLoggedIn) {
        // If logged in, navigate to the ProfilePage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(userId: _userId)),
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

