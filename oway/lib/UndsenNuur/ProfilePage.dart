// ProfilePage StatefulWidget
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String userId; // Add userId parameter

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

// _ProfilePageState State
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
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Display user data fetched from Firestore
            Text('Name: $_userName'),
            Text('Phone: $_userPhone'),
          ],
        ),
      ),
    );
  }
}
