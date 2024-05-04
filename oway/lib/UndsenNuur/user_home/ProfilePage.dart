import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oway/UndsenNuur/home.dart';

class ProfilePage extends StatefulWidget {
  final String userId; // Add userId parameter

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Variables to store user data
  String _userName = "";
  String _userPhone = "";

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
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('User').doc(userId).get();
    setState(() {
      _userName = userSnapshot['Нэр'];
      _userPhone = userSnapshot['Утас'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профайл'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage(userId: '')),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/registerpro.png',
                    height: 155,
                    width: 155,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        "Нэр: $_userName",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Утас: $_userPhone",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.archive,
                            size: 40.0,
                            color: Colors.cyan,
                          ),
                          SizedBox(height: 10),
                          Text("Худалдан"),
                          Text("авалтын түүх"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.badge,
                            size: 40.0,
                            color: Colors.cyan,
                          ),
                          SizedBox(height: 10),
                          Text("Хадгалсан"),
                          Text("ӨҮЭИ"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Сүүлд хадгалсан:",
                style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
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
                itemCount: 2,
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
      ),
    );
  }
}
