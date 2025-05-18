import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pet_adoption/MyPets.dart';
import 'package:pet_adoption/add_pet_page.dart';
import 'package:pet_adoption/privacy_page.dart';
import 'adoption_page.dart';
import 'login_screen.dart';
import 'favorite_page.dart';

// Add the new menu list here
List<Map<String, dynamic>> menu = [
  {'title': 'Adoption', 'icon': Icons.pets},
  {'title': 'Add Pet', 'icon': Icons.add},
  {'title': 'Favorites', 'icon': Icons.favorite},
  {'title': 'My Pets', 'icon': Icons.pets},
  {'title': 'Settings', 'icon': Icons.settings},
];

// Track which menu is tapped
List<bool> isTap = List.generate(menu.length, (index) => false);

class menu_page extends StatefulWidget {
  var name;
  var img;
  String? uid;
  menu_page(this.name, this.img,this.uid);
  @override
  State<menu_page> createState() => _menu_pageState();
}

class _menu_pageState extends State<menu_page> {
  late double xoffset;
  late double yofffset;
  late double scaleFactor;
  late bool isdraweropen;
  bool istapped = false;
  String currentAddress = 'My Address';
  late Position currentposition;

  void _determinePosition() async {
    bool serviceEnabled; // to check whether the location is on or not
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please keep your location on.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // if the user denied the permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // if the user denied the permission again
        Fluttertoast.showToast(msg: 'Location Permission is denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // if permission is denied for forever
      Fluttertoast.showToast(msg: 'Location Permission is denied forever.');
    }
    // if permission is permitted
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        currentposition = position;
        currentAddress = "${place.locality}, ${place.postalCode},${place.country}";
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    opendrawer();
  }

  void opendrawer() => setState(() {
    isdraweropen = true;
    xoffset = 250.0;
    yofffset = 170.0;
    scaleFactor = 0.6;
  });

  void closedrawer() => setState(() {
    isdraweropen = false;
    xoffset = 0.0;
    yofffset = 0.0;
    scaleFactor = 1;
  });

  String item = "Adoption";

  Widget getpage(String itemtype) {
    switch (itemtype) {
      case "Adoption":
        _determinePosition();
        return adoption(opendrawer, currentAddress,widget.uid);
      case "Favorites":
        return FavoritePage(opendrawer,widget.uid);
      case "Add Pet":
        _determinePosition();
        return add_pet_page(opendrawer, currentAddress,widget.uid);
      case "My Pets":
        return MyPetsList(widget.uid,opendrawer); // NEW PAGE for My Pets
      default:
        _determinePosition();
        return adoption(opendrawer, currentAddress,widget.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        endDrawer: Container(
          width: 160,
          child: Drawer(
            child: Container(
              color: Colors.teal.shade100,
              child: ListView(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade300,
                      ),
                      child: Image.asset('assets/images/icon.png')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => privacy()));
                      },
                      child: Text(
                        'Privacy Policy      ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 17),
                      )),
                  TextButton(
                      onPressed: () {
                        showRateMyAppDialog(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          Text(
                            '  Rate this app ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 17),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 400.0),
                    child: IconButton(
                        onPressed: () async {
                          if (istapped == false)
                            istapped = true;
                          else
                            istapped = false;

                          await FirebaseAuth.instance.signOut();
                          await GoogleSignIn().signOut();

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => login_screen()));
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 30,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
        endDrawerEnableOpenDragGesture: true,
        body: Stack(children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.teal[800],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.8),
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width * .12,
                            height: MediaQuery.of(context).size.width * .12,
                            imageUrl: widget.img,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => CircleAvatar(
                              backgroundColor: Colors.grey.shade100,
                              radius: 20,
                              child: Icon(
                                Icons.person,
                                color: Colors.teal[600],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'gabarito'),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 25.0, top: 50.0, bottom: 10.0),
                  child: Text(
                    'Hello!',
                    style: TextStyle(
                        fontFamily: 'gabarito',
                        fontSize: 25,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                ),

                //**************** Menu **************************
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 8.0),
                      child: ListView.builder(
                          itemCount: menu.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (isTap.contains(true)) {
                                  int ind = isTap.indexOf(true);
                                  isTap[ind] = false;
                                  isTap[index] = true;
                                } else {
                                  isTap[index] = true;
                                }
                                item = menu[index]['title'];
                                if (item == "Settings")
                                  Scaffold.of(context).openEndDrawer();
                                setState(() {});
                              },
                              child: ListTile(
                                leading: Icon(
                                  menu[index]['icon'],
                                  color:
                                  isTap[index] ? Colors.white : Colors.white54,
                                ),
                                title: Text(
                                  menu[index]['title'],
                                  style: TextStyle(
                                      color: isTap[index]
                                          ? Colors.white
                                          : Colors.white54,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                      fontFamily: 'gabarito'),
                                ),
                              ),
                            );
                          })),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: closedrawer,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              transform: Matrix4.translationValues(xoffset, yofffset, 0)
                ..scale(scaleFactor),
              child: ClipRRect(
                borderRadius: isdraweropen
                    ? BorderRadius.circular(35)
                    : BorderRadius.circular(0),
                child: AbsorbPointer(
                  absorbing: isdraweropen,
                  child: getpage(item),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

// Placeholder for My Pets Page - Replace with your actual implementation
class my_pets_page extends StatelessWidget {
  final VoidCallback opendrawer;
  my_pets_page(this.opendrawer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Pets'),
        backgroundColor: Colors.teal[800],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: opendrawer,
        ),
      ),
      body: Center(
        child: Text(
          'My Pets Screen - Coming Soon!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

void showRateMyAppDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      double rating = 0;

      return AlertDialog(
        title: Text('Rate Our Pet Adoption App'),
        content: Container(
          height: 100,
          child: Column(
            children: [
              Text('How many stars would you give us?'),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40.0,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  rating = value;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Submit'),
          ),
          TextButton(
            onPressed: () {
              // Dismiss the dialog
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
