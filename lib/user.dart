import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngouser/welcome_screen.dart';
import 'package:page_transition/page_transition.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> with SingleTickerProviderStateMixin{
   AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;
  final double initialradius = 30;
  double radius = 0;

  bool _user = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      setState(() {
        if (user != null) {
          _user = true;
        }
      });
    });
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation_radius_in = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.75, 1, curve: Curves.elasticIn)));

    animation_radius_out = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    animation_rotation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.linear)));

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animation_radius_in.value * initialradius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animation_radius_out.value * initialradius;
        }
      });
    });
    controller.repeat();
    
    
    loadData();
    //Navigator.of(context).
   // Future.delayed(Duration(seconds: 2), () {
      
    //});

    // Future.delayed(Duration(seconds: 4), () {});
    
  }
  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 2), onDoneloading);
  }

  onDoneloading()  {
    //List<Map<String, Object>> status;
    //DBHelper.insert('status',{'id':'c','value':1});
   // status = await DBHelper.getData('status');
   // print(status.isEmpty);
    //Navigator.of
    _user
          ? Navigator.pushReplacementNamed(context, '/homepage')
          : Navigator.pushReplacementNamed(context, '/login');
          dispose();
   

  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: TypewriterAnimatedTextKit(
                        speed: Duration(milliseconds: 400),
                        text: ["User"],
                        textStyle: TextStyle(
                            fontSize: 32.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: RotationTransition(
                              turns: animation_rotation,
                              child: Stack(
                                children: <Widget>[
                                  Dot(
                                    radius: 30,
                                    color: Colors.white,
                                  ),
                                  Transform.translate(
                                    offset: Offset(
                                        radius * cos(pi), radius * sin(pi)),
                                    child: Dot(
                                      radius: 5,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(radius * cos(pi / 4),
                                        radius * sin(pi / 4)),
                                    child: Dot(
                                      radius: 5,
                                      color: Colors.amberAccent,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(radius * cos(pi / 2),
                                        radius * sin(pi / 2)),
                                    child: Dot(
                                      radius: 5,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(radius * cos(3 * pi / 4),
                                        radius * sin(3 * pi / 4)),
                                    child: Dot(
                                      radius: 5,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(radius * cos(5 * pi / 4),
                                        radius * sin(5 * pi / 4)),
                                    child: Dot(
                                      radius: 5,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(radius * cos(6 * pi / 4),
                                        radius * sin(6 * pi / 4)),
                                    child: Dot(
                                      radius: 5,
                                      color: Colors.purpleAccent,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(radius * cos(7 * pi / 4),
                                        radius * sin(7 * pi / 4)),
                                    child: Dot(
                                      radius: 5,
                                      color: Colors.yellowAccent,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(radius * cos(8 * pi / 4),
                                        radius * sin(8 * pi / 4)),
                                    child: Dot(
                                      radius: 5,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
      ),
    );
  }
}

