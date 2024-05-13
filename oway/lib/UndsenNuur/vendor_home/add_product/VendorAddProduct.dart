import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oway/Models/Product.dart' as local_product;

class VendorAddProduct extends StatefulWidget {
  final String userId;
  const VendorAddProduct({Key? key, required this.userId}) : super(key: key);
  @override
  _VendorAddProductState createState() => _VendorAddProductState();
}

class _VendorAddProductState extends State<VendorAddProduct> {
  String _userId = "";

  @override
  void initState() {
    super.initState();
    print("pls orood ireech UserID: ${widget.userId}");
    getUserData(widget.userId);
  }

  Future<void> getUserData(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('Vendor').doc(userId).get();
    setState(() {
      _userId = userSnapshot['id'];
    });
  }

  String? selectAngilal;
  String? selectDed_Angilal;
  String? selectBelen_eseh;
  String? selectHugatsaa;
  String? selectHemjuur;
  File? myImage;
  //ed nariig garaas avch bui utgandaa ashigliydaa ho, odoo FLAdaltsy, uur arga uldsngu
  final TextEditingController ner = TextEditingController();
  final TextEditingController une = TextEditingController();
  final TextEditingController angilal = TextEditingController();
  final TextEditingController ded_angilal = TextEditingController();
  final TextEditingController nemelt_tailbar = TextEditingController();
  final TextEditingController belen_eseh = TextEditingController();
  final TextEditingController hugatsaa = TextEditingController();
  final TextEditingController too_shirheg =
      TextEditingController(); //eniig ghdee sn sudalnaa

  String? selectedCategory;
  String? selectedSubcategory;
  List<String> categories = [
    "Мах махан бүтээгдэхүүн",
    "Сүүн бүтээгдэхүүн",
    "Хувцас"
  ]; // Example categories
  List<String> subcategories = [
    "Subcategory 1",
    "Subcategory 2",
    "Subcategory 3"
  ]; // Example subcategories
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Өрхийн үйлдвэрлэл эрхлэгч иргэний бүртгэл'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    getImage(
                        ImageSource.gallery); // Open gallery to select image
                  },
                  child: Text('Бүтээгдэхүүний зураг оруулах'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                    border: Border
                        .all(), // You can customize border properties here
                  ),
                  child: TextFormField(
                    controller: ner,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Нэр",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      // To remove the default border
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                    border: Border
                        .all(), // You can customize border color and width here
                  ),
                  child: TextFormField(
                    controller: une,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Үнэ",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ), // Hide default border
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          border: Border
                              .all(), // You can customize border color and width here
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedCategory,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategory = newValue;
                            });
                          },
                          items: categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: "Ангилал",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ), // Hide default border
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          border: Border
                              .all(), // You can customize border color and width here
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedSubcategory,
                          onChanged: (newValue) {
                            setState(() {
                              selectedSubcategory = newValue;
                            });
                          },
                          items: subcategories.map((subcategory) {
                            return DropdownMenuItem<String>(
                              value: subcategory,
                              child: Text(subcategory),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: "Дэд ангилал",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ), // Hide default border
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                    border: Border
                        .all(), // You can customize border color and width here
                  ),
                  child: TextFormField(
                    controller: une,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Нэмэлт тайлбар",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ), // Hide default border
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Aligns the children at the center horizontally
                    children: [
                      Radio(
                        value: "Бэлэн",
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value as String?;
                          });
                        },
                      ),
                      Text("Бэлэн"),
                      Radio(
                        value: "Бэлэн бус",
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value as String?;
                          });
                        },
                      ),
                      Text("Бэлэн бус"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                    border: Border
                        .all(), // You can customize border color and width here
                  ),
                  child: TextFormField(
                    controller: une,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Бэлэн болох хугацаа",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                    border: Border
                        .all(), // You can customize border color and width here
                  ),
                  child: TextFormField(
                    controller: une,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Тоо ширхэг",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ), // Hide default border
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text(
                    "Бүтээгдэхүүн нэмэх",
                    style: TextStyle(fontSize: 21),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.cyan),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    fixedSize:
                        MaterialStateProperty.all<Size>(Size.fromHeight(50)),
                  ),
                  onPressed: () async {
                    String nerValue = ner.text;
                    String uneValue = une.text;
                    String nemeltTailbarValue = nemelt_tailbar.text;
                    String hugatsaaValue = hugatsaa.text;
                    String too_shirhegValue = too_shirheg.text;
                    // print('Нэр: $nerValue');
                    // print('Үнэ: $uneValue');
                    // if(selectedCategory != null) {
                    //   print('Ангилал: $selectedCategory');
                    // }
                    // if(selectedSubcategory != null) {
                    //   print('Дэд ангилал: $selectedSubcategory');
                    // }

                    // print('Нэмэлт тайлбар: $nemeltTailbarValue');
                    // if(selectedOption != null) {
                    //   print('Бэлэх эсэх: $selectedOption');
                    // }
                    // print('Бүтээгдэхүүн болох хугацаа: $hugatsaaValue');
                    // print('Тоо ширхэг: $too_shirhegValue');
                    // print(_userId);
                    final zurag = await uploadFile((downloadURL) {
                      print("Download URL buteeghuunZurag dotor: $downloadURL");
                    });
                    final ner1 = nerValue;
                    final une1 = uneValue;
                    final angilal1 = selectedCategory;
                    final ded_angilal1 = selectedSubcategory;
                    final nemelt_tailbar1 = nemeltTailbarValue;
                    final belen_eseh1 = selectedOption;
                    final hugatsaa1 = hugatsaaValue;
                    final too_shirheg1 = too_shirhegValue;
                    createProduct(
                      Vendorid: _userId,
                      zurag: zurag.toString(),
                      ner: ner1,
                      une: une1,
                      angilal: angilal1.toString(),
                      ded_angilal: ded_angilal1.toString(),
                      nemelt_tailbar: nemelt_tailbar1,
                      belen_eseh: belen_eseh1.toString(),
                      hugatsaa: hugatsaa1,
                      too_shirheg: too_shirheg1,
                    );
                    openBottomSheet();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Бүтээгдэхүүн амжилттай бүртгэгдлээ')),
                    );
                  },
                ),
              ],
            ),
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
    Reference ref = storageRef
        .child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
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

  void onUploadComplete(String downloadURL) {
    print("$downloadURL");
    // ene ajillaj bga
  }

  Future<void> createProduct({
    required String Vendorid,
    required String zurag,
    required String ner,
    required String une,
    required String angilal,
    required String ded_angilal,
    required String nemelt_tailbar,
    required String belen_eseh,
    required String hugatsaa,
    required String too_shirheg,
  }) async {
    final docProduct =
        FirebaseFirestore.instance.collection('VendorProduct').doc();
    String docId = docProduct.id;
    final local_product.Product product = local_product.Product(
      Vendorid: Vendorid,
      id: docId,
      zurag: zurag,
      ner: ner,
      une: une,
      angilal: angilal,
      ded_angilal: ded_angilal,
      nemelt_tailbar: nemelt_tailbar,
      belen_eseh: belen_eseh,
      hugatsaa: hugatsaa,
      too_shirheg: too_shirheg,
    );
    final json = product.toJson();

    await docProduct.set(json);

    print("Product successfully created and vendorID: $Vendorid");
    print("Product id: $docId");
  }
}
