import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'afterRegister.dart';
import 'alertUser.dart';
import 'login.dart';
import 'authentication.dart';
import 'tab.dart';

class RootPage extends StatefulWidget {
  final cam;
  RootPage({this.auth,this.cam});
  final Auth auth;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  FirebaseUser loggedinUser;
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> currentUser() async {
    try {
      final user = await _auth.currentUser();
      return user;
    } catch (e) {
      print(e);
    }
  }

  ini() async {
    try {
      final user = await _auth.currentUser();
      print(user);
      setState(() {
        if (user != null) {
          _authStatus = AuthStatus.signedIn;
          loggedinUser = user;
        } else {
          _authStatus = AuthStatus.notSignedIn;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    print('haha');
    ini();

    // TODO: implement initState
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cam=widget.cam;
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return LoginScreen(
          auth: widget.auth,
          onSignedin: _signedIn,
        );
      case AuthStatus.signedIn:
        return tab(
          loggedinUser: loggedinUser,
          cam:cam,
        );
    }
  }
}
