// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:get/get.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:typed_data';

// class NiiluulegchRegister extends StatefulWidget {
//   const NiiluulegchRegister({Key? key}) : super(key: key);
//   @override
//   _NiiluulegchRegisterState createState() => _NiiluulegchRegisterState();
// }

// class _NiiluulegchRegisterState extends State<NiiluulegchRegister> {
//   String? selectNiiluulegch;
//   String? selectedValue1;
//   String? selectedValue2;
//   String? selectedValue3;
//   TextEditingController _textFieldController = TextEditingController();
//   File? _selectedFile; // Change the type to File?
//   File? myImage;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Form Example'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _textFieldController,
//                 decoration: InputDecoration(labelText: 'Овог'),
//                 style: TextStyle(fontSize: 12),
//               ),
//               TextFormField(
//                 controller: _textFieldController,
//                 decoration: InputDecoration(labelText: 'Нэр'),
//                 style: TextStyle(fontSize: 12),
//               ),
//               SizedBox(height: 16.0),
//               StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('NiiluulegchType')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   }
//                   if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   }
//                   final List<DropdownMenuItem> items = [];
//                   snapshot.data!.docs.forEach((doc) {
//                     items.add(
//                       DropdownMenuItem(
//                         value: doc.id,
//                         child: Text(doc['ner']),
//                       ),
//                     );
//                   });
//                   return DropdownButton(
//                     hint: Text('Эрхэлдэг чиглэлээ сонгоно уу.'),
//                     style: TextStyle(fontSize: 12),
//                     value: selectNiiluulegch,
//                     items: items,
//                     onChanged: (value) {
//                       setState(() {
//                         selectNiiluulegch = value as String?;
//                       });
//                     },
//                   );
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _textFieldController,
//                 decoration: InputDecoration(labelText: 'Регистр'),
//                 style: TextStyle(fontSize: 12),
//               ),
//               TextFormField(
//                 controller: _textFieldController,
//                 decoration: InputDecoration(labelText: 'Утасны дугаар'),
//                 style: TextStyle(fontSize: 12),
//               ),
//               TextFormField(
//                 controller: _textFieldController,
//                 decoration: InputDecoration(labelText: 'Нууц үг'),
//                 style: TextStyle(fontSize: 12),
//               ),
//               StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection("AimagHot")
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Center(
//                       child: Text("Some error occurred ${snapshot.error}"),
//                     );
//                   }
//                   List<DropdownMenuItem> programItems1 = [];
//                   if (!snapshot.hasData) {
//                     return const CircularProgressIndicator();
//                   } else {
//                     final selectProgram = snapshot.data?.docs.reversed.toList();
//                     if (selectProgram != null) {
//                       for (var program in selectProgram) {
//                         programItems1.add(
//                           DropdownMenuItem(
//                             value: program.id,
//                             child: Text(
//                               program['ner'],
//                             ),
//                           ),
//                         );
//                       }
//                     }

//                     return Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Container(
//                         padding: const EdgeInsets.only(right: 15, left: 15),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey, width: 1),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Column(
//                           children: [
//                             DropdownButton(
//                               underline: const SizedBox(),
//                               isExpanded: true,
//                               hint: const Text(
//                                 "Аймаг / Хот сонгоно уу",
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                               value: selectedValue1,
//                               items: programItems1,
//                               onChanged: (value) {
//                                 setState(() {
//                                   selectedValue1 = value;
//                                   // Reset other selected values
//                                   selectedValue2 = null;
//                                   selectedValue3 = null;
//                                 });
//                               },
//                             ),
//                             if (selectedValue1 != null)
//                               FutureBuilder<QuerySnapshot>(
//                                 future: FirebaseFirestore.instance
//                                     .collection("AimagHot")
//                                     .doc(selectedValue1)
//                                     .collection("Duureg")
//                                     .get(),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return CircularProgressIndicator();
//                                   }
//                                   if (snapshot.hasError) {
//                                     return Text(
//                                         "Error fetching subcollection: ${snapshot.error}");
//                                   }
//                                   List<DropdownMenuItem> programItems2 = [];
//                                   snapshot.data?.docs.forEach((doc) {
//                                     programItems2.add(
//                                       DropdownMenuItem(
//                                         value: doc.id,
//                                         child: Text(
//                                           doc['ner'],
//                                         ),
//                                       ),
//                                     );
//                                   });
//                                   return DropdownButton(
//                                     underline: SizedBox(),
//                                     isExpanded: true,
//                                     hint: const Text(
//                                       "Сум / Дүүрэг сонгоно уу",
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                     value: selectedValue2,
//                                     items: programItems2,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         selectedValue2 = value;
//                                         // Reset third selected value
//                                         selectedValue3 = null;
//                                       });
//                                     },
//                                   );
//                                 },
//                               ),
//                             if (selectedValue2 != null)
//                               FutureBuilder<QuerySnapshot>(
//                                 future: FirebaseFirestore.instance
//                                     .collection("AimagHot")
//                                     .doc(selectedValue1)
//                                     .collection("Duureg")
//                                     .doc(selectedValue2)
//                                     .collection("Horoo")
//                                     .get(),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return CircularProgressIndicator();
//                                   }
//                                   if (snapshot.hasError) {
//                                     return Text(
//                                         "Error fetching subcollection: ${snapshot.error}");
//                                   }
//                                   List<DropdownMenuItem> programItems3 = [];
//                                   snapshot.data?.docs.forEach((doc) {
//                                     programItems3.add(
//                                       DropdownMenuItem(
//                                         value: doc.id,
//                                         child: Text(
//                                           doc['ner'],
//                                         ),
//                                       ),
//                                     );
//                                   });
//                                   return DropdownButton(
//                                     underline: SizedBox(),
//                                     isExpanded: true,
//                                     hint: const Text(
//                                       "Баг / Хороо сонгоно уу",
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                     value: selectedValue3,
//                                     items: programItems3,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         selectedValue3 = value;
//                                       });
//                                     },
//                                   );
//                                 },
//                               ),
//                             if (selectedValue3 != null)
//                               Text("You selected: $selectedValue3"),
//                           ],
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               ),
//               TextFormField(
//                 controller: _textFieldController,
//                 decoration: InputDecoration(labelText: 'Хаягийн дэлгэрэнгүй'),
//                 style: TextStyle(fontSize: 12),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   FilePickerResult? result =
//                       await FilePicker.platform.pickFiles();
//                   if (result != null) {
//                     setState(() {
//                       _selectedFile = File(
//                           result.files.single.path!); // Use null-aware operator
//                     });
//                   }
//                 },
//                 child: Text('Цээж зураг оруулах'),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle form submission here
//                   openBottemSheet();
//                 },
//                 child: Text('Бүртгүүлэх'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   openBottemSheet() {
//     Get.bottomSheet(
//       Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(8), topRight: Radius.circular(8)),
//           ),
//           width: double.infinity,
//           height: 150,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               buildImageWidget(
//                   iconData: Icons.camera_alt,
//                   onPressed: () {
//                     getImage(ImageSource.camera);
//                   }),
//               buildImageWidget(
//                   iconData: Icons.image,
//                   onPressed: () {
//                     getImage(ImageSource.gallery);
//                   }),
//             ],
//           )),
//     );
//   }

