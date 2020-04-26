import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  bool _user = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  void initState() {
    getUser().then((user) {
      setState(() {
        if (user != null) {
          _user = true;
        }
      });
    });
    //Navigator.of(context).
    Future.delayed(Duration(seconds: 2), () {
      _user
          ? Navigator.pushReplacementNamed(context, '/homepage')
          : Navigator.pushReplacementNamed(context, '/login');
    });

    // Future.delayed(Duration(seconds: 4), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
