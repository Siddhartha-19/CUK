import 'dart:async';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_u_knight/Services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:code_u_knight/Authentication/login.dart';
import 'package:code_u_knight/Models/user_model.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final key = GlobalKey<ScaffoldState>();
  final nameController = new TextEditingController();
  final usernameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirm_passwordController = new TextEditingController();
  final AuthService _auth = AuthService();
  final User_model _user = User_model(user_id: '');
  bool show_password = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF373738),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.82,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5.0,
                spreadRadius: 2.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset("assets/CODEUKNIGHT_logo.png")),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 4,
                child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 15),
                          TextFormField(
                            controller: usernameController,
                            style: TextStyle(
                              fontWeight: FontWeight
                                  .w800, // Increase font size here (currently 18.0)
                            ),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontWeight: FontWeight
                                    .w800, // Increase font size here (currently 18.0)
                              ),
                              hintText: "Username",
                              prefixIcon: Icon(Icons.person),
                              // errorText: "Name cannot be empty",
                              focusColor: Colors.white,
                              disabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Color(0xFF373738),
                                  width: 3,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color(0xFF373738),
                                    width: 3,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(221, 34, 34, 34),
                                    width: 3,
                                  )),
                              // filled: true, // Enable filling the background
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "User name cannot be empty";
                              } else
                                return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: nameController,
                            style: TextStyle(
                              fontWeight: FontWeight
                                  .w800, // Increase font size here (currently 18.0)
                            ),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontWeight: FontWeight
                                    .w800, // Increase font size here (currently 18.0)
                              ),
                              hintText: "Full Name",
                              prefixIcon: Icon(Icons.person),
                              // errorText: "Name cannot be empty",
                              focusColor: Colors.white,
                              disabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Color(0xFF373738),
                                  width: 3,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color(0xFF373738),
                                    width: 3,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(221, 34, 34, 34),
                                    width: 3,
                                  )),
                              // filled: true, // Enable filling the background
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name cannot be empty";
                              } else
                                return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontWeight: FontWeight
                                  .w800, // Increase font size here (currently 18.0)
                            ),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontWeight: FontWeight
                                    .w800, // Increase font size here (currently 18.0)
                              ),
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email_outlined),
                              // errorText: "Name cannot be empty",
                              focusColor: Colors.white,
                              disabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Color(0xFF373738),
                                  width: 3,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color(0xFF373738),
                                    width: 3,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(221, 34, 34, 34),
                                    width: 3,
                                  )),
                              // filled: true, // Enable filling the background
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "email cannot be empty";
                              } else
                                return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: passwordController,
                            style: TextStyle(
                              fontWeight: FontWeight
                                  .w800, // Increase font size here (currently 18.0)
                            ),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontWeight: FontWeight
                                    .w800, // Increase font size here (currently 18.0)
                              ),
                              hintText: "Password",
                              prefixIcon: Icon(Icons.key),
                              // errorText: "Name cannot be empty",
                              suffix: Container(
                                height: 25,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        show_password = !show_password;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      size: 15,
                                    )),
                              ),
                              focusColor: Colors.white,
                              disabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Color(0xFF373738),
                                  width: 3,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color(0xFF373738),
                                    width: 3,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(221, 34, 34, 34),
                                    width: 3,
                                  )),
                              // filled: true, // Enable filling the background
                              fillColor: Colors.white,
                            ),
                            obscureText: !show_password,
                            validator: (value) {
                              if (value!.length < 8) {
                                return "Enter a password atleast 8 chars long";
                              } else
                                return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: confirm_passwordController,
                            style: TextStyle(
                              fontWeight: FontWeight
                                  .w800, // Increase font size here (currently 18.0)
                            ),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontWeight: FontWeight
                                    .w800, // Increase font size here (currently 18.0)
                              ),
                              hintText: "Confirm Password",
                              prefixIcon: Icon(Icons.key),
                              suffix: Container(
                                height: 25,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        show_password = !show_password;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      size: 15,
                                    )),
                              ),
                              // errorText: "Name cannot be empty",
                              focusColor: Colors.white,
                              disabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Color(0xFF373738),
                                  width: 3,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color(0xFF373738),
                                    width: 3,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(221, 34, 34, 34),
                                    width: 3,
                                  )),
                              // filled: true, // Enable filling the background
                              fillColor: Colors.white,
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value != passwordController.text) {
                                return "Password and confirn password should be same";
                              } else
                                return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              width: MediaQuery.sizeOf(context).width / 8,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    CollectionReference user_db =
                                        FirebaseFirestore.instance
                                            .collection("Users");

                                    final DocumentSnapshot user_names_snapshot =
                                        await user_db.doc('usernames').get();
                                    Map user_names_map = ((user_names_snapshot
                                        .data() as Map)["user_names"] as Map);
                                    if (user_names_map
                                        .containsKey(usernameController.text)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: new Text(
                                                  'Username has already been taken please use another one'),
                                              duration: Duration(
                                                seconds: 5,
                                              )));
                                    } else {
                                      UserCredential? user_credential =
                                          await _auth.registerwithemailpassword(
                                              emailController.value.text,
                                              passwordController.value.text);
                                      if (user_credential == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: new Text(
                                                    'Invalid email address or it has been used before'),
                                                duration: Duration(
                                                  seconds: 5,
                                                )));
                                      } else {
                                        // userSetup(nameController.text,mobileController.text,emailController.text);

                                        await _user.Create_user(
                                            nameController.text,
                                            emailController.text,
                                            usernameController.text);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: new Text(
                                                    'Verification email has been sent to your email please verify and login!'),
                                                duration: Duration(
                                                  seconds: 4,
                                                )));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      }
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: new Text(
                                                'Something Went Wrong !! Please try again later'),
                                            duration: Duration(
                                              seconds: 10,
                                            )));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Register',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white)),
                                      ]),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF373738),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ), // Adjust width and height as desired
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width / 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF373738)),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
