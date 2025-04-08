import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption/login_screen.dart';
import 'package:pet_adoption/chat_application/home_screen.dart';
import 'package:pet_adoption/menu_page.dart';
import '../main.dart';
import 'api/apis.dart';
class splash_screen extends StatefulWidget {

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      //exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      if(APIs.auth.currentUser !=null)
        {
          print('\nUser: ${APIs.auth.currentUser}');
          //move to home screen
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>  menu_page(APIs.auth.currentUser?.displayName,APIs.auth.currentUser?.photoURL)));
        }
      else
        {
          //move to home screen
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>  login_screen()));
        }

    });
  }
  @override
  Widget build(BuildContext context) {
    //initialising media query (for getting device screen size)
    nq = MediaQuery.of(context).size;

    return  Scaffold(
      body: Container(
        color: Colors.teal.shade100,
        child: Stack(
          children: [
             Positioned(
              top: nq.height * .25,
              right: nq.width * .14,
              width: nq.width * .7,
              child: Image.asset('assets/images/icon.png'),
            ),
            Positioned(
              bottom: nq.height * .09,
              width: nq.width,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('Adopt ',style: TextStyle(fontFamily: 'gabarito',fontSize: 35,fontWeight: FontWeight.w400),),
                     Text('❣️',style: TextStyle(color: Colors.red,fontSize: 50),)
                   ],
                 ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text('Do not shop',style: TextStyle(fontFamily: 'gabarito',fontSize: 35,fontWeight: FontWeight.w400),),
                  ),
                  Text('Your future best friend are waiting for you.',style: TextStyle(fontSize: 16,color: Colors.grey,fontFamily: 'gabarito'),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
