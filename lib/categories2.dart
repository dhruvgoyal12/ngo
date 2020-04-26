import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'Roundedbutton.dart';
import 'package:page_transition/page_transition.dart';
import 'alertUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tab.dart';

class Categories2 extends StatefulWidget {
  @override
  _Categories2State createState() => _Categories2State();
}

class _Categories2State extends State<Categories2> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinUser;
  var finalList = [];
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    delCat();
  }

  var Tapped = [false, false, false, false, false, false];
  String id;
  delCat() async {
    setState(() {
      showSpinner = true;
    });
    QuerySnapshot us =
        await Firestore.instance.collection('categories').getDocuments();
    for (var doc in us.documents) {
      if (doc.data['sender'] == loggedinUser.email) {
        id = doc.documentID;
        if (doc.data['Food'] == true) {
          Tapped[0] = onTapped(0);
        }
        if (doc.data['Shelter'] == true) {
          Tapped[1] = onTapped(1);
        }
        if (doc.data['Clothes'] == true) {
          Tapped[2] = onTapped(2);
        }
        if (doc.data['Women Care'] == true) {
          Tapped[3] = onTapped(3);
        }
        if (doc.data['Others'] == true) {
          Tapped[4] = onTapped(4);
        }
        setState(() {
          showSpinner = false;
        });
        break;
      } else
        showSpinner = false;
    }
  }

  bool showSpinner = false;

  bool onTapped(var a) {
    return !Tapped[a];
  }

  bool select() {
    for (var item in Tapped) {
      if (item) return true;
    }
    return false;
  }

  String imgFood = 'images/food.jpg';
  String checked = 'images/smile.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  color: Colors.white,
                  onPressed: () {
//                    setState(() {
//                      showSpinner = true;
//                    });
////                      await loggedinUser.delete();
//                    setState(() {
//                      showSpinner = false;
//                    });
                    Navigator.pop(context);
                  },
                ),
                Container(width: 125, child: Row())
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 30),
                  child: Text(
                    "Select Categories you deal in",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height - 105,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25, right: 20),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 45),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300,
                      child: ListView(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Tapped[0] = onTapped(0);
                              });
                            },
                            child: Category(
                              ic: Icon(
                                Tapped[0]
                                    ? Icons.highlight_off
                                    : Icons.add_circle,
                                color: Tapped[0] ? Colors.red : Colors.black,
                              ),
                              text: 'Food',
                              img: 'images/food.jpg',
                              color: Tapped[0] ? Colors.teal : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Tapped[1] = onTapped(1);
                              });
                            },
                            child: Category(
                              ic: Icon(
                                Tapped[1]
                                    ? Icons.highlight_off
                                    : Icons.add_circle,
                                color: Tapped[1] ? Colors.red : Colors.black,
                              ),
                              text: 'Shelter',
                              img: 'images/food.jpg',
                              color: Tapped[1] ? Colors.teal : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Tapped[2] = onTapped(2);
                              });
                            },
                            child: Category(
                              ic: Icon(
                                Tapped[2]
                                    ? Icons.highlight_off
                                    : Icons.add_circle,
                                color: Tapped[2] ? Colors.red : Colors.black,
                              ),
                              text: 'Clothes',
                              img: 'images/food.jpg',
                              color: Tapped[2] ? Colors.teal : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Tapped[3] = onTapped(3);
                              });
                            },
                            child: Category(
                              ic: Icon(
                                Tapped[3]
                                    ? Icons.highlight_off
                                    : Icons.add_circle,
                                color: Tapped[3] ? Colors.red : Colors.black,
                              ),
                              text: 'Women Care',
                              img: 'images/food.jpg',
                              color: Tapped[3] ? Colors.teal : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Tapped[4] = onTapped(4);
                              });
                            },
                            child: Category(
                              ic: Icon(
                                Tapped[4]
                                    ? Icons.highlight_off
                                    : Icons.add_circle,
                                color: Tapped[4] ? Colors.red : Colors.black,
                              ),
                              text: 'Others',
                              img: 'images/food.jpg',
                              color: Tapped[4] ? Colors.teal : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    child: RoundedButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (select()) {
                          try {
                            await _firestore
                                .collection('categories')
                                .document(id)
                                .updateData({
                              'Food': Tapped[0],
                              'Clothes': Tapped[2],
                              'Shelter': Tapped[1],
                              'Women Care': Tapped[3],
                              'Others': Tapped[4],
                              'sender': loggedinUser.email,
                              'initialized': true
                            });

                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: tab(
                                      loggedinUser: loggedinUser,
                                    )));
                          } catch (e) {
                            var alertDialog = AlertUser(
                              title: 'Sorry',
                              content: 'An Error occured. Try again',
                              btnText: 'Back',
                            );
                            showDialog(
                                context: (context),
                                builder: (context) {
                                  return alertDialog;
                                });
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        } else {
                          var alertDialog = AlertUser(
                            title: 'None Selected',
                            content: 'You must select atleast one category',
                            btnText: 'Back',
                          );
                          showDialog(
                              context: (context),
                              builder: (context) {
                                return alertDialog;
                              });
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      text: "Let's go",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  Category({this.ic, this.text, this.img, this.color});
  final Icon ic;
  final String text, img;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(img),
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                        color: color,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                        fontFamily: 'Montserrat'),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: ic,
            iconSize: 35,
          )
        ],
      ),
    );
  }
}
