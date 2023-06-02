import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class adminAddQuiz extends StatefulWidget {
  const adminAddQuiz({super.key, required this.category});
  final String category;

  @override
  State<adminAddQuiz> createState() => _adminAddQuizState();
}

class _adminAddQuizState extends State<adminAddQuiz> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  File? _pickedImage;

  Text text(String text, double size, Color color,
      {FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(114, 96, 125, 139),
                radius: MediaQuery.of(context).size.width * 0.3,
                backgroundImage: _pickedImage == null
                    ? null
                    : FileImage(_pickedImage as File),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: text(
                                      "choose the option", 22, Colors.black),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            final pick = ImagePicker();
                                            final pickedImage =
                                                await pick.pickImage(
                                                    source: ImageSource.camera,
                                                    imageQuality: 100);
                                            final pickeded =
                                                File(pickedImage!.path);

                                            setState(() {
                                              _pickedImage = pickeded;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.camera_alt),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              text("camera", 19, Colors.black)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            final pick = ImagePicker();
                                            final pickedImage =
                                                await pick.getImage(
                                                    source: ImageSource.gallery,
                                                    imageQuality: 100);
                                            final pickeded =
                                                File(pickedImage!.path);
                                            setState(() {
                                              _pickedImage = pickeded;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.image),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              text("gallery", 19, Colors.black)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.cancel_outlined),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              text("cancel", 19, Colors.black)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.101,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.1,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.camera_alt,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              if (_pickedImage != null) {
                final ref = await FirebaseStorage.instance
                    .ref()
                    .child("quizImages")
                    .child("turki.jpg");
                await ref.putFile(_pickedImage as File);
              } else {
                // my code here
              }
            },
            child: Text('TextButton'),
          )
        ],
      ),
    );
  }
}
