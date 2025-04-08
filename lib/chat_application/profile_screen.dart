import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_adoption/login_screen.dart';
import 'package:pet_adoption/models/chat_user.dart';
import '../main.dart';

class profile_screeen extends StatefulWidget {
  final ChatUser user;
  profile_screeen(this.user);

  @override
  State<profile_screeen> createState() => _profile_screeenState();
}

class _profile_screeenState extends State<profile_screeen> {
  bool isFocused = false;
  bool isfocus = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen',style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          )),
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },),
        ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children:[
                        Padding(
                        padding: const EdgeInsets.only(top: 58.0,left: 65),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(nq. width * 45),
                          child: CachedNetworkImage(
                            width: nq.width* 0.3,
                            height: nq.height* .13,
                            fit: BoxFit.fill,
                            imageUrl:widget.user.image,
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 20,
                              child: Icon(Icons.person),
                            ),
                          ),
                         ),
                      ),
                        Positioned(
                          bottom: 0,
                          left: 111,
                          child: MaterialButton(
                            elevation: 2,
                            onPressed: (){},
                            shape: CircleBorder(),
                            color: Colors.white,
                            child: Icon(Icons.edit,color: Colors.teal,),
                          ),
                        )
                     ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 75.0),
                      child: Container(
                          width: 220,
                          height: 80,
                          child: Text(widget.user.email,style: TextStyle(fontSize: 20,fontFamily: 'gabarito',color: Colors.black54),)),
                    ),
                  ],
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
              child: Focus(
                onFocusChange: (hasFocus){
                  setState(() {
                    isFocused = hasFocus;
                  });
                },
                child: TextFormField(
                  initialValue: widget.user.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person,color: isFocused ? Colors.teal : Colors.black54,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.teal
                      )
                    ),
                    hintText:"eg.- Aakash Yadav",
                    hintStyle: TextStyle(
                      fontFamily: 'gabarito',
                      color: Colors.black26
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 20,
                      color:  isFocused ? Colors.teal : Colors.black54,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 1.5,
                      ),
                    ),
                  ),
                  cursorColor: Colors.teal[600],

            ),
              ),
            ),
            Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                  child: Focus(
                    onFocusChange: (hasFocus){
                      setState(() {
                        isfocus = hasFocus;
                      });
                    },
                    child: TextFormField(
                      initialValue: widget.user.about,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.info_outline,color: isfocus ? Colors.teal : Colors.black54,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.teal
                            )
                        ),
                        hintText:"eg.- Feeling Happy",
                        hintStyle: TextStyle(
                            fontFamily: 'gabarito',
                            color: Colors.black26
                        ),
                        labelText: "About",
                        labelStyle: TextStyle(
                          fontFamily: 'gabarito',
                          fontSize: 20,
                          color:  isfocus ? Colors.teal : Colors.black54,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.teal,
                            width: 1.5,
                          ),
                        ),
                      ),
                      cursorColor: Colors.teal[600],

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120.0,vertical: 20),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.teal,//button color
                        onPrimary: Colors.white,//text color
                        shape: StadiumBorder(),
                        shadowColor: Colors.teal,
                        minimumSize: Size(120, 40)),
                    onPressed: (){},
                    icon: Icon(Icons.edit),
                    label: Text('UPDATE',style: TextStyle(
                      fontFamily: 'gabarito',
                      fontSize: 15
                    ),),),
                )
              ]
            ),
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 10,right: 8),
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                     onPressed: ()async{
                       await FirebaseAuth.instance.signOut();
                       await GoogleSignIn().signOut().then((value) => Navigator.pop(context));
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>login_screen()));
                     },
                    icon: Icon(Icons.logout),
                    label: Text('Log Out',
                    style: TextStyle(
                      fontFamily: 'gabarito',
                      color: Colors.white,
                    ),),
                  ),
            ),),
    );
  }
}
