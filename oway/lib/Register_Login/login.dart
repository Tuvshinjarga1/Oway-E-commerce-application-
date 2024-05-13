import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oway/Register_Login/HereglegchBurtgel.dart';
import 'package:oway/Register_Login/VendorRegister/VendorReg.dart';
import 'package:oway/UndsenNuur/user_home/UserHome.dart';
import 'package:oway/UndsenNuur/vendor_home/VendorHome.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _phoneNumberController.text +
            "@gmail.com", // Use email as phone number
        password: _passwordController.text,
      );
      String userId = userCredential.user!.uid;

      // Check if the user is a vendor or a user
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection("User").doc(userId).get();
      DocumentSnapshot vendorSnapshot = await FirebaseFirestore.instance
          .collection("Vendor")
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        // Navigate to user profile page
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => UserHome(userId: userId)));
      } else if (vendorSnapshot.exists) {
        // Navigate to vendor profile page
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VendorHomePage(userId: userId)));
      } else {
        // Handle case where user is neither a user nor a vendor
        print("User not found in both collections");
      }
    } catch (e) {
      // Handle login errors
      print("Error signing in: $e");
      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in. Please check your credentials."),
      ));
    }
  }

  int selectedOption = 1; // Declare selectedOption as int
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/oway.png',
            height: 100,
            width: 100,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Нэвтрэх",
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value as int;
                            });
                          },
                        ),
                        Text('Хэрэглэгч'),
                        SizedBox(width: 20),
                        Radio(
                          value: 2,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value as int;
                            });
                          },
                        ),
                        Text('Нийлүүлэгч'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Утасны дугаар",
                        prefixIcon: Icon(Icons.phone),
                        border: InputBorder.none, // Remove the default border
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0), // Adjust padding as needed
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Нууц үг",
                        prefixIcon: Icon(
                            Icons.lock), // Changed icon to lock for password
                        border: InputBorder.none, // Remove the default border
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0), // Adjust padding as needed
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (selectedOption == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Burtgel()));
                            print("USER SHUU");
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NiiluulegchRegister()));
                            print("VENDOR SHUU");
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 18),
                          ),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.transparent;
                              }
                              return null;
                            },
                          ),
                        ),
                        child: Text("Бүртгүүлэх"),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text(
                      "Нэвтрэх",
                      style: TextStyle(fontSize: 21),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.cyan),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      fixedSize:
                          MaterialStateProperty.all<Size>(Size.fromHeight(50)),
                    ),
                    onPressed: () {
                      _signInWithEmailAndPassword();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
