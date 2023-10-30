import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:bookstore/GradientContainer.dart';
import 'package:bookstore/home_screen.dart';
import 'package:bookstore/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({super.key});

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  bool isSigningOut = false;
  String userName = "Dabhi Harpal";
  File? profile_pic;

// Check if a user is signed in
  User? user = FirebaseAuth.instance.currentUser;

 

  void Logout() async {
    FirebaseAuth.instance.signOut();

    setState(() {
      isSigningOut = true;
    });

    Timer(Duration(seconds: 2), () {
      Navigator.popUntil(context, (route) => route.isFirst);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => login_page()));
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
                                    height: MediaQuery.of(context).size.height/4,
                                    child: 
                                  Column(
                                    
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
                                                  source: ImageSource.gallery);
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

                          // XFile? selected_image = await ImagePicker()
                          //     .pickImage(source: ImageSource.camera);
                          // if (selected_image != null) {
                          //   print("Image selected");

                          //   File converted_file = File(selected_image.path);

                          //   setState(() {
                          //     profile_pic = converted_file;
                          //   });
                          // }
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
                    "${userName}",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(user != null
                      ? user!.email.toString()
                      : "hdabhi902@rku.ac.in"),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => home_screen()));
                    },
                    child: ListTile(
                      title: Text("Dashboard"),
                      trailing: Icon(Icons.home),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Favourite"),
                    trailing: Icon(Icons.favorite),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Notification"),
                    trailing: Icon(Icons.notifications),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Activity"),
                    trailing: Icon(Icons.av_timer_sharp),
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
