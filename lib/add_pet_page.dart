import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'configuration.dart';
import 'dart:core';
class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);
}
class add_pet_page extends StatefulWidget {
  VoidCallback opendrawer;
  String user_loc;
  add_pet_page(this.opendrawer,this.user_loc);

  @override
  State<add_pet_page> createState() => _add_pet_pageState();
}

class _add_pet_pageState extends State<add_pet_page> {
  TextEditingController owner_name = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController resn = TextEditingController();
  TextEditingController pet = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController contact_no = TextEditingController();
  TextEditingController currloc = TextEditingController();
  String unique_id = "";
  CollectionReference? firestore;
  String imageUrl = "";

  //calculating distance
  Future<LatLng?> getCoordinatesFromAddress(String address) async{
    try{
      List<Location> locations = await locationFromAddress(address);
      return LatLng(locations.first.latitude, locations.first.longitude);
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<double?> calculatedistance(String useraddress,String owneraddress)async
  {
    LatLng? userCoordinates = await getCoordinatesFromAddress(useraddress);
    LatLng? ownerCoordinates = await getCoordinatesFromAddress(owneraddress);

    if(userCoordinates!=null && ownerCoordinates!=null) {
      double distanceInMeters = await Geolocator.distanceBetween(
          userCoordinates.latitude, userCoordinates.longitude,
          ownerCoordinates.latitude, ownerCoordinates.longitude);
      double distanceInKm = distanceInMeters / 1000;
      return distanceInKm;
    }
    else
      return null;

  }

  void addToFirestore(Map<String, dynamic> data) async{
    String addedpet = pet.text;
    print(addedpet);
    if(addedpet=="cat")
      firestore = FirebaseFirestore.instance.collection("cats");
    if(addedpet=="dog")
      firestore = FirebaseFirestore.instance.collection("dogs");
    if(addedpet=="horse")
      firestore = FirebaseFirestore.instance.collection("horses");
    if(addedpet=="rabbit")
      firestore = FirebaseFirestore.instance.collection("rabbits");
    if(addedpet=="parrot")
      firestore = FirebaseFirestore.instance.collection("parrots");
    if (firestore != null) {
      double? distance = await calculatedistance(widget.user_loc, currloc.text);
      if(distance!=null)
        {
          data["loc"] = distance.toStringAsFixed(2);
          firestore!.add(data);
        }
      else
        {
          print('Error calculating distance.');
        }
    } else {
      print('Firestore not initialized. Call func() first.');
    }
  }
  bool isfocus = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              widget.opendrawer();
            },
          ),
          title: Text('Add Pet',style: TextStyle(color: Colors.black,fontFamily: 'gabarito',fontSize: 24),),

