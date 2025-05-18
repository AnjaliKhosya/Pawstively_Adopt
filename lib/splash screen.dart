import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import 'package:pet_adoption/login_screen.dart';
import 'package:pet_adoption/menu_page.dart';

class splash_screen extends StatefulWidget {
  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  // Navigate to the appropriate screen after a delay
  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    // Exit full screen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print('\nUser: $user');
      // Move to home screen or menu
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => menu_page(user.displayName, user.photoURL, user.uid),
        ),
      );
    } else {
      // Move to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => login_screen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal.shade100,
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * .25,
              right: MediaQuery.of(context).size.width * .14,
              width: MediaQuery.of(context).size.width * .7,
              child: Image.asset('assets/images/icon.png'),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .09,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Adopt ',
                        style: TextStyle(
                          fontFamily: 'gabarito',
                          fontSize: 35,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '❣️',
                        style: TextStyle(color: Colors.red, fontSize: 50),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Do not shop',
                      style: TextStyle(
                        fontFamily: 'gabarito',
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    'Your future best friend is waiting for you.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: 'gabarito',
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
