import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oway/Register_Login/login.dart';
import 'package:oway/UndsenNuur/user_home/user_profile/UserOrder.dart';
import 'package:oway/UndsenNuur/user_home/user_profile/UserOrderHistory.dart';
import 'package:oway/UndsenNuur/user_home/user_profile/userinfo.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfilePagePageState createState() => _ProfilePagePageState();
}

class _ProfilePagePageState extends State<ProfilePage> {
  String _userOvog = "";
  String _userNer = "";
  String _userPhone = "";
  String _userId = "";
  @override
  void initState() {
    super.initState();
    print("pls orood ireech UserID: ${widget.userId}");
    // Fetch user data when the ProfilePage is initialized
    getUserData(widget.userId);
  }

  Future<void> getUserData(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('User').doc(userId).get();
    setState(() {
      _userId = userSnapshot['id'];
      _userOvog = userSnapshot['Овог'];
      _userPhone = userSnapshot['Утас'];
      _userNer = userSnapshot['Нэр'];
    });
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профайл'),
      ),
      body: Center(
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
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(75), //150 bval tugs dugui bdg
                  //   child: Image.network(
                  //     '$_imageLink',
                  //     height: 100,
                  //     width: 100,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        "$_userOvog $_userNer",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Утас: $_userPhone",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInfo(userId: _userId)),
                  );
                  print("Хувийн мэдээлэл button tapped");
                },
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text("Хувийн мэдээлэл"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserOrder(userId: _userId)),
                  );
                  print("Миний захиалга button tapped");
                },
                child: Row(
                  children: [
                    Icon(Icons.check_box),
                    SizedBox(width: 10),
                    Text("Миний захиалга"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserOrderHistory(userId: _userId)),
                  );
                  print("Захиалгын түүх button tapped");
                },
                child: Row(
                  children: [
                    Icon(Icons.list),
                    SizedBox(width: 10),
                    Text("Захиалгын түүх"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _logout,
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 10),
                    Text("Гарах"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
