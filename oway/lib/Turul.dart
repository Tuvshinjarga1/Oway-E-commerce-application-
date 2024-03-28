import 'package:flutter/material.dart';
import 'package:oway/ErhlegchBurtgel.dart';

class Ouei extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Төрөл",
      home: Scaffold(
        appBar: AppBar(title: Image.asset(
        'assets/oway.png',
        height: 100,
        width: 100,
      ),
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
              alignment:Alignment.center,
              child: Text("Төрлөө сонгоно уу",
              style: TextStyle(fontSize: 22, color: Colors.cyan),
              ),
              ),
              SizedBox(height: 30,),
              Align(
              alignment:Alignment.center,
              child: Text("Өөрт тохирох төрлөө сонгосноор зөвхөн танд зориулсан үйлчилгээг авах болно",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
              ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_box,
                          size: 40.0,
                          color: Colors.black,
                        ),
                        SizedBox(width: 150, height: 50,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Захиалагч"),
                          ],
                        )
                      ],
                      ),
                  ),
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.badge,
                          size: 40.0,
                          color: Colors.black,
                        ),
                        SizedBox(width: 150, height: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Өрхийн үйлдвэрлэл"),
                            Text("эрхлэгч иргэн"),
                          ],
                        )
                      ],
                      ),
                  )
                ],
              ),
              SizedBox(height: 50,),
              ElevatedButton(
                child: Text("Үргэлжлүүлэх", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Burtgel()));
                },
              ),
            ]
          ),
        ),
      ),
    );
  }
}