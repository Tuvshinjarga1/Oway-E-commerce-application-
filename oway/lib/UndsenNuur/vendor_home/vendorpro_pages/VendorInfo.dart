import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorInfo extends StatefulWidget {
  final String userId;

  const VendorInfo({Key? key, required this.userId}) : super(key: key);

  @override
  _VendorInfoPageState createState() => _VendorInfoPageState();
}

class _VendorInfoPageState extends State<VendorInfo> {
  late Future<DocumentSnapshot> _userDataFuture;
  late Map<String, dynamic> _userData;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _userDataFuture = getUserData(widget.userId);
  }

  Future<DocumentSnapshot> getUserData(String userId) async {
    final snapshot = await FirebaseFirestore.instance.collection('Vendor').doc(userId).get();
    _userData = snapshot.data() as Map<String, dynamic>;
    return snapshot;
  }

  Future<void> _updateUserData() async {
    try {
      await FirebaseFirestore.instance.collection('Vendor').doc(widget.userId).update(_userData);
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
                  TextFormField(
                    initialValue: '${_userData["Овог"]} ${_userData["Нэр"]}',
                    enabled: _isEditing,
                    onChanged: (value) {
                      // Update the name in the local data
                      setState(() {
                        _userData["Овог"] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Овог, нэр'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: _userData["Эрхэлдэг ажил"],
                    enabled: _isEditing,
                    onChanged: (value) {
                      // Update the job title in the local data
                      setState(() {
                        _userData["Эрхэлдэг ажил"] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Ажил'),
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
                  TextFormField(
                    initialValue: _userData["Гэрийн хаяг"],
                    enabled: _isEditing,
                    onChanged: (value) {
                      // Update the address in the local data
                      setState(() {
                        _userData["Гэрийн хаяг"] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Гэрийн хаяг'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: _userData["Дэлгэрэнгүй"],
                    enabled: _isEditing,
                    onChanged: (value) {
                      // Update the detailed description in the local data
                      setState(() {
                        _userData["Дэлгэрэнгүй"] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Дэлгэрэнгүй'),
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
