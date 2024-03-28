import "package:flutter/material.dart";
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
              Align(
              alignment: FractionalOffset(0.8, 0.8),
              child: Text("Бүртгүүлэх",
              style: TextStyle(fontSize: 18)),
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