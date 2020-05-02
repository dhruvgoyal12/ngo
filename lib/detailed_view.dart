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

  String addLines(String addr) {
    int stIndex = 0;
    int endIndex = 50;
    String a = '';
    while (endIndex < addr.length) {
      print('hello');
      a += addr.substring(stIndex, endIndex) + '\n';
      stIndex = endIndex + 1;
      endIndex = stIndex + 50;
    }
    a += addr.substring(stIndex);
    return a;
  }

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
    String addr = addLines(address);
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height - 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(img_url), fit: BoxFit.cover),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                                type: MaterialType.circle,
                                elevation: 5.0,
                                color: Colors.white,
                                //borderRadius: BorderRadius.circular(100.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    launch(
                                        'https://www.google.com/maps/dir/?api=1&destination=$coordinate');
                                  },
                                  minWidth: 10.0,
                                  height: 42.0,
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.location_on,
                                size: 20,
                                color: Colors.green,
                              ),
                            ),
                            Text(addr,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.person,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text('Submitted by: $submitted_by ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            'Urgently Needed Help',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          note,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RoundedButton(
                color: Colors.black,
                text: 'Accept',
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
                    'Shelter': document.data['Shelter'],
                    'Clothes': document.data['Clothes'],
                    'Food': document.data['Food'],
                    'Others': document.data['Others'],
                    'Women care': document.data['Women care'],
                    'img': document.data['img'],
                    'landmark': document.data['landmark'],
                    'latitude': document.data['latitude'],
                    'longitude': document.data['longitude'],
                    'status': document.data['status'],
                    'time': document.data['time'],
                    'user_id': document.data['user_id'],
                  });
                  document.reference.delete();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      ],
    ));
  }
}
