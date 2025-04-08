import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_adoption/helpers/dialogs.dart';
import 'package:pet_adoption/menu_page.dart';
import 'api/apis.dart';
import 'main.dart';
class login_screen extends StatefulWidget {

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 250), (){
      setState(() { _isAnimate = true;});
    });
  }

  _handleGoogleBtnClick(){
    //for showing progress bar
    dialogs.showProgressBar(context);
    _signInWithGoogle().then((user)async {
      //for hiding progress bar
      Navigator.pop(context);
      if(user!=null)
        {
          if((await APIs.userExists()))
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>menu_page(APIs.auth.currentUser?.displayName,APIs.auth.currentUser?.photoURL)));
            }
          else
            {
              await APIs.createUser().then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>menu_page(APIs.auth.currentUser?.displayName,APIs.auth.currentUser?.photoURL)));
              });
            }

        }
    });
  }

    Future<UserCredential?> _signInWithGoogle() async {
      try{
        // Check if there is an active internet connection by looking up 'google.com'
         await InternetAddress.lookup('google.com');
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }catch(e){
       print('_signInWithGoogle: $e');
       dialogs.showsnackbar(context, 'Check your internet connection,there is some error with it');
       return null;
      }
    }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Pet adoption',style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'gabarito'
          )),
          centerTitle: true,
          elevation: 2,

          backgroundColor: Colors.teal.shade600,

        ),
        body: Container(
          color: Colors.teal.shade100,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 1500),
                top: nq.height * .15,
                right: _isAnimate ? nq.width * .15 : -nq.width * .7,
                width: nq.width * .7,
                child: Image.asset('assets/images/icon.png'),
              ),
              Positioned(
                bottom: nq.height * .12,
                  left: nq.width * .05,
                  width: nq.width * .9,
                  height: nq.height * .06,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.green[400],
                      shape: const StadiumBorder(),
                    ),
                      onPressed: (){
                      _handleGoogleBtnClick();
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>menu_page()));
                      },
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/google.png'),
                      ), label: Text('Sign in',style: TextStyle(fontWeight: FontWeight.w200,fontSize: 17,fontFamily: 'gabarito'),)),
              ),
            ],
          ),
        ),
      );
  }
}
