import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption/configuration.dart';
import 'package:provider/provider.dart';
class detail_page extends StatefulWidget {
  String name="";
  String breed="";
  String ownername="";
  String resn = "";
  String imagepath="";
  String gender;
  String height;
  String weight;
  String price;
  String contact_no;
  var clr;
  var age;
  String loc;
  detail_page(this.name,this.ownername,this.resn, this.breed, this.age, this.imagepath,this.gender,this.clr,this.loc,this.height,this.weight,this.price,this.contact_no);

  @override
  State<detail_page> createState() => _detail_pageState();
}

class _detail_pageState extends State<detail_page> {
  bool ispressed = false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                          color: widget.clr,
                        )),
                    Expanded(child: Container(
                      color: Colors.white,
                    )),
                  ],
                )),

            //********************Full photo of pet with some icons ************************
            Container(
              margin: EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
              child: Align(
                alignment: AlignmentDirectional.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {
                      Navigator.pop(context);
                    },
                        icon: Icon(Icons.arrow_back, size: 30,
                          color: Colors.black54,)),

                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60.0),
              child: Align(
                alignment: AlignmentDirectional.topCenter,
                child: Image.network(widget.imagepath,height: 220,),
              ),
            ),

            //******************* Container having info of pet***************************
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0,),
                height: 140,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 13.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.name, style: TextStyle(
                              fontFamily: 'gabarito',
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: Colors.black),),

                          Row(
                            children: [
                              Text(widget.price,style: TextStyle(
                                color: Colors.orange.shade900,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),),
                              Icon(FontAwesomeIcons.dollar,color: Colors.orange.shade900,size: 18,weight: 100,)
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.breed, style: TextStyle(
                                fontFamily: 'gabarito',
                                fontWeight: FontWeight.w200,
                                fontSize: 15,
                                color: Colors.black45),),
                            Row(
                              children: [
                                Text('Height: ',style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'gabarito'
                                ),),
                                Text('${widget.height}cm',style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'gabarito'
                                ),)
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${widget.age} years', style: TextStyle(
                              fontFamily: 'gabarito',
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Colors.black45),),
                          Row(
                            children: [
                              Text('Weight: ',style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'gabarito'
                              ),),
                              Text('${widget.weight}kg',style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'gabarito'
                              ),)
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.teal[800],
                                  size: 20.0,),
                                Text('${widget.loc} km away', style: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                    color: Colors.black45),),
                              ],
                            ),
                            Icon(widget.gender=="female"?Icons.female_outlined:Icons.male_outlined,size: 20,color: Colors.black54,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            //****************** owner description **************************************
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsets.only(top: 220.0,),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: Colors.brown,
                    child: Text(widget.ownername[0], style: TextStyle(
                        fontFamily: 'gabarito',
                        fontWeight: FontWeight.w200,
                        fontSize: 23,
                        color: Colors.white),),
                  ),
                  title: Text(widget.ownername, style: TextStyle(
                      fontFamily: 'gabarito',
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                      color: Colors.black),),
                  subtitle: Text('Pet Owner', style: TextStyle(
                      fontFamily: 'gabarito',
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                      color: Colors.black45),),
                  trailing: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            onPressed: (){
                              FlutterPhoneDirectCaller.callNumber(widget.contact_no);
                            },
                            icon: Icon(Icons.phone_in_talk_outlined,color: Colors.white,size: 20,),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: shadowList,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.chat_bubble_outline_outlined,color: Colors.white,size: 20,),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: shadowList,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 350.0, left: 25.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.resn,style:TextStyle(color: Colors.black26,fontFamily: 'gabarito',fontSize: 15),),
                  ],
                ),
              ),
            ),

            //*********************Ending: Adoption button *******************************
            Padding(
              padding: const EdgeInsets.only(bottom: 45.0),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(30.0)),
                    color: Colors.grey[100],
                  ),
                  // margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 60,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.0),
                            color: Colors.teal[600],
                            boxShadow: shadowList,
                          ),
                          child: IconButton(onPressed: (){
                            setState(() {
                              ispressed = !ispressed;
                            });

                            Map <String,dynamic> data = {
                              "Owner name":widget.ownername,
                              "Name":widget.name,
                              "Age":widget.age,
                              "Breed":widget.breed,
                              "Gender":widget.gender,
                              "resn":widget.resn,
                              "imagurl":widget.imagepath,
                              "loc":widget.loc,

                            };
                            CollectionReference firestore = FirebaseFirestore.instance.collection("favorites");
                            String timestampId = widget.imagepath.toString();
                            try {
                              if (ispressed) {
                                // Add to favorites
                                if (firestore != null) {
                                  firestore!.doc(timestampId).set(data);
                                } else {
                                  print(
                                      'Firestore not initialized. Call func() first.');
                                }
                              } else {
                                // Remove from favorites
                                if (firestore != null) {
                                  firestore!.doc(timestampId).delete();
                                } else {
                                  print(
                                      'Firestore not initialized. Call func() first.');
                                }
                              }
                            }catch(e)
                            {
                              print('Error: $e');
                            }

                          },
                            icon: ispressed ? Icon(Icons.favorite,color: Colors.red[300],):Icon(Icons.favorite_border_sharp,color: Colors.white,),

                          ),
                        ),
                        Container(
                          height: 60,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.teal[600],
                            boxShadow: shadowList,
                          ),
                          child: ElevatedButton(onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            child: Text('Adoption', style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontFamily: 'gabarito',
                                fontSize: 20,
                                color: Colors.white),),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
