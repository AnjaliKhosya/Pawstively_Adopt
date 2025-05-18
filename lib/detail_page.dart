import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:pet_adoption/Configuration.dart';

class detail_page extends StatefulWidget {
  String name = "";
  String breed = "";
  String ownername = "";
  String resn = "";
  String imagepath = "";
  String gender;
  String height;
  String weight;
  String price;
  String contact_no;
  var clr;
  var age;
  String loc;
  String? uid;
  String? pid;

  detail_page(
      this.name,
      this.ownername,
      this.resn,
      this.breed,
      this.age,
      this.imagepath,
      this.gender,
      this.clr,
      this.loc,
      this.height,
      this.weight,
      this.price,
      this.contact_no,
      this.uid,
      this.pid,
      );

  @override
  State<detail_page> createState() => _detail_pageState();
}

class _detail_pageState extends State<detail_page> {
  bool ispressed = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    if (widget.uid == null || widget.pid == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .collection('favorites')
        .doc(widget.pid)
        .get();

    if (doc.exists) {
      setState(() {
        ispressed = true;
      });
    }
  }

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
                    Expanded(
                        child: Container(
                          color: Colors.white,
                        )),
                  ],
                )),

            //********************Full photo of pet with some icons ************************
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, size: 30, color: Colors.black54),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 70.0, left: 20, right: 20),
              child: Align(
                alignment: AlignmentDirectional.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),  // Rounded corners radius
                  child: Image.network(
                    widget.imagepath,
                    height: 260,
                    width: 200,
                    fit: BoxFit.cover,  // Optional: makes image cover container nicely
                  ),
                ),
              ),
            ),


            //******************* Container having info of pet***************************
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                height: 140,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 13.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontFamily: 'gabarito',
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                          Row(
                            children: [
                              Text(
                                widget.price,
                                style: TextStyle(
                                  color: Colors.orange.shade900,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.currency_rupee,
                                color: Colors.orange.shade900,
                                size: 25,
                                weight: 100,
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.breed,
                              style: TextStyle(
                                  fontFamily: 'gabarito',
                                  fontWeight: FontWeight.w200,
                                  fontSize: 15,
                                  color: Colors.black45),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Height: ',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'gabarito'),
                                ),
                                Text(
                                  '${widget.height}cm',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                      fontFamily: 'gabarito'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.age} years',
                            style: TextStyle(
                                fontFamily: 'gabarito',
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                color: Colors.black45),
                          ),
                          Row(
                            children: [
                              Text(
                                'Weight: ',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'gabarito'),
                              ),
                              Text(
                                '${widget.weight}kg',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: 'gabarito'),
                              )
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
                                Icon(
                                  Icons.location_on,
                                  color: Colors.teal[800],
                                  size: 20.0,
                                ),
                                Text(
                                  '${widget.loc} km away',
                                  style: TextStyle(
                                      fontFamily: 'gabarito',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                      color: Colors.black45),
                                ),
                              ],
                            ),
                            Icon(
                              widget.gender == "female"
                                  ? Icons.female_outlined
                                  : Icons.male_outlined,
                              size: 20,
                              color: Colors.black54,
                            )
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
                padding: const EdgeInsets.only(
                  top: 220.0,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: Colors.brown,
                    child: Text(
                      widget.ownername[0],
                      style: TextStyle(
                          fontFamily: 'gabarito',
                          fontWeight: FontWeight.w200,
                          fontSize: 23,
                          color: Colors.white),
                    ),
                  ),
                  title: Text(
                    widget.ownername,
                    style: TextStyle(
                        fontFamily: 'gabarito',
                        fontWeight: FontWeight.w300,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    'Pet Owner',
                    style: TextStyle(
                        fontFamily: 'gabarito',
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                        color: Colors.black45),
                  ),
                  trailing: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            onPressed: () {
                              FlutterPhoneDirectCaller.callNumber(widget.contact_no);
                            },
                            icon: Icon(
                              Icons.phone_in_talk_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
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
                            onPressed: () {},
                            icon: Icon(
                              Icons.chat_bubble_outline_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
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
                padding: const EdgeInsets.only(top: 350.0, left: 25.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.resn,
                      style: TextStyle(
                          color: Colors.black26, fontFamily: 'gabarito', fontSize: 15),
                    ),
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
                    padding: const EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
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
                          child: IconButton(
                            onPressed: () async {
                              setState(() {
                                ispressed = !ispressed;
                              });

                              Map<String, dynamic> data = {
                                "ownername": widget.ownername,
                                "name": widget.name,
                                "age": widget.age,
                                "breed": widget.breed,
                                "gender": widget.gender,
                                "resn": widget.resn,
                                "imagepath": widget.imagepath,
                                "loc": widget.loc,
                                "price": widget.price,
                                "height": widget.height,
                                "weight": widget.weight,
                                "contact_no": widget.contact_no,
                                "petType": widget.clr == Colors.orange[100] ? "cats" : "dogs",
                                "petId": widget.pid,
                              };

                              try {
                                final firestore = FirebaseFirestore.instance;
                                final userFavorites = firestore
                                    .collection("users")
                                    .doc(widget.uid)
                                    .collection("favorites");

                                final docId = widget.pid ?? DateTime.now().toString();

                                if (ispressed) {
                                  await userFavorites.doc(docId).set(data);
                                } else {
                                  await userFavorites.doc(docId).delete();
                                }
                              } catch (e) {
                                print('Error updating favorites: $e');
                              }
                            },
                            icon: ispressed
                                ? Icon(
                              Icons.favorite,
                              color: Colors.red[300],
                            )
                                : Icon(
                              Icons.favorite_border_sharp,
                              color: Colors.white,
                            ),
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
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            child: Text(
                              'Adoption',
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'gabarito',
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
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
