import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detailed_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;
var cat = ['null', 'null', 'null', 'null', 'null'];

class Tab1 extends StatefulWidget {
  static String id = "Tab1";
  @override
  _Tab1State createState() => _Tab1State();
}

final _firestore = Firestore.instance;

class _Tab1State extends State<Tab1> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getCat();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  bool showSpinner = false;
  getCat() async {
    setState(() {
      showSpinner = true;
    });
    try {
      QuerySnapshot us =
          await Firestore.instance.collection('categories').getDocuments();
      for (var doc in us.documents) {
        if (doc.data['sender'] == loggedInUser.email) {
          doc.data['Food'] ? cat[0] = 'Food' : cat[0] = 'null';
          doc.data['Shelter'] ? cat[1] = 'Shelter' : cat[1] = 'null';
          doc.data['Clothes'] ? cat[2] = 'Clothes' : cat[2] = 'null';
          doc.data['Women Care'] ? cat[3] = 'Women Care' : cat[3] = 'null';
          doc.data['Others'] ? cat[4] = 'Others' : cat[4] = 'null';
          setState(() {
            showSpinner = false;
          });
          break;
        } else {
          setState(() {
            showSpinner = false;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('requests').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data.documents;
                    List<Padding> messageWidgets = [];
                    for (var message in messages) {
                      final img_url = message.data["img_url"];
                      final time = message.data["time"];
                      final city = message.data["city"];
                      final category = message.data["category"];
                      for (int i = 0; i < 5; i++) {
                        if (category == cat[i]) {
                          final messageWidget = Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Material(
                                  borderRadius: BorderRadius.circular(0.0),
                                  elevation: 5.0,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                children: <Widget>[
                                                  Image.network(
                                                    img_url,
                                                    height: 75.0,
                                                    width: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Text(
                                                        'Location : $city',
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      time,
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15.0,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              detailed_view(
                                                                  document:
                                                                      message,
                                                                  loggedInUser:
                                                                      loggedInUser
                                                                          .email)));
                                                },
                                                color: Colors.lightBlueAccent,
                                                child: Text(
                                                  'View',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          messageWidgets.add(messageWidget);
                          break;
                        }
                      }
                    }
                    return Expanded(
                        child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      children: messageWidgets,
                    ));
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
