import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bookstore/GradientContainer.dart';
import 'package:bookstore/home_screen.dart';
import 'package:bookstore/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class add_biography_book extends StatefulWidget {
  const add_biography_book({super.key});

  @override
  State<add_biography_book> createState() => _add_biography_bookState();
}

class _add_biography_bookState extends State<add_biography_book> {
  bool isCreating = false;
  double uploadPercent = 100;
  File? profile_pic;
  TextEditingController _bookName = TextEditingController();
  TextEditingController _bookAuthor = TextEditingController();
  TextEditingController _bookLanguage = TextEditingController();
  TextEditingController _bookPrice = TextEditingController();
  TextEditingController _bookSummary = TextEditingController();

  void _CreateBookInfo() async {
    String bookName_ = _bookName.text.trim();
    String bookAuthor_ = _bookAuthor.text.trim();
    String bookLanguage_ = _bookLanguage.text.trim();
    String bookSummary_ = _bookSummary.text.trim();
    String bookPrice_ = _bookPrice.text.trim();

    if (bookName_ == "" ||
        bookAuthor_ == "" ||
        bookLanguage_ == "" ||
        bookSummary_ == "" ||
        bookPrice_ == "" ||
        profile_pic == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill all the fields"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    } else {
      // Create new Account

      setState(() {
        isCreating = true;
      });

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("BiographImage")
          .child(Uuid().v1())
          .putFile(profile_pic!);

      uploadTask.snapshotEvents.listen((event) {
        double percentage = event.bytesTransferred / event.totalBytes * 100;
        setState(() {
          uploadPercent = percentage;
        });
      });

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> NewBookData = {
        "Title": bookName_,
        "Author": bookAuthor_,
        "Language": bookLanguage_,
        "Price": bookPrice_,
        "Summary": bookSummary_,
        "Image": downloadUrl,
      };

      FirebaseFirestore.instance.collection("Biography").add(NewBookData);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Book Added Successfully"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));

      Timer(Duration(seconds: 1), () {
        setState(() {
          isCreating = false;
          _bookAuthor.clear();
          _bookName.clear();
          _bookLanguage.clear();
          _bookPrice.clear();
          _bookSummary.clear();
          profile_pic = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biography Book Add"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          GradientCont(),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: Text("Select Image"),
                              content: Container(
                                height: MediaQuery.of(context).size.height / 4,
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
                    },
                    child: CircleAvatar(
                      minRadius: 40,
                      child: uploadPercent > 90
                          ? null
                          : Text(
                              "${uploadPercent.toInt()} %",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                      backgroundImage: (profile_pic != null)
                          ? FileImage(profile_pic!)
                          : null,
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _bookName,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(7),
                      prefixIconColor: Colors.blueAccent,
                      prefixIcon: Icon(
                        Icons.book,
                        size: 35,
                      ),
                      hintText: 'Bookname',
                      hintStyle: TextStyle(color: Colors.blueAccent.shade200),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                              color: Colors.blueAccent.shade200, width: 3)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _bookAuthor,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(7),
                      prefixIconColor: Colors.blueAccent,
                      prefixIcon: Icon(
                        Icons.person,
                        size: 35,
                      ),
                      hintText: 'Book Author',

                      hintStyle: TextStyle(color: Colors.blueAccent.shade200),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                              color: Colors.blueAccent.shade200, width: 3)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _bookLanguage,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(7),
                      prefixIconColor: Colors.blueAccent,
                      prefixIcon: Icon(
                        Icons.language,
                        size: 35,
                      ),
                      hintText: 'Book Language',

                      hintStyle: TextStyle(color: Colors.blueAccent.shade200),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                              color: Colors.blueAccent.shade200, width: 3)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _bookPrice,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(7),
                      prefixIconColor: Colors.blueAccent,
                      suffixIconColor: Colors.blueAccent,

                      prefixIcon: Icon(
                        Icons.monetization_on,
                        size: 35,
                      ),
                      hintText: 'Book Price',
                      hintStyle: TextStyle(color: Colors.blueAccent.shade200),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                              color: Colors.blueAccent.shade200, width: 3)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _bookSummary,
                    decoration: InputDecoration(
                      suffixIconColor: Colors.blueAccent,
                      // contentPadding: EdgeInsets.all(7),
                      prefixIconColor: Colors.blueAccent,
                      helperMaxLines: 3,

                      prefixIcon: Icon(
                        Icons.summarize,
                        size: 35,
                      ),
                      hintText: 'Book Summary',
                      hintStyle: TextStyle(color: Colors.blueAccent.shade200),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                              color: Colors.blueAccent.shade200, width: 3)),
                    ),
                  ),
                  SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: 63,
                        minWidth: MediaQuery.of(context).size.width / 1.1),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade700,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0))),
                      onPressed: () {
                        // Handle registration logic here
                        _CreateBookInfo();
                      },
                      child: isCreating
                          ? CircularProgressIndicator()
                          : Text(
                              "Add Book",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
