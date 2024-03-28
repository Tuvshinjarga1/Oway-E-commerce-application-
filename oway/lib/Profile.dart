import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Профайл"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/registerpro.png',
                    height: 155,
                    width: 155,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        "Нэр: Х. Ариунзаяа",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Утас: 99119911",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.archive,
                            size: 40.0,
                            color: Colors.cyan,
                          ),
                          SizedBox(height: 10),
                          Text("Худалдан"),
                          Text("авалтын түүх"),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.badge,
                            size: 40.0,
                            color: Colors.cyan,
                          ),
                          SizedBox(height: 10),
                          Text("Хадгалсан"),
                          Text("ӨҮЭИ"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Text("Сүүлд хадгалсан:",
              style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: Text('Бүтээгдэхүүн $index'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
