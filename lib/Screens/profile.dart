import 'dart:io';

import 'package:code_u_knight/Services/authservice.dart';
import 'package:code_u_knight/Screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:html' as html;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Scaffold(
      backgroundColor: Color(0xFF373738),
      appBar: getAppBar_profile(context, _auth),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: MediaQuery.sizeOf(context).height * 0.7,
                width: MediaQuery.sizeOf(context).width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Stack(
                            children: [
                              ClipRRect(
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      'https://example.com/profile_image.jpg'),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () async {
                                    html.File? imageFile = (await ImagePickerWeb
                                        .getMultiImagesAsFile())?[0];

                                    if (imageFile != null) {
                                      FirebaseAuth _auth =
                                          FirebaseAuth.instance;
                                      String? user_id =
                                          await _auth.currentUser?.uid;
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.70,
                width: MediaQuery.sizeOf(context).width * 0.60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar getAppBar_profile(BuildContext context, _auth) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: MediaQuery.of(context).size.height * 0.10,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Image.asset(
              "assets/CODEUKNIGHT_logo.png",
              width: MediaQuery.of(context).size.height * 0.10 * 0.95,
              height: MediaQuery.of(context).size.height * 0.10 * 0.95,
            ),
          ),
        ],
      ),
      title: TextButton(
          child: Text(
            "Code U Knight",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }),
      centerTitle: false,
    );
  }
}
