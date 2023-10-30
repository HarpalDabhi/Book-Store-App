import 'package:flutter/material.dart';
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

class summary_screen extends StatefulWidget {
  const summary_screen({super.key});

  @override
  State<summary_screen> createState() => _summary_screenState();
}

class _summary_screenState extends State<summary_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Biography').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              final data = document.data();
              // return ListTile(
              //  title: Image.network(data['Image']),
              //   subtitle: Text(data['Summary']),
              // );
              return Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                  color: Colors.blueAccent.shade100,
                  child: Column(
                    children: [
                     Padding(padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),child:  Card(color: Colors.blueAccent.shade100,
                      child: Image.network(data['Image']),elevation: 5,)),
                      SizedBox(
                        height: 5,
                      ),
                     Padding(padding: EdgeInsets.all(5),child:  Text(
                        data['Summary'],
                        style: TextStyle(fontSize: 15),
                      ),)
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
