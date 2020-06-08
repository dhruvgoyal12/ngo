import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:ngo/Roundedbutton.dart';
//import 'package:ngo/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Roundedbutton.dart';

class detailed_view2 extends StatelessWidget {
  final _firestore = Firestore.instance;
  DocumentSnapshot document;
  static String id = "detailed_view2";
  final cam;

  detailed_view2({Key key, @required this.document,this.cam}) : super(key: key);

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
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(address,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                            )
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
                text: 'Completed',
                onPressed: () {
                   _settingModalBottomSheet(context, document.data['uid'], cam, document);
//                   document.reference.delete();
//                   Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 10,
              ),
              RoundedButton(
                color: Colors.black,
                text: 'Cancel',
                onPressed: () {
                  _firestore.collection('requests').add({
                    'img_url': img_url,
                    'city': location,
                    'address': address,
                    'note': note,
                    'time': time,
                    'submitted_by': submitted_by,
                    'submitter_phone_no': submitter_phone_no,
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
                    //also add name and phone no. of submitter
                  });
                  document.reference.delete();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
void _settingModalBottomSheet(context, s, cam, document) {
  int count;
  //DocumentSnapshot documents = document;
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Close Request'),
              backgroundColor: Colors.black,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                      "Complete request by sending the photograph of the person you helped to the sender of this request"),
                  SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 5.0,
                    color: Colors.lightBlueAccent,
                    //borderRadius: BorderRadius.circular(32.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new ngo_picture(cam, s);
                        }));
                        //Navigator.pushReplacementNamed(context, '/ngo_pic');
                      },
                      minWidth: 400,
                      height: 35.0,
                      child: Text(
                        'Close With a photo',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Material(
                    elevation: 5.0,
                    color: Colors.lightBlueAccent,
                    //borderRadius: BorderRadius.circular(32.0),
                    child: MaterialButton(
                      onPressed: () {
                        document.reference.delete();
                        count = 0;
                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                      },
                      minWidth: 400,
                      height: 35.0,
                      child: Text(
                        'Close Anyway',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                ]),
              ),
            ));
      });
}