//   buildImageWidget({required IconData iconData, required Function onPressed}) {
//     return InkWell(
//       onTap: () => onPressed(),
//       child: Container(
//         width: 100,
//         height: 100,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: Icon(
//             iconData,
//             size: 30,
//           ),
//         ),
//       ),
//     );
//   }

//   final ImagePicker _picker = ImagePicker();
//   getImage(ImageSource source) async {
//     final XFile? image = await _picker.pickImage(source: source);

//     if (image != null) {
//       myImage = File(image.path);
//       uploadFile(myImage!);
//       setState(() {});
//       Get.back();
//     }
//   }

//   void uploadFile(File file) async {
//     final metaData = SettableMetadata(contentType: 'image/jpeg');
//     final storageRef = FirebaseStorage.instance.ref();
//     Reference ref = storageRef
//         .child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');

//     if (kIsWeb) {
//       final bytes = await file.readAsBytes();
//       final uploadTask = ref.putData(bytes, metaData); // Use putData for web
//       await uploadTask;
//       final imageUrl = await ref.getDownloadURL();
//       print(imageUrl);
//     } else {
//       final uploadTask = ref.putFile(file, metaData); // Use putFile for mobile
//       uploadTask.snapshotEvents.listen((event) {
//         switch (event.state) {
//           case TaskState.running:
//             print("File is uploading");
//             break;
//           case TaskState.success:
//             ref.getDownloadURL().then((value) {
//               print(value);
//             });
//             break;
//           case TaskState.paused:
//             print("Paused");
//             break;
//           case TaskState.canceled:
//             print("Canceled");
//             break;
//           case TaskState.error:
//             print("Error");
//             break;
//         }
//       });
//     }
//   }
// }
