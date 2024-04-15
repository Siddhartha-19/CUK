import 'package:code_u_knight/Services/authservice.dart';
import 'package:code_u_knight/Screens/entryscreen.dart';
import 'package:code_u_knight/Screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Scaffold(
      backgroundColor: Color(0xFF373738),
      appBar: getAppBar_homescreen(context, _auth),
    );
  }

  AppBar getAppBar_homescreen(BuildContext context, _auth) {
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
      title: Text(
        "Code U Knight",
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      centerTitle: false,
      actions: [
        ElevatedButton(
          onPressed: () async {
            await _auth.signout();
          },
          child: Text(
            "Sign out",
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF373738)),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                icon: Icon(Icons.person_2_outlined)))
      ],
    );
  }
}
