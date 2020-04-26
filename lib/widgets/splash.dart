import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class Splash2 extends StatefulWidget {
  final bool _user;
  Splash2(this._user);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash2> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      widget._user
          ? Navigator.pushReplacementNamed(context, '/homepage')
          : Navigator.pushReplacementNamed(context, '/login');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/SignIn.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Center(
                child:
                    /*Text(
              "AAS",
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 70,
                color: Colors.white,  
              ),
            )*/

                    Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'SANJEEVANI',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white),
                ),
                CircularProgressIndicator(),
              ],
            )),
          ],
        ));
  }
}
