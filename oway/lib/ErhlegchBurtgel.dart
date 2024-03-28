import "package:flutter/material.dart";
import "package:oway/login.dart";

class Burtgel extends StatefulWidget{
  
  @override
  State<Burtgel> createState() => _Burtgel();
}

class _Burtgel extends State<Burtgel>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Бүртгүүлэх хэсэг")
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
                keyboardType: TextInputType.emailAddress,
                //controller gdg zuil orj ireh bh
                decoration: InputDecoration(
                  labelText: "Овог",
                  border: OutlineInputBorder(),
                  //prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Нэр",
                  border: OutlineInputBorder(),
                  //prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Эрхэлдэг үйлдвэрлэл",
                  border: OutlineInputBorder(),
                  //prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20,),
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
              SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Password давтан оруулна уу.",
                  border: OutlineInputBorder(),
                  //prefixIcon: Icon(Icons.password),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text("Бүртгүүлэх", style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}