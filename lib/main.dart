import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption/splash%20screen.dart';
import 'package:pet_adoption/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

//global object for accessing device screen size
late Size nq;

void main ()async
{
  WidgetsFlutterBinding.ensureInitialized();
  //enter full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
  .then((value) {
    _initializeFirebase();
    runApp(MyApp());});

}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      body: splash_screen()
      ),
    );
  }
}

//initialisation of fire base
_initializeFirebase() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}


