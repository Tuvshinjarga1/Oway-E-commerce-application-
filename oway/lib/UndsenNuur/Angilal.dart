import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oway/Register_Login/login.dart';
import 'package:oway/UndsenNuur/home.dart';
import 'package:oway/UndsenNuur/user_home/user_profile/ProfilePage.dart';

class Angilal extends StatefulWidget {
  @override
  _AngilalState createState() => _AngilalState();
}

class _AngilalState extends State<Angilal> {
  int _selectedIndex = 1;
  bool _isLoggedIn = false;
  String _userId = '';

  String _selectedCategory = 'Бүгд';
  List<String> _categories = ['Бүгд', 'Мах махан бүтээгдэхүүн', 'Сүүн бүтээгдэхүүн', 'Хувцас'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ангилал'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            items: _categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _selectedCategory == 'Бүгд'
                  ? FirebaseFirestore.instance.collection('VendorProduct').snapshots()
                  : FirebaseFirestore.instance.collection('VendorProduct').where('Ангилал', isEqualTo: _selectedCategory).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                data['Бүтээгдэхүүний зураг'], // Assuming you have an 'imageUrl' field in your document
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              data['Нэр'], // Assuming 'Нэр' is the name field
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
                                  data['Ангилал'], // Assuming 'category' is the category field
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
                                    color: Colors.green[700],
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  data['Бэлэн болох'], // Assuming 'availability' is the availability field
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                            onTap: () {
                              _showAfterLoginDialog();
                            },
                          ),
                        );
                      },
                    );
                }
              },
            ),
          ),
        ],
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
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(userId: "")),
              );
            } else if (index == 2) {
              if (_isLoggedIn) {
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
            }
          });
        },
      ),
    );
  }
  void _showAfterLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Нэвтрэсний дараа үйлдэл хийнэ үү"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
