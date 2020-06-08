import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngouser/welcome_screen.dart';
import 'package:ngouser/widgets/login.dart';
import 'package:ngouser/widgets/splash.dart';
import 'package:ngouser/widgets/takePicture.dart';
import 'package:ngouser/widgets/username.dart';
import './widgets/choice.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import './widgets/page1.dart';
import './widgets/homepage.dart';
import 'package:camera/camera.dart';
import 'splash.dart';
// Add email for each user in database

//var firstCamera;
bool _user = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
//SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //  .then((_) {
  runApp(new MyApp(firstCamera));
  // });
}

class MyApp extends StatefulWidget {
  final cam;
  MyApp(this.cam);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      title: 'Sanjeevani',
      routes: <String, WidgetBuilder>{
        '/choice': (BuildContext context) => new choice(),
        '/login': (BuildContext context) => new login(widget.cam),
        //'/page1':(BuildContext context)=>new page1(),
        '/wel': (BuildContext context) => new welcome_screen(widget.cam),
        '/homepage': (BuildContext context) => new homepage(
            null,
            null,
            widget.cam,
            null,
            null,
            null,
            null,
            false,
            false,
            false,
            false,
            false,
            false),
        '/username': (BuildContext context) => new UserName(null, widget.cam),
        '/splash': (BuildContext context) => new Splash2(_user),
        '/takePicture': (BuildContext context) => new TakePictureScreen(
            widget.cam,
            null,
            null,
            null,
            null,
            false,
            false,
            false,
            false,
            false),
      },
      debugShowCheckedModeBanner: false,
      home: Splash(cam:widget.cam),
    );
  }
}
