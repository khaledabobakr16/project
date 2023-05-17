import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/widgets.dart';

class ImageUploads extends StatefulWidget {
  ImageUploads({Key? key}) : super(key: key);

  @override
  _ImageUploadsState createState() => _ImageUploadsState();
}

class _ImageUploadsState extends State<ImageUploads> {
  var price = TextEditingController();
  var productname = TextEditingController();
  var made = TextEditingController();
  var discount = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(price.text, productname.text, made.text, discount.text);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(price.text, productname.text, made.text, discount.text);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile(var price, var proudctname, var made, var discount) async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('products')
          .add({
            'price': price, // John Doe
            'proudctname': proudctname, // Stokes and Sons
            'made': made,
            'url': url,
            'discount': discount
          })
          .then((value) => (print(value.id)))
          .catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              Container(
                width: context.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(35)),
                child: TxtFormName(
                    typecontrol: price,
                    prefixIconiconColor: Colors.grey,
                    prefixicon: Icons.price_check,
                    txt: "Enter the price of the car"),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: context.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(35)),
                child: TxtFormName(
                    typecontrol: productname,
                    prefixIconiconColor: Colors.grey,
                    prefixicon: Icons.car_crash,
                    txt: "Enter the car type"),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: context.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(35)),
                child: TxtFormName(
                    typecontrol: made,
                    prefixIconiconColor: Colors.grey,
                    prefixicon: Icons.date_range,
                    txt: "Enter the car model"),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: context.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(35)),
                child: TxtFormName(
                    typecontrol: discount,
                    prefixIconiconColor: Colors.grey,
                    prefixicon: Icons.discount_outlined,
                    txt: "Enter discount"),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blue.shade900,
                    child: _photo != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _photo!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
