import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oway/Register_Login/login.dart';
import 'package:oway/UndsenNuur/vendor_home/vendorpro_pages/VendorInfo.dart';
import 'package:oway/UndsenNuur/vendor_home/vendorpro_pages/VendorOrder.dart';
import 'package:oway/UndsenNuur/vendor_home/vendorpro_pages/VendorProduct.dart';

class VendorProfile extends StatefulWidget {
  final String userId;

  const VendorProfile({Key? key, required this.userId}) : super(key: key);

  @override
  _VendorProfilePageState createState() => _VendorProfilePageState();
}

class _VendorProfilePageState extends State<VendorProfile> {
  String _vendorOvog = "";
  String _vendorNer = "";
  String _imageLink = "";
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
        await FirebaseFirestore.instance.collection('Vendor').doc(userId).get();
    setState(() {
      _userId = userSnapshot['id'];
      _vendorOvog = userSnapshot['Овог'];
      _vendorNer = userSnapshot['Нэр'];
      _imageLink = userSnapshot['Цээж зураг'];
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
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset(
                  //   'assets/registerpro.png',
                  //   height: 155,
                  //   width: 155,
                  // ),
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(75), //150 bval tugs dugui bdg
                    child: Image.network(
                      '$_imageLink',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        "$_vendorOvog $_vendorNer",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Зөвшөөрөлтэй нийлүүлэгч",
                        style: TextStyle(fontSize: 15),
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
                    MaterialPageRoute(
                        builder: (context) => VendorInfo(userId: _userId)),
                  );
                  print("Profile button tapped");
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
                    MaterialPageRoute(
                        builder: (context) => VendorProduct(vendorId: _userId)),
                  );
                  print("Products button tapped");
                },
                child: Row(
                  children: [
                    Icon(Icons.check_box),
                    SizedBox(width: 10),
                    Text("Миний бүтээгдэхүүн"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VendorOrder(vendorId: _userId)),
                  );
                  print("Orders button tapped");
                },
                child: Row(
                  children: [
                    Icon(Icons.list),
                    SizedBox(width: 10),
                    Text("Захиалгын хүсэлт"),
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
