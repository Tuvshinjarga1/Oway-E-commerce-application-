import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseDropdownMenuItem extends StatefulWidget {
  const FirebaseDropdownMenuItem({Key? key}) : super(key: key);

  @override
  _FirebaseDropdownMenuItemState createState() =>
      _FirebaseDropdownMenuItemState();
}

class _FirebaseDropdownMenuItemState extends State<FirebaseDropdownMenuItem> {
  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3; // Declare selectedValue3

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("AimagHot").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Some error occurred ${snapshot.error}"),
            );
          }
          List<DropdownMenuItem<String>> programItems1 = [];
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final selectProgram = snapshot.data?.docs.reversed.toList();
            if (selectProgram != null) {
              for (var program in selectProgram) {
                programItems1.add(
                  DropdownMenuItem<String>(
                    value: program.id,
                    child: Text(
                      program['ner'],
                    ),
                  ),
                );
              }
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.only(right: 15, left: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    DropdownButton<String>(
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: const Text(
                        "Select the First Item",
                        style: TextStyle(fontSize: 20),
                      ),
                      value: selectedValue1,
                      items: programItems1,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue1 = value;
                          // Reset other selected values
                          selectedValue2 = null;
                          selectedValue3 = null;
                        });
                      },
                    ),
                    if (selectedValue1 != null)
                      FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("AimagHot")
                            .doc(selectedValue1)
                            .collection("Duureg")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text(
                                "Error fetching subcollection: ${snapshot.error}");
                          }
                          List<DropdownMenuItem<String>> programItems2 = [];
                          snapshot.data?.docs.forEach((doc) {
                            programItems2.add(
                              DropdownMenuItem<String>(
                                value: doc.id,
                                child: Text(
                                  doc['ner'],
                                ),
                              ),
                            );
                          });
                          return DropdownButton<String>(
                            underline: SizedBox(),
                            isExpanded: true,
                            hint: const Text(
                              "Select the Second Item",
                              style: TextStyle(fontSize: 20),
                            ),
                            value: selectedValue2,
                            items: programItems2,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue2 = value;
                                // Reset third selected value
                                selectedValue3 = null;
                              });
                            },
                          );
                        },
                      ),
                    if (selectedValue2 != null)
                      FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("AimagHot")
                            .doc(selectedValue1)
                            .collection("Duureg")
                            .doc(selectedValue2)
                            .collection("Horoo")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text(
                                "Error fetching subcollection: ${snapshot.error}");
                          }
                          List<DropdownMenuItem<String>> programItems3 = [];
                          snapshot.data?.docs.forEach((doc) {
                            programItems3.add(
                              DropdownMenuItem<String>(
                                value: doc.id,
                                child: Text(
                                  doc['ner'],
                                ),
                              ),
                            );
                          });
                          return DropdownButton<String>(
                            underline: SizedBox(),
                            isExpanded: true,
                            hint: const Text(
                              "Select the Third Item",
                              style: TextStyle(fontSize: 20),
                            ),
                            value: selectedValue3,
                            items: programItems3,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue3 = value;
                              });
                            },
                          );
                        },
                      ),
                    if (selectedValue3 != null)
                      Text("You selected: $selectedValue3"),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
