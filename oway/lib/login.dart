import "package:flutter/material.dart";
import "package:oway/Register/HereglegchBurtgel.dart";
import "package:oway/home.dart";

class Login extends StatefulWidget{
  
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Image.asset(
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
              alignment:Alignment.center,
              child: Text("Нэвтрэх",
              style: TextStyle(fontSize: 24, color: Colors.cyan, fontWeight: FontWeight.bold),
              ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Утасны дугаар",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                  alignment: Alignment.centerRight, // Adjust alignment as needed
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Set text color
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 18)), // Set text style
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.transparent; // Change the color when hovered
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
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}