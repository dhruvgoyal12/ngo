import 'package:flutter/material.dart';
import 'Roundedbutton.dart';
import 'categories.dart';
import 'main.dart';
import 'rounded_button.dart';
import 'authentication.dart';
import 'root.dart';
import 'widgets/splash.dart';
import 'package:page_transition/page_transition.dart';
import 'user.dart';

class welcome_screen extends StatelessWidget {
  static String id = "welcome_screen";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/wel11.jpg'), fit: BoxFit.cover)),
            child: Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Image(
                            image: AssetImage('images/icm3.png'),
                            width: 50.0,
                          )
                          //Image.network('images/sp2.png'),
                          ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0, right: 70.0),
                        child: Text(
                          'There is no exercise better for the heart than reaching down and lifting people up.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 40.0, top: 20.0),
                        child: Text(
                          '- John Holmes -',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 10.0),
                        child: Hero(
                          tag: 'welcome',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              'Welcome',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 45.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        child: RoundedButton(
                            text: 'Report a needy',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: User()));
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        child: RoundedButton(
                            text: 'Help a needy',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: RootPage(
                                        auth: Auth(),
                                      )));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
