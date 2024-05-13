import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oway/Register_Login/login.dart';
import 'package:oway/UndsenNuur/Angilal.dart';
import 'package:oway/UndsenNuur/user_home/UserHome.dart';
import 'package:oway/UndsenNuur/user_home/user_profile/ProfilePage.dart';

class HomePage extends StatefulWidget {
  final String userId;

  HomePage({required this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isLoggedIn = false;
  String _userId = '';
  String _userName = "";

  Future<void> getUserData(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('User').doc(userId).get();
    setState(() {
      _userName = userSnapshot['Нэр'];
    });
  }

  @override
  Widget build(BuildContext context) {
    _userId = widget.userId;
    return MaterialApp(
      title: '',
      theme: ThemeData(
        //backgroundColor: Colors.white,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Тавтай морил $_userName",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Онцлох бүтээгдэхүүн',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('VendorProduct')
                    .where('Онцлох', isEqualTo: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                _showAfterLoginDialog(); // Show dialog on tap
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 5.0)
                                    ], // Wrap in a list
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Display product image
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(data[
                                                'Бүтээгдэхүүний зураг']), // Assuming 'imageUrl' is the field storing image URLs
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      // Display product name
                                      Text(
                                        data[
                                            'Нэр'], // Assuming 'Нэр' is the name field
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
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
                  'Бүтээгдэхүүн',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('VendorProduct')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              _showAfterLoginDialog(); // Show dialog on tap
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.black, width: 1),
                              ),
                              color: Colors.white, // Set white background color
                              shadowColor: Colors.grey,
                              child: ListTile(
                                contentPadding: EdgeInsets.all(10),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    data[
                                        'Бүтээгдэхүүний зураг'], // Assuming you have an 'imageUrl' field in your document
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  data[
                                      'Нэр'], // Assuming 'Нэр' is the name field
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      data[
                                          'Ангилал'], // Assuming 'category' is the category field
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      '\Үнэ: ${data['Үнэ']}', // Assuming 'price' is the price field
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      data[
                                          'Бэлэн болох'], // Assuming 'availability' is the availability field
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
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
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Angilal()), // Navigate to CategoryPage
                );
              } else if (_isLoggedIn && index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserHome(userId: _userId)),
                );
              } else if (index == 2) {
                if (_isLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(userId: _userId)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }
              }
            });
          },
        ),
      ),
    );
  }

  // Function to show a dialog after login
  void _showAfterLoginDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text("Нэвтэрсний дараа үйлдэл хийнэ үү"),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text("OK"),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}

void main() {
  runApp(HomePage(
    userId: '',
  ));
}
