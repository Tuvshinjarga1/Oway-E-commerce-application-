import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:oway/Models/User.dart';
class Burtgel extends StatefulWidget {
  @override
  State<Burtgel> createState() => _BurtgelState();
}

class _BurtgelState extends State<Burtgel> {
  // Controllers for the TextFormFields
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Regex pattern for password validation
  String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  // Regex pattern for phone number validation
  String phoneRegex = r'^\+?[0-9]{10,}$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Бүртгүүлэх хэсэг"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/registerpro.png",
                height: 200,
                width: 200,
              ),
              SizedBox(height: 50,),
              TextFormField(
                controller: lastNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Овог",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: firstNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Нэр",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Утасны дугаар",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (!RegExp(phoneRegex).hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true, // Hide password
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  if (!RegExp(passwordRegex).hasMatch(value)) {
                    return 'Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password давтан оруулна уу.",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text(
                  "Бүртгүүлэх",
                  style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
                ),
                onPressed: () {
                  if (passwordController == confirmPasswordController){
                  final surname = lastNameController.text;
                  final name = firstNameController.text;
                  final phone = phoneController.text;
                  final password = passwordController.text;
                  createUser(
                    surname: surname,
                    name: name,
                    phone: phone,
                    password: password,
                    );
                  print("Амжилттай бүртгэгдлээ");
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(phone+' дугаартай хэрэглэгч амжилттай бүртгэгдлээ.')),
                  );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password таарахгүй байна.')),
                  );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createUser({
    required String surname,
    required String name,
    required String phone,
    required String password,
    }) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc();

    final user = User(
      id: docUser.id,
      surname: surname,
      name: name,
      phone: phone,
      password: password
      );
    final json = user.toJson();

    await docUser.set(json);
  }

  // Function to validate all form fields
  bool validateInputs() {
    if (lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Овог нэрээ оруулна уу.')),
      );
      return false;
    }
    if (firstNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Нэрээ оруулна уу.')),
      );
      return false;
    }
    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Утасны дугаар оруулна уу.')),
      );
      return false;
    }
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password оруулна уу.')),
      );
      return false;
    }
    if (confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password баталгаажуулна уу,')),
      );
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password таарахгүй байна.')),
      );
      return false;
    }
    return true;
  }
}
