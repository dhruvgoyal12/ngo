import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ngo_picture extends StatefulWidget {
  final cam;
  String s;
  DocumentSnapshot doc;
  ngo_picture(this.cam, this.s);
  @override
  _ngo_pictureState createState() => _ngo_pictureState();
}

class _ngo_pictureState extends State<ngo_picture> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  String s;
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cam,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  //String s = 'hello';
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    String s = (widget.s);
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 6,
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(
            Icons.camera,
            size: 35,
          ),
          // Provide an onPressed callback.
          onPressed: () async {
            try {
              await _initializeControllerFuture;

              final path = join(
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );
              await _controller.takePicture(path);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DisplayPictureScreen(imagePath: path, s: s)),
              );
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final _firestore = Firestore.instance;
  String imagePath, s;
  String img_url;
  int count;
  DocumentSnapshot Doc;
  Future uploadFile() async {
    String name = basename(imagePath);
    StorageReference storagereference =
        FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = storagereference.putFile(File(imagePath));
    await uploadTask.onComplete;
    var url = storagereference.getDownloadURL();
    img_url = url.toString();
    _firestore.collection('requests_completed').add({
      'img_url': img_url,
      'uid':s,
    });
  }

  DisplayPictureScreen({Key key, this.imagePath, this.s}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.file(File(imagePath)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                elevation: 5.0,
                color: Colors.green,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () {
                    uploadFile();
                    print(s);
                    count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 3;
                    });
                  },
                  minWidth: 400,
                  height: 42.0,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            //SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  minWidth: 400,
                  height: 42.0,
                  child: Text(
                    'Retake Picture',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
