import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oway/Models/Vendor.dart' as local_vendor;

class NiiluulegchRegister extends StatefulWidget {
  const NiiluulegchRegister({Key? key}) : super(key: key);
  @override
  _NiiluulegchRegisterState createState() => _NiiluulegchRegisterState();
}

class _NiiluulegchRegisterState extends State<NiiluulegchRegister> {
  String? selectNiiluulegch;
  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  String? selectedNerA;
  String? selectedNerB;
  String? selectedNerC;
  File? myImage;
  String? mergejil;
  //ed nariig garaas avch bui utgandaa ashigliydaa ho, odoo FLAdaltsy, uur arga uldsngu
  final TextEditingController ovog = TextEditingController();
  final TextEditingController ner = TextEditingController();
//  final TextEditingController mergejil = TextEditingController();
  final TextEditingController registr = TextEditingController();
  final TextEditingController utasnii_dugaar =TextEditingController();
  final TextEditingController password =TextEditingController();
  final TextEditingController password_confirm =TextEditingController();
  final TextEditingController hayg_delgerengui =TextEditingController();
  final TextEditingController image_path =TextEditingController(); //eniig ghdee sn sudalnaa
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  var nerHayg;
  var nerHayg1;
  var nerHayg2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Өрхийн үйлдвэрлэл эрхлэгч иргэний бүртгэл'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: ovog,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Овог",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: ner,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Нэр",
                  border: OutlineInputBorder(),
                ),
              ),



              SizedBox(height: 10.0),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('NiiluulegchType').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final List<DropdownMenuItem<String>> items = [];
                  snapshot.data!.docs.forEach((doc) {
                    items.add(
                      DropdownMenuItem(
                        value: doc.id,
                        child: Text(doc['ner']),
                      ),
                    );
                  });

                  return DropdownButton<String>(
                    items: items,
                    onChanged: (String? value) {
                      setState(() {
                        mergejil = value;
                      });
                      print('Selected mergejil: $mergejil');
                    },
                    value: mergejil,
                    hint: mergejil != null ? Text(mergejil!) : Text('Select Item'),
                  );
                },
              ),

            Text('Ажил: $mergejil'),



              SizedBox(height: 10,),
              TextFormField(
                controller: registr,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Регистр",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: utasnii_dugaar,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Утасны дугаар",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Нууц үг",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: password_confirm,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Нууц үг дахин оруулна уу.",
                  border: OutlineInputBorder(),
                ),
              ),



              StreamBuilder<QuerySnapshot>(
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
                    nerHayg = program['ner'];
                    programItems1.add(
                      DropdownMenuItem<String>(
                        value: program.id,
                        child: Text(
                          nerHayg,
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
                          value: selectedValue1,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue1 = value;
                              selectedValue2 = null;
                              selectedValue3 = null;
                            });
                          },
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: const Text(
                            "Аймаг/Хот",
                            style: TextStyle(fontSize: 20),
                          ),
                          items: programItems1,
                        ),

                        if (selectedValue1 != null)
                          FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("AimagHot")
                                .doc(selectedValue1)
                                .collection("Duureg")
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text("Error fetching subcollection: ${snapshot.error}");
                              }
                              List<DropdownMenuItem<String>> programItems2 = [];
                              snapshot.data?.docs.forEach((doc) {
                                nerHayg1 = doc['ner'];
                                programItems2.add(
                                  DropdownMenuItem<String>(
                                    value: doc.id,
                                    child: Text(
                                      nerHayg1,
                                    ),
                                  ),
                                );
                              });
                              return DropdownButton<String>(
                                underline: SizedBox(),
                                isExpanded: true,
                                hint: const Text(
                                  "Сум/Дүүрэг",
                                  style: TextStyle(fontSize: 20),
                                ),
                                value: selectedValue2,
                                items: programItems2,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedValue2 = value;
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
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text("Error fetching subcollection: ${snapshot.error}");
                              }
                              List<DropdownMenuItem<String>> programItems3 = [];
                              snapshot.data?.docs.forEach((doc) {
                                nerHayg2 = doc['ner'];
                                programItems3.add(
                                  DropdownMenuItem<String>(
                                    value: doc.id,
                                    child: Text(
                                      nerHayg2,
                                    ),
                                  ),
                                );
                              });
                              return DropdownButton<String>(
                                underline: SizedBox(),
                                isExpanded: true,
                                hint: const Text(
                                  "Баг/Хороо",
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


              SizedBox(height: 10,),
              TextFormField(
                controller: hayg_delgerengui,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Хаягийн дэлгэрэнгүй",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  getImage(ImageSource.gallery); // Open gallery to select image
                },
                child: Text('Цээж зураг оруулах'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  //print('Mergejil orj irmeerenshu $mergejil');
                  //print("Aimag hot shuu ho: "+nerHayg);
                  //print("sum duureg shuu ho: "+nerHayg1);
                  //print("bag horoo shuu ho: "+nerHayg2);
                  if (password.text == password_confirm.text){
                  final surname = ovog.text;
                  final name = ner.text;
                  final work = mergejil;
                  final registerNumber = registr.text;
                  final phone = utasnii_dugaar.text;
                  final password = password_confirm.text;
                  final hayg = (nerHayg+"-"+nerHayg1+"-"+nerHayg2);
                  final delgerengui = hayg_delgerengui.text;
                  final orshinSuugaa = hayg_delgerengui.text; //turdee ingd tavichy, alban ysnii hayg avah tul bjig
                  final tseejZurag = await uploadFile((downloadURL) {
                      print("Download URL tseejZurgan dotor: $downloadURL");
                    });
                  createVendor(
                    surname: surname,
                    name: name,
                    work: work.toString(),
                    registerNumber: registerNumber,
                    phone: phone,
                    password: password,
                    hayg: hayg,
                    delgerengui: delgerengui,
                    orshinSuugaa: orshinSuugaa,
                    tseejZurag: tseejZurag.toString(),
                    );
                    openBottomSheet();
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
                child: Text('Бүртгүүлэх'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        width: double.infinity,
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildImageWidget(
              iconData: Icons.camera_alt,
              onPressed: () {
                getImage(ImageSource.camera); // Open camera to take a picture
              },
            ),
            buildImageWidget(
              iconData: Icons.image,
              onPressed: () {
                getImage(ImageSource.gallery); // Open gallery to select image
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageWidget({
    required IconData iconData,
    required Function onPressed,
  }) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            iconData,
            size: 30,
          ),
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      myImage = File(image.path);
      print("Selected image: ${myImage?.path}");
      uploadFile(onUploadComplete); // Call the uploadFile function
      setState(() {});
      Get.back(); // Close the bottom sheet
    } else {
      print("No image selected.");
    }
  }

  Future<String?> uploadFile(void Function(String) onUploadComplete) async {
  if (myImage == null) {
    print("No image selected for upload.");
    return null;
  }

  final file = myImage!;
  final metaData = SettableMetadata(contentType: 'image/jpeg');
  final storageRef = FirebaseStorage.instance.ref();
  Reference ref = storageRef.child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
  final uploadTask = ref.putFile(file, metaData);

  try {
    await uploadTask;
    final downloadURL = await ref.getDownloadURL();
    onUploadComplete(downloadURL);
    return downloadURL;
  } catch (error) {
    print("Upload failed with error: $error");
    return null;
  }
}

  // void onUploadComplete(String downloadURL) {
  //   print("File uploaded successfully. Download URL: $downloadURL");
  //   ene bol zapaas bas umnuh version
  // }

  void onUploadComplete(String downloadURL) {
    print("$downloadURL");
    // ene ajillaj bga
  }
Future createVendor({
  required String surname,
  required String name,
  required String work,
  required String registerNumber,
  required String phone,
  required String password,
  required String hayg,
  required String delgerengui,
  required String orshinSuugaa,
  required String tseejZurag,
}) async {
  try {
    final firebase_auth.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: utasnii_dugaar.text.trim() + "@gmail.com",
      password: password.trim(),
    );

    // Get the document reference for the new user
    final docUser = FirebaseFirestore.instance.collection('Vendor').doc(userCredential.user!.uid);

    final local_vendor.Vendor user = local_vendor.Vendor(
      id: userCredential.user!.uid, // Assign the user's credential ID as the document ID
        surname: surname,
        name: name,
        work: work,
        registerNumber: registerNumber,
        phone: phone,
        password: password,
        hayg: hayg,
        delgerengui: delgerengui,
        orshinSuugaa: orshinSuugaa,
        tseejZurag: tseejZurag,
    );
    final json = user.toJson();

    await docUser.set(json);
    
    print("User successfully created and registered: ${userCredential.user!.uid}");
  } catch (e) {
    print("Error creating user: $e");
  }
}
}

//ene ih heregtei ed
                  //  final tseejZurag = await uploadFile((downloadURL) {
                  //     print("Download URL: $downloadURL");
                  //   });
                  //   print("Download URL in tseejZurag: $tseejZurag");