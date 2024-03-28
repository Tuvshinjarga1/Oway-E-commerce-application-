import 'package:flutter/material.dart';
import 'package:oway/turul.dart';

void main() {
  runApp(MaterialApp(
    title: "Oway",
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget{
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: FractionalOffset(0.2, 0.5),
              child: Text("Өрхийн",
              style: TextStyle(fontSize: 22),
              ),
              ),
              Align(
              alignment: FractionalOffset(0.5, 0.5),
              child: Text("үйлдвэрлэлээс",
              style: TextStyle(fontSize: 22),
              ),
              ),
            Image.asset(
              'assets/ehleh.png',
              width: 350,
              height: 350,
            ),
            Align(
              alignment: FractionalOffset(0.8, 0.5),
              child: Text("таны гарт",
              style: TextStyle(fontSize: 22)),
              ),
            SizedBox(height: 20,),
            Align(
              alignment: FractionalOffset(0.5, 1.0),
              child: ElevatedButton(
                child: Text("Эхлэх",
              style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Ouei()));
                },
              ),
            )
          ],
        )
      ),
    );
  }
}