import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:oway/Register/HereglegchBurtgel.dart';
import 'package:oway/home.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _phoneNumberController.text, // Use email as phone number
        password: _passwordController.text,
      );
      // User successfully logged in, navigate to home page
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      // Handle login errors
      print("Error signing in: $e");
      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in. Please check your credentials."),
      ));
    }
  }

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
      body: Center(
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
                  style: TextStyle(fontSize: 24, color: Colors.cyan, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone, // Use phone keyboard type
                decoration: InputDecoration(
                  labelText: "Утасны дугаар",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Burtgel()));
                },
                style: ButtonStyle(
                  alignment: Alignment.centerRight,
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 18)),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
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
              SizedBox(height: 30,),
              ElevatedButton(
                child: Text("Нэвтрэх", style: TextStyle(fontSize: 21),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
                ),
                onPressed: () {
                  _signInWithEmailAndPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
