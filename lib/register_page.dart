import 'dart:async';

import 'package:bookstore/GradientContainer.dart';
import 'package:bookstore/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class register_page extends StatefulWidget {
  const register_page({super.key});

  @override
  State<register_page> createState() => _register_pageState();
}

class _register_pageState extends State<register_page> {
  bool isCreating=false;
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _cpassword = TextEditingController();

  void _CreateAccount() async {
    String username_ = _username.text.trim();
    String email_ = _email.text.trim();
    String phone_ = _phone.text.trim();
    String pwd_ = _password.text.trim();
    String cpwd_ = _cpassword.text.trim();

    if (username_ == "" ||
        email_ == "" ||
        phone_ == "" ||
        pwd_ == "" ||
        cpwd_ == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill all the fields"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    } else if (pwd_ != cpwd_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password does't match !"),
        backgroundColor: Colors.amber,
        duration: Duration(seconds: 1),
      ));
    } else {
      // Create new Account
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email_, password: pwd_);

        setState(() {
          isCreating=true;
        });

      Map<String, dynamic> NewUserData = {
        "Username": username_,
        "Email": email_,
        "Phone": phone_,
        //  "Password":pwd_,
      };

      FirebaseFirestore.instance.collection("Users").add(NewUserData);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("User Created Successfully"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
       Timer(Duration(seconds: 3), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => login_page())); });
    }
  }

  bool obscure_pwd = true;
  bool obscure_pwd_2 = true;

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
                  Text(
                    'Registration Form',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent.shade700),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _username,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(7),
                      prefixIconColor: Colors.blueAccent,
                      prefixIcon: Icon(
                        FontAwesomeIcons.userCircle,
                        size: 35,
                      ),
                      hintText: 'Username',
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
                  TextField(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(7),
                      prefixIconColor: Colors.blueAccent,
                      prefixIcon: Icon(
                        Icons.call,
                        size: 35,
                      ),
                      hintText: 'Phone',

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
                    height: 10,
                  ),
                  TextField(
                    controller: _cpassword,
                    obscureText: obscure_pwd_2,
                    decoration: InputDecoration(
                      suffixIconColor: Colors.blueAccent,
                      // contentPadding: EdgeInsets.all(7),
                      prefixIconColor: Colors.blueAccent,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure_pwd_2 = !obscure_pwd_2;
                            });
                          },
                          icon: Icon(obscure_pwd
                              ? (Icons.visibility)
                              : (Icons.visibility_off))),
                      prefixIcon: Icon(
                        Icons.lock_open_outlined,
                        size: 35,
                      ),
                      hintText: 'Comfirm Password',
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
                        _CreateAccount();
                       
                      },
                      child: isCreating?CircularProgressIndicator():Text("Login",style: TextStyle(
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
                      Text("Already have account?"),
                      GestureDetector(
                        onTap: () {
                          print("Clicked");

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => login_page()));
                        },
                        child: Text(
                          "Click here",
                          style: TextStyle(color: Colors.blue.shade800),
                        ),
                      )
                    ],
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
