import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LatLng {
  final double latitude;
  final double longitude;
  LatLng(this.latitude, this.longitude);
}

class add_pet_page extends StatefulWidget {
  final VoidCallback opendrawer;
  final String user_loc;
  final String? uid;

  add_pet_page(this.opendrawer, this.user_loc, this.uid);

  @override
  State<add_pet_page> createState() => _add_pet_pageState();
}

class _add_pet_pageState extends State<add_pet_page> {
  final _formKey = GlobalKey<FormState>();

  final owner_name = TextEditingController();
  final name = TextEditingController();
  final age = TextEditingController();
  final breed = TextEditingController();
  final gender = TextEditingController();
  final resn = TextEditingController();
  final pet = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final price = TextEditingController();
  final contact_no = TextEditingController();
  final currloc = TextEditingController();

  File? mediaFile;
  String? mediaType;
  String imageUrl = "";
  bool isUploading = false;
  final ImagePicker _picker = ImagePicker();

  final Color tealDark = Color(0xFF00796B);
  final Color tealLight = Color(0xFFE0F2F1);

  List<Map<String, dynamic>> get fields => [
    {"label": "Owner Name", "controller": owner_name},
    {"label": "Pet", "controller": pet, "hint": "e.g. cat, dog, parrot"},
    {"label": "Name of the pet", "controller": name},
    {"label": "Breed", "controller": breed},
    {"label": "Gender", "controller": gender, "hint": "e.g. male, female"},
    {"label": "Age", "controller": age, "keyboardType": TextInputType.number},
    {"label": "Height(in cm)", "controller": height, "keyboardType": TextInputType.number},
    {"label": "Weight(in kgs)", "controller": weight, "keyboardType": TextInputType.number},
    {"label": "Pet Selling Price", "controller": price, "hint": "in rupees", "keyboardType": TextInputType.number},
    {"label": "Contact no.", "controller": contact_no, "keyboardType": TextInputType.phone},
    {"label": "Enter your Location", "controller": currloc},
    {"label": "Please share why you are rehoming your pet...", "controller": resn},
  ];

  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      return LatLng(locations.first.latitude, locations.first.longitude);
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<double?> calculatedistance(String useraddress, String owneraddress) async {
    LatLng? userCoordinates = await getCoordinatesFromAddress(useraddress);
    LatLng? ownerCoordinates = await getCoordinatesFromAddress(owneraddress);

    if (userCoordinates != null && ownerCoordinates != null) {
      double distanceInMeters = await Geolocator.distanceBetween(
        userCoordinates.latitude,
        userCoordinates.longitude,
        ownerCoordinates.latitude,
        ownerCoordinates.longitude,
      );
      return distanceInMeters / 1000;
    } else {
      return null;
    }
  }

  Future<void> pickMedia(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        isUploading = true;
      });

      final mediaUrl = await uploadMediaToCloudinary(File(pickedFile.path), 'image');

      setState(() {
        isUploading = false;
        imageUrl = mediaUrl ?? "";
      });

      if (mediaUrl != null) {
        print('Image uploaded: $mediaUrl');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<String?> uploadMediaToCloudinary(File file, String type) async {
    try {
      final url = dotenv.env['CLOUDINARY_URL']!;
      final preset = dotenv.env['CLOUDINARY_UPLOAD_PRESET']!;

      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['upload_preset'] = preset
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        return jsonResponse['secure_url'];
      } else {
        print('Upload failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception during upload: $e');
      return null;
    }
  }

  void addToFirestore(Map<String, dynamic> data) async {
    if (widget.uid == null || widget.uid!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in!'), backgroundColor: Colors.red),
      );
      return;
    }

    String addedpet = pet.text.toLowerCase(); // e.g. "cat"
    CollectionReference? petCollection;

    if (["cat", "dog", "horse", "rabbit", "parrot"].contains(addedpet)) {
      petCollection = FirebaseFirestore.instance.collection("${addedpet}s"); // pluralize collection name
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid pet type.'), backgroundColor: Colors.red),
      );
      return;
    }

    // Add singular petType to data for petCollection
    data["petType"] = addedpet;

    double? distance = await calculatedistance(widget.user_loc, currloc.text);
    if (distance == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error calculating distance. Check the location fields.'), backgroundColor: Colors.red),
      );
      return;
    }

    data["loc"] = distance.toStringAsFixed(2);

    try {
      // Add to plural pet collection first (with singular petType)
      DocumentReference petRef = await petCollection.add(data);

      // Now add to user's mypets, but update petType to plural form here
      Map<String, dynamic> dataForMyPets = Map<String, dynamic>.from(data);
      dataForMyPets["petType"] = "${addedpet}s"; // plural petType for mypets
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .collection("mypets")
          .doc(petRef.id)
          .set(dataForMyPets);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pet added successfully!'), backgroundColor: Colors.green),
      );

      _formKey.currentState?.reset();
      setState(() {
        imageUrl = "";
      });
    } catch (e) {
      print("Firestore add error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add pet. Please try again.'), backgroundColor: Colors.red),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tealLight,
      appBar: AppBar(
        backgroundColor: tealDark,
        title: Text('Add Pet', style: TextStyle(fontFamily: 'gabarito')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.opendrawer,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ...fields.map((field) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: field['controller'],
                    keyboardType: field['keyboardType'] ?? TextInputType.text,
                    decoration: InputDecoration(
                      labelText: field['label'],
                      hintText: field['hint'],
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: tealDark, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: tealDark.withOpacity(0.7), width: 1.2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: tealDark, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter ${field['label'].toString().toLowerCase()}';
                      }
                      return null;
                    },
                  ),
                );
              }).toList(),
              SizedBox(height: 15),
              ElevatedButton.icon(
                icon: Icon(Icons.image, color: Colors.white),
                label: Text('Upload Pet Image', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tealDark,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () => pickMedia(ImageSource.gallery),
              ),
              if (isUploading) ...[
                SizedBox(height: 15),
                CircularProgressIndicator(color: tealDark),
              ],
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: isUploading
                    ? null
                    : () {
                  if (!_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all the fields'), backgroundColor: Colors.red),
                    );
                    return;
                  }
                  if (imageUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please upload an image'), backgroundColor: Colors.red),
                    );
                    return;
                  }

                  final data = {
                    "Owner name": owner_name.text.trim(),
                    "Name": name.text.trim(),
                    "Age": age.text.trim(),
                    "Breed": breed.text.trim(),
                    "Gender": gender.text.trim(),
                    "resn": resn.text.trim(),
                    "image": imageUrl,
                    "height": height.text.trim(),
                    "weight": weight.text.trim(),
                    "price": price.text.trim(),
                    "contact_no": contact_no.text.trim(),
                  };

                  addToFirestore(data);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tealDark,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                child: Text('+ Add Pet', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
