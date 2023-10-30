import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:bookstore/add_biography_book.dart';
import 'package:bookstore/add_historical_book.dart';
import 'package:bookstore/add_story_books.dart';
import 'package:bookstore/admin_login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bookstore/GradientContainer.dart';
import 'package:bookstore/home_screen.dart';
import 'package:bookstore/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class admin_profile extends StatefulWidget {
  const admin_profile({super.key});

  @override
  State<admin_profile> createState() => _admin_profileState();
}

class _admin_profileState extends State<admin_profile> {
  bool isSigningOut = false;
  String userName = "Dabhi Harpal";
  File? profile_pic;

  void Logout() async {
    setState(() {
      isSigningOut = true;
    });

    Timer(Duration(seconds: 1), () {
      Navigator.popUntil(context, (route) => route.isFirst);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => admin_login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Profile"),
      ),
      body: Stack(
        children: [
          GradientCont(),
          Padding(
            padding: EdgeInsets.all(5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: Text("Select Image"),
                                  content: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text("Camera"),
                                          onTap: () async {
                                            XFile? selected_image =
                                                await ImagePicker().pickImage(
                                                    source: ImageSource.camera);
                                            if (selected_image != null) {
                                              print("Image selected");

                                              File converted_file =
                                                  File(selected_image.path);

                                              setState(() {
                                                profile_pic = converted_file;
                                              });
                                            }
                                          },
                                        ),
                                        Divider(),
                                        ListTile(
                                          leading: Icon(Icons.photo),
                                          title: Text("Gallary"),
                                          onTap: () async {
                                            XFile? selected_image =
                                                await ImagePicker().pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (selected_image != null) {
                                              print("Image selected");

                                              File converted_file =
                                                  File(selected_image.path);

                                              setState(() {
                                                profile_pic = converted_file;
                                              });
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    GestureDetector(
                                      child: Text("Close"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              }));
                        },
                        child: CircleAvatar(
                          minRadius: 90,
                          backgroundImage: (profile_pic != null)
                              ? FileImage(profile_pic!)
                              : null,
                          backgroundColor: Colors.amber,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Dabhi Harpal",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text("hdabhi902@rku.ac.in"),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return add_historical_book();
                      }));
                    },
                    child: ListTile(
                      title: Text("Add Historic Book"),
                      trailing: Icon(Icons.favorite),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return add_biography_book();
                      }));
                    },
                    child: ListTile(
                      title: Text("Add Biography Book"),
                      trailing: Icon(Icons.favorite),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return add_story_book();
                      }));
                    },
                    child: ListTile(
                      title: Text("Add Story Book"),
                      trailing: Icon(Icons.favorite),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Logout();
                    },
                    child: isSigningOut
                        ? CircularProgressIndicator()
                        : Text(
                            "Logout",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
