import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Niiluulegch extends StatefulWidget {
  final String vendorID;

  const Niiluulegch({Key? key, required this.vendorID}) : super(key: key);

  @override
  _NiiluulegchPageState createState() => _NiiluulegchPageState();
}

class _NiiluulegchPageState extends State<Niiluulegch> {
  late Future<DocumentSnapshot> _userDataFuture;
  late Map<String, dynamic> _userData;

  @override
  void initState() {
    super.initState();
    _userDataFuture = getUserData(widget.vendorID);
  }

  Future<DocumentSnapshot> getUserData(String vendorID) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Vendor')
        .doc(vendorID)
        .get();
    _userData = snapshot.data() as Map<String, dynamic>;
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Нийлүүлэгчийн мэдээлэл'),
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
                // Wrap with Column
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.network(
                        _userData["Цээж зураг"],
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 400, // Set desired width
                    height: 250, // Set desired height
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Овог: ${_userData["Овог"]}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Нэр: ${_userData["Нэр"]}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Эрхэлдэг ажил: ${_userData["Эрхэлдэг ажил"]}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Утас: ${_userData["Утас"]}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Гэрийн хаяг: ${_userData["Гэрийн хаяг"]}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Дэлгэрэнгүй: ${_userData["Дэлгэрэнгүй"]}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
