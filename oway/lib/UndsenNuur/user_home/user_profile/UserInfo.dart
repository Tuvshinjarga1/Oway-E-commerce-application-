import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  final String userId;

  const UserInfo({Key? key, required this.userId}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfo> {
  late Future<DocumentSnapshot> _userDataFuture;
  late Map<String, dynamic> _userData;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _userDataFuture = getUserData(widget.userId);
  }

  Future<DocumentSnapshot> getUserData(String userId) async {
    final snapshot = await FirebaseFirestore.instance.collection('User').doc(userId).get();
    _userData = snapshot.data() as Map<String, dynamic>;
    return snapshot;
  }

  Future<void> _updateUserData() async {
    try {
      await FirebaseFirestore.instance.collection('User').doc(widget.userId).update(_userData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Амжилттай өөрчлөгдлөө')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Өөрчлөлт амжилтгүй')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Хувийн мэдээлэл'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  _updateUserData(); // Save changes when in editing mode
                }
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(75), //150 bval tugs dugui bdg
                    child: Image.asset(
                    'assets/registerpro.png',
                    height: 155,
                    width: 155,
                    ),
                  ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: '${_userData["Овог"]}',
                    enabled: _isEditing,
                    onChanged: (value) {
                      // Update the name in the local data
                      setState(() {
                        _userData["Овог"] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Овог'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: '${_userData["Нэр"]}',
                    enabled: _isEditing,
                    onChanged: (value) {
                      // Update the name in the local data
                      setState(() {
                        _userData["Нэр"] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Нэр'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: _userData["Утас"],
                    enabled: _isEditing,
                    onChanged: (value) {
                      // Update the phone number in the local data
                      setState(() {
                        _userData["Утас"] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Утас'),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
