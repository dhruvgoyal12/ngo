import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Roundedbutton.dart';
import 'rounded_button.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class detailed_view extends StatelessWidget {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String loggedInUser;
  DocumentSnapshot document;
  static String id = "detailed_view";

  detailed_view({Key key, @required this.document, this.loggedInUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String address = document.data['address'],
        note = document.data['note'],
        time = document.data['time'],
        img_url = document.data['img_url'],
        location = document.data['city'],
        submitted_by = document.data['submitted_by'],
        submitter_phone_no = document.data['submitter_phone_no'],
        category = document.data['category'],
        coordinate = document.data['coordinate'];
    return Scaffold(
      backgroundColor: Colors.white30,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Material(
                elevation: 10.0,
                child:
                    Stack(alignment: Alignment.bottomRight, children: <Widget>[
                  Image.network(
                    img_url,
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Material(
                          elevation: 5.0,
                          color: Colors.white30.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(100.0),
                          child: MaterialButton(
                            onPressed: () {
                              launch(
                                  'https://www.google.com/maps/dir/?api=1&destination=$coordinate');
                            },
                            minWidth: 10.0,
                            height: 42.0,
                            child: Icon(Icons.location_searching),
                          ))),
                ])),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(5.0),
                      elevation: 10.0,
                      color: Colors.white30.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('$note.\n',
                                style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                  fontSize: 17.0,
                                )),
                            Text(time,
                                style: TextStyle(
                                  color: Colors.white70,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
//            Container(
//                height: 1.0,
//                decoration: BoxDecoration(
//                  border: Border.all(
//                    color: Colors.grey,
//                    width: 1.4,
//                  ),
//                )),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                elevation: 10.0,
                color: Colors.white30.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Address: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontSize: 17.0,
                          )),
                      Expanded(
                        child: Text(address,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17.0,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                elevation: 10.0,
                color: Colors.white30.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Text("Submitted by: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontSize: 17.0,
                          )),
                      Expanded(
                        child: Text(submitted_by,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17.0,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                elevation: 10.0,
                color: Colors.white30.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Text("Phone NO. ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            fontSize: 17.0,
                          )),
                      Expanded(
                          child: Text(submitter_phone_no,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 17.0,
                              )))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: rounded_button(
                        onPressed: () {
                          _firestore.collection('requests_accepted').add({
                            'img_url': img_url,
                            'city': location,
                            'address': address,
                            'note': note,
                            'time': time,
                            'submitted_by': submitted_by,
                            'submitter_phone_no': submitter_phone_no,
                            'accepted_by': loggedInUser,
                            'category': category,
                            'coordinate': coordinate,
                            'Shelter':document.data['Shelter'],
                            'Clothes':document.data['Clothes'],
                            'Food':document.data['Food'],
                            'Others':document.data['Others'],
                            'Women care':document.data['Women care'],
                            'img':document.data['img'],
                            'landmark':document.data['landmark'],
                            'latitude':document.data['latitude'],
                            'longitude':document.data['longitude'],
                            'status':document.data['status'],
                            'time':document.data['time'],
                            'user_id':document.data['user_id'],
                          });
                          document.reference.delete();
                          Navigator.pop(context);
                        },
                        text: ("Accept"),
                        color: Colors.lightGreen
//                      color: Colors.green,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20.0)),
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
