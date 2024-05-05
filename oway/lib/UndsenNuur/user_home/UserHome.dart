import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oway/Register_Login/login.dart';
import 'package:oway/UndsenNuur/user_home/product/ProductDetail.dart';
import 'package:oway/UndsenNuur/user_home/user_profile/ProfilePage.dart';

class UserHome extends StatefulWidget {
  final String userId;

  UserHome({required this.userId});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _selectedIndex = 0;
  bool _isLoggedIn = false;
  String _userId = '';

  @override
  Widget build(BuildContext context) {
    _userId = widget.userId;
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
              Text("User ID: $_userId"),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Featured Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('VendorProduct').where('Онцлох', isEqualTo: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      return Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                      productID: data['id'],
                                      vendorid: data['Vendorid'],
                                      userid: _userId,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200],
                                  ),
                                  child: Center(
                                    child: Text(data['Нэр']),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                  }
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('VendorProduct').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document = snapshot.data!.docs[index];
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                    productID: data['id'],
                                    vendorid: data['Vendorid'],
                                    userid: _userId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: Center(
                                child: Text(data['Нэр']),
                              ),
                            ),
                          );
                        },
                      );
                  }
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
              if (index == 2) {
                if (_userId == _userId) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage(userId: _userId)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }
              } else if (_isLoggedIn && index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserHome(userId: _userId)),
                );
              }
            });
          },
        ),
      ),
    );
  }
}
