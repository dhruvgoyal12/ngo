import 'package:ngouser/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngouser/widgets/homepage.dart';
import 'categories.dart';
import 'register.dart';
import 'root.dart';
import 'welcome_screen.dart';
import 'login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'authentication.dart';
import './widgets/db_helper.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;
  final double initialradius = 30;
  double radius = 0;

  @override
  Future initState() {
    // TODO: implement initState
    super.initState();
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
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 3), onDoneloading);
  }

  onDoneloading() async {
    List<Map<String, Object>> status;
    //DBHelper.insert('status',{'id':'c','value':1});
    status = await DBHelper.getData('status');
    print(status.isEmpty);
    if (status.isEmpty||status.first['value'] == 3) {

//    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
//      return LoginScreen();
      return Navigator.pushReplacement(
          context,
          PageTransition(type: PageTransitionType.fade, child: welcome_screen()
//           RootPage(
//               auth: Auth(),
//             )
//                LoginScreen(
//              auth: Auth(),
//            )
          ));
    } else if (status.first['value'] == 1) {
      print('going to user');
      Navigator.of(context).pushReplacementNamed('/homepage');
    }
    else if (status.first['value'] == 2) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: RootPage(
                auth: Auth(),
              )));
    }
//dispose();
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
                        text: ["Sanjeevani"],
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Created with',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.red,
                              )),
                          Text(
                            'by Zine, MNIT Jaipur',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
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
