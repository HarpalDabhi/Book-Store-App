import 'dart:async';

import 'package:bookstore/GradientContainer.dart';
import 'package:bookstore/admin_login.dart';
import 'package:bookstore/book_collection_screen.dart';
import 'package:bookstore/home_screen.dart';
import 'package:bookstore/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  bool obscure_pwd = true;
  bool isLogin = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  void _Login() async {
    String email_ = _email.text.trim();
    String pwd_ = _password.text.trim();

    if (email_ == "" || pwd_ == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill all the fields"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email_, password: pwd_);

        setState(() {
          isLogin = true;
        });

        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Timer(Duration(seconds: 2), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => home_screen()));
          });
        }
      } catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ex.toString()),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientCont(),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 70, left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/icons/book_store_logo.png',
                    width: 200,
                  ),
                  Text(
                    'Log in',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent.shade700),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(7),
                      prefixIconColor: Colors.blueAccent,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: 35,
                      ),
                      hintText: 'Email',
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
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _password,
                    obscureText: obscure_pwd,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(7),
                      prefixIconColor: Colors.blueAccent,
                      suffixIconColor: Colors.blueAccent,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure_pwd = !obscure_pwd;
                            });
                          },
                          icon: Icon(obscure_pwd
                              ? (Icons.visibility)
                              : (Icons.visibility_off))),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 35,
                      ),
                      hintText: 'Password',

                      hintStyle: TextStyle(color: Colors.blueAccent.shade200),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                              color: Colors.blueAccent.shade200, width: 3)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                        _Login();
                      },
                      child:isLogin?CircularProgressIndicator(): Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => register_page()));
                        },
                        child: Text(
                          "Create new",
                          style: TextStyle(color: Colors.blue.shade800),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    GestureDetector(
                      onTap: () {
                         Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => admin_login()));
                      },
                      child: Text("Admin Login",style: TextStyle(fontSize: 20,color: Colors.green),),)
                  ],),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