          centerTitle: true,
          elevation: 2,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(

                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0,left: 50),
                            child: Text('Add the details of your pet:',style: TextStyle(fontFamily: 'gabarito',fontSize: 20,fontWeight:FontWeight.w100,color: Colors.teal.shade600),),
                          ),
                          //***********Add details of your pet***********
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: owner_name,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  labelText: "Owner Name",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
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
                            padding: const EdgeInsets.only(top: 20.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: pet,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  hintText:"eg.- cat (write in lower case letter)",
                                  hintStyle: TextStyle(
                                      fontFamily: 'gabarito',
                                      color: Colors.black26
                                  ),
                                  labelText: "Pet",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
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
                            padding: const EdgeInsets.only(top: 25.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: name,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  labelText: "Name of the pet",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
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
                            padding: const EdgeInsets.only(top: 25.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: breed,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  labelText: "Breed",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
                                    color:  isfocus ? Colors.teal : Colors.black54,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                      width: 1.5,
                                    ),
                                  ),
                                ), cursorColor: Colors.teal[600],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: gender,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  hintText:"write in lower case letters(female/male)",
                                  hintStyle: TextStyle(
                                      fontFamily: 'gabarito',
                                      fontSize: 13,
                                      color: Colors.black26
                                  ),
                                  labelText: "Gender",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
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
                            padding: const EdgeInsets.only(top: 25.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: age,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  labelText: "Age",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
                                    color:  isfocus ? Colors.teal : Colors.black54,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Colors.teal,
                                      width: 1.5,
                                    ),
                                  ),
                                ), cursorColor: Colors.teal[600],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: height,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  labelText: "Height(in cm)",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
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
                            padding: const EdgeInsets.only(top: 20.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: weight,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  labelText: "Weight(in kgs)",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
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
                            padding: const EdgeInsets.only(top: 20.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: price,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  hintText: "in dollar",
                                  hintStyle: TextStyle(
                                      fontFamily: 'gabarito',
                                      color: Colors.black26
                                  ),
                                  labelText: "Pet Selling Price",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
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
                            padding: const EdgeInsets.only(top: 20.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: contact_no,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  labelText: "Contact no.",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
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
                            padding: const EdgeInsets.only(top: 20.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: currloc,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  labelText: "Enter your Location",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
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
                            padding: const EdgeInsets.only(top: 20.0,left: 50.0,right: 20.0),
                            child: SizedBox(
                              width: 280,
                              height: 45,
                              child: TextFormField(
                                controller: resn,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.teal
                                      )
                                  ),
                                  labelText: "Please share why you are rehoming your pet...",
                                  labelStyle: TextStyle(
                                    fontFamily: 'gabarito',
                                    fontSize: 15,
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
                            padding: const EdgeInsets.only(top: 20.0,left: 20.0),
                            child: Row(
                              children: [
                                IconButton(onPressed: ()async{
                                  /*
                                  * Step 1. Pick/Capture an image
                                  * Step 2. Upload the image to Firebase storage
                                  * Step 3. Get the URL of the uploaded image
                                  * Step 4. Store the image URL inside the corresponding document of the database
                                  * Step 5. Display the image on the list
                                  */

                                  /* ***************************
                                  Step 1. Pick image
                                  Install image_picker
                                  Import the corresponding library
                                   */
                                  ImagePicker imagePicker= ImagePicker();
                                  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                                  print('${file?.path}');
                                  if(file==null)
                                    return;
                                  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                                  /* *******************************
                                  Step 2. Uplod to firebase storage
                                  Install firebase_storage
                                  Import the library
                                   */

                                  //Get a reference to storage root to upload the file
                                  Reference referenceroot = FirebaseStorage.instance.ref();
                                  Reference referenceDirImages = referenceroot.child('images');

                                  // create a reference for the image to be stored
                                  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

                                  //handle error/succcess
                                  try{
                                    //store the file
                                    await referenceImageToUpload.putFile(File(file!.path));
                                    //success: get the download URL
                                    imageUrl = await referenceImageToUpload.getDownloadURL();
                                  }catch(error)
                                  {
                                     //some error occured
                                    print(error);
                                  }
                                }, icon: Icon(Icons.camera_alt,color: Colors.teal.shade800,size: 33,)),
                                Text('Add the image of your pet',style: TextStyle(fontSize: 18,color: Colors.black54,fontFamily: 'gabarito'),)
                              ],
                            ),
                          ),
                          Container(
                            height: 130,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //*************** Add pet button **************
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Container(
                  color: Colors.white,
                  height: 110,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 45,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50,left: 55.0),
                  child: Container(
                    height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.teal[600],
                      boxShadow: shadowList,
                    ),
                    child: ElevatedButton(onPressed: () {
                      if(imageUrl.isEmpty)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Upload an image')));
                          return;
                        }
                      String distance = calculatedistance(widget.user_loc,currloc.toString()).toString();
                      Map <String,dynamic> data = {
                        "Owner name":owner_name.text,
                        "Name":name.text,
                        "Age":age.text,
                        "Breed":breed.text,
                        "Gender":gender.text,
                        "resn":resn.text,
                        "image":imageUrl,
                        "loc":distance,
                        "height": height.text,
                        "weight": weight.text,
                        "price": price.text,
                        "contact_no": contact_no.text,
                      };
                      addToFirestore(data);
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      child: Text('+ Add Pet', style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontFamily: 'gabarito',
                          fontSize: 20,
                          color: Colors.white),),),
                  ),
                ),
              ),
            ],
          ),
        ),
    ),);
  }
}
