import 'package:code_u_knight/Authentication/login.dart';
import 'package:code_u_knight/Authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen>
    with TickerProviderStateMixin {
  final List<List> texts = [
    ["Code Together", 45, 0xFF41b8d5],
    ["Learn Together", 45, 0xFFffde59],
    ["Grow Together", 45, 0xFFff914d]
  ];
  final List<String> images = [
    "assets/code.png",
    "assets/creative.png",
    "assets/growth.png"
  ];
  late AnimationController _text_controller;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<AnimationController> _curved_controllers;
  late List<Animation<double>> _curved_animations;
  late Animation<double> _text_animation;
  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      texts.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
      ),
    );
    _text_controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _curved_controllers = List.generate(
      texts.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
      ),
    );
    _animations = _controllers
        .map((controller) => Tween(begin: 0.0, end: 1.0).animate(controller))
        .toList();

    _curved_animations = _curved_controllers
        .map((curved_controller) => Tween(begin: 0.0, end: 1.0).animate(
            // CurvedAnimation(
            //     parent: curved_controller, curve: Curves.fastOutSlowIn)
            curved_controller))
        .toList();

    _text_animation = Tween(begin: 0.0, end: 1.0).animate(_text_controller);

    _controllers[0].forward();
    _curved_controllers[0].forward();
    for (int i = 0; i < _controllers.length - 1; i++) {
      _controllers[i].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _curved_controllers[i + 1].forward();
          _controllers[i + 1].forward();
        }
      });
    }
    _controllers[_controllers.length - 1].addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _curved_controllers[_controllers.length - 1].forward();
      }
    });
    _curved_controllers[_controllers.length - 1].addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _text_controller.forward();
      }
    });

    // Start the animation
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  double _getCurveValue(double value) {
    // Convert value from 0.0 to 1.0 to angle in radians (0 to pi)
    double angle = value * math.pi;
    // Use sin function to get y value for a given x value (angle)
    return math.sin(angle) * 0.9;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF373738),
      appBar: getAppBar(context),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  texts.length,
                  (index) => Row(children: <Widget>[
                    AnimatedBuilder(
                      animation: _animations[index],
                      builder: (context, child) {
                        return buildAnimatedText(
                            " " * (index * 5) + texts[index][0],
                            _animations[index].value,
                            texts[index][1],
                            texts[index][2]);
                      },
                    ),
                    AnimatedBuilder(
                        animation: _curved_animations[index],
                        builder: (context, child) {
                          return builAnimatedImage(images[index],
                              _curved_animations[index].value, context);
                        }),
                  ]),
                ),
              ),
              SizedBox(
                height: 200,
              ),
              AnimatedBuilder(
                  animation: _text_animation,
                  builder: (context, child) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          buildAnimated_text_1(
                              "Empowering Friends, Uniting Skills",
                              _text_animation.value)
                        ]);
                  }),
            ]),
      ),
    );
  }

  Widget buildAnimated_text_1(String text, double width_factor) {
    return ClipRect(
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: width_factor,
        child: Opacity(
          opacity: width_factor,
          child: Text(
            text,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.white,
            )),
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedText(
      String text, double widthFactor, double font_size, int color) {
    return ClipRect(
      child: Align(
          alignment: Alignment.centerLeft,
          widthFactor: widthFactor,
          child: Opacity(
            opacity: widthFactor,
            child: Text(
              text,
              style: GoogleFonts.dmSerifText(
                  textStyle: TextStyle(
                fontSize: font_size,
                // fontWeight:,
                letterSpacing: 2.0,
                color: Colors.white,
              )),
            ),
          )),
    );
  }

  Widget builAnimatedImage(String Image_path, double factor, context) {
    double x = factor;
    // Calculate y position using sine curve function
    // double y = _getCurveValue(factor).abs();
    // print(y);
    return Transform.translate(
        offset: Offset(x * MediaQuery.sizeOf(context).width * 0.05, 0),
        child: Opacity(
            opacity: factor,
            child: Image.asset(
              Image_path,
              width: 100,
              height: 100,
            )));
  }
}

AppBar getAppBar(BuildContext context) {
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
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Text(
          "Log in",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFF373738)),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
        },
        child: Text(
          "Sign Up",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFF373738)),
        ),
      ),
      SizedBox(
        width: 20,
      )
    ],
  );
}
