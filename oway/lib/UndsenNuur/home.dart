// Import necessary packages
import 'package:flutter/material.dart';
import 'package:oway/Register_Login/login.dart';
import 'package:oway/UndsenNuur/ProfilePage.dart';

// Main function
void main() {
  runApp(HomePage());
}

// HomePage StatefulWidget
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// _HomePageState State
class _HomePageState extends State<HomePage> {
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Онцлох бүтээгдэхүүнүүд',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: Text('Онцлох $index'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Бүтээгдэхүүн',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: Text('Бүтээгдэхүүн $index'),
                    ),
                  );
                },
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
              icon: Icon(Icons.shopping_bag),
              label: 'Ангилал',
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

