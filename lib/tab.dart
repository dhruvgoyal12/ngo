import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgot.dart';
import 'login.dart';
import 'welcome_screen.dart';
import 'Tab1.dart';
import 'Tab2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'alertUser.dart';
import 'categories2.dart';
import 'package:page_transition/page_transition.dart';

import 'package:firebase_auth/firebase_auth.dart';

class tab extends StatelessWidget {
  tab({this.loggedinUser});
  final loggedinUser;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight, child: welcome_screen()));
        return true;
      },
      child: Container(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            drawer: Drawer(
                child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Sanjeevani',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 30,
                                letterSpacing: 0.2,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Montserrat',
                                color: Colors.white)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          loggedinUser.email,
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/wel11.jpg'),
                          fit: BoxFit.cover)),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.add_circle),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Change Categories',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Categories2()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.autorenew),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    try {
//                    final loggedinUser = await _auth.currentUser();

                      final exist = await _auth
                          .fetchSignInMethodsForEmail(email: loggedinUser.email)
                          .toString();
                      if (exist != null) {
                        await _auth.sendPasswordResetEmail(
                            email: loggedinUser.email);
                        var alertDialog = AlertUser(
                          title: 'Success!',
                          content: 'Please check your email',
                          btnText: 'Back',
                        );
                        showDialog(
                            context: (context),
                            builder: (context) {
                              return alertDialog;
                            });
                      }
                    } catch (e) {
                      var alertDialog = AlertUser(
                        title: 'Oops',
                        content: 'An error occured. Please try later',
                        btnText: 'Back',
                      );
                      showDialog(
                          context: (context),
                          builder: (context) {
                            return alertDialog;
                          });
                    }
                  },
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    await _auth.signOut();
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: LoginScreen()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.delete),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    try {
                      QuerySnapshot req = await _firestore
                          .collection('requests_accepted')
                          .getDocuments();
                      for (var us in req.documents) {
                        bool food=false,women=false,children=false,medicine=false,clothes=false;
                        if(us.data['category']=='Food'){food=true;}
                        if(us.data['category']=='Women'){women=true;}
                        if(us.data['category']=='Children'){children=true;}
                        if(us.data['category']=='Clothes'){clothes=true;}
                        if(us.data['category']=='Medicine'){medicine=true;}
                        if (loggedinUser.email == us.data['accepted_by']) {
                          _firestore.collection('requests').add({
                            'img_url': us.data['img_url'],
                            'city': us.data['city'],
                            'address': us.data['address'],
                            'note': us.data['note'],
                            'time': us.data['time'],
                            'submitted_by': us.data['submitted_by'],
                            'submitter_phone_no': us.data['submitter_phone_no'],
                            'category': us.data['category'],
                            'date':DateTime.now().toIso8601String(),
                            'Food':food,
                            'Women Care':women,
                            'Children Care':children,
                            "Clothes":clothes,
                            'Medicine':medicine,
                            'status':'Approved',
                            'user_id':us.data['user_id'],

                          });
                          us.reference.delete();
                        }
                      }

                      final QuerySnapshot result = await _firestore
                          .collection('categories')
                          .where('sender',
                              isEqualTo:
                                  loggedinUser.email.toString().toLowerCase())
                          .limit(1)
                          .getDocuments();
                      final List<DocumentSnapshot> documents = result.documents;
                      print(documents);
                      String id;
                      for (var r in documents) {
                        id = r.documentID;
                        print('haha');
                      }

                      await _firestore
                          .collection('categories')
                          .document(id)
                          .delete();

                      await loggedinUser.delete();

                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.leftToRight,
                              child: LoginScreen()));
                    } catch (e) {
                      print(e);
//                    var alertDialog = AlertUser(
//                      title: 'Oops!',
//                      content:
//                          'We cannot reach our servers right now. Please check your internet connection',
//                      btnText: 'Back',
//                    );
//                    showDialog(
//                        context: (context),
//                        builder: (context) {
//                          return alertDialog;
//                        });
                    }
                  },
                ),
              ],
            )),
            appBar: AppBar(
              backgroundColor: Colors.black87,
              bottom: TabBar(
                labelStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                indicatorWeight: 5,
                tabs: [
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      height: 60.0,
                      child: Tab(
                        text: 'NEW',
                        icon: Icon(Icons.add_alert),
                      )),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      height: 60.0,
                      child:
                          Tab(text: 'PENDING', icon: Icon(Icons.access_time))),
                ],
              ),
              title: Text(
                'Sanjeevani',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              child: TabBarView(
                children: [Tab1(), Tab2()],
              ),
            ),
          ),
        ),
        //initialRoute: MyApp.id,
//        routes: {
//          //detailed_view.id:(context) => detailed_view(),
//          Tab1.id: (context) => Tab1(),
//          Tab2.id: (context) => Tab2(),
//          MyApp.id: (context) => MyApp(),
//        },
      ),
    );
  }
}
