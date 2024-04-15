import 'package:code_u_knight/Authentication/register.dart';
import 'package:code_u_knight/Services/authservice.dart';
import 'package:code_u_knight/Screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool show_password = false;
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF373738),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.70,
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
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 4,
                child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
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
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              width: MediaQuery.sizeOf(context).width / 8,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    UserCredential? user_credential =
                                        await _auth.signinwithemailpassword(
                                            emailController.value.text,
                                            passwordController.value.text);
                                    if (user_credential == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: new Text(
                                                  'Invalid email address or it is not verified'),
                                              duration: Duration(
                                                seconds: 10,
                                              )));
                                    } else {
                                      // userSetup(nameController.text,mobileController.text,emailController.text);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: new Text(
                                                  'Successfully logged in'),
                                              duration: Duration(
                                                seconds: 3,
                                              )));
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
                                        Text('Login',
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
                                  "'Don\'t have an account ? '",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Register()));
                                    },
                                    child: Text(
                                      "Register",
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
