import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';

final List<BoxShadow> shadowList = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 2,
    blurRadius: 10,
    offset: Offset(0, 3),
  ),
];

class MyPetsList extends StatefulWidget {
  final String? currentUserId;
  final VoidCallback opendrawer;

  MyPetsList(this.currentUserId, this.opendrawer);

  @override
  _MyPetsListState createState() => _MyPetsListState();
}

class _MyPetsListState extends State<MyPetsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Text('My Pets', style: TextStyle(fontFamily: 'gabarito',color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: widget.opendrawer,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentUserId)
            .collection('mypets')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Center(child: Text('No pets found.'));
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final doc = documents[index];
              final docData = doc.data()! as Map<String, dynamic>;

              String petDocId = doc.id;
              String petType = docData['petType'] ?? '';

              String name = docData['Name'] ?? 'N/A';
              String gender = docData['Gender'] ?? 'N/A';
              String breed = docData['Breed'] ?? 'N/A';
              String age = docData['Age'] ?? 'N/A';
              String imageurl = docData['image'] ?? '';
              String loc = docData['loc'] ?? 'N/A';
              String resn = docData['resn'] ?? 'N/A';
              String ownername = docData['Owner name'] ?? 'N/A';
              String height = docData['height'] ?? 'N/A';
              String weight = docData['weight'] ?? 'N/A';
              String price = docData['price'] ?? 'N/A';
              String contact_no = docData['contact_no'] ?? 'N/A';
              Color bgColor = (index % 2 == 0)
                  ? Colors.blueGrey[300]!
                  : Colors.amber[200]!;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => detail_page(
                        name,
                        ownername,
                        resn,
                        breed,
                        age,
                        imageurl,
                        gender,
                        bgColor,
                        loc,
                        height,
                        weight,
                        price,
                        contact_no,
                        widget.currentUserId,
                        petDocId,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'drag',
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 230,
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: (index % 2 == 0)
                                      ? Colors.blueGrey[300]
                                      : Colors.amber[200],
                                ),
                                margin: EdgeInsets.only(top: 40.0),
                              ),
                              Align(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    height: 160,
                                    width: 130,
                                    child: imageurl != null
                                        ? Image.network(imageurl, fit: BoxFit.cover)
                                        : Container(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 60, bottom: 25.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowList,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(name,
                                              style: TextStyle(
                                                  fontFamily: 'gabarito', fontSize: 30)),
                                          Icon(
                                            gender == "female"
                                                ? Icons.female_outlined
                                                : Icons.male_outlined,
                                            size: 20,
                                            color: Colors.black38,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, bottom: 2.0, top: 5),
                                        child: Text(breed,
                                            style: TextStyle(
                                                fontFamily: 'gabarito',
                                                color: Colors.black54)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, bottom: 2.0),
                                        child: Text('$age years old',
                                            style: TextStyle(
                                                fontFamily: 'gabarito',
                                                color: Colors.black38)),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              size: 20, color: Colors.teal),
                                          SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              loc,
                                              style: TextStyle(
                                                fontFamily: 'gabarito',
                                                color: Colors.black38,
                                                fontSize: 13,
                                              ),
                                              softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.black54),
                                    onPressed: () async {
                                      bool confirm = await showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text('Confirm Deletion'),
                                          content: Text('Are you sure you want to delete this pet?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(ctx, false),
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(ctx, true),
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm) {
                                        try {
                                          // Delete from user's mypets
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(widget.currentUserId)
                                              .collection('mypets')
                                              .doc(petDocId)
                                              .delete();

                                          // Delete from global collection
                                          print("Deleting from global collection:");
                                          print("petType: $petType"); // should be 'parrots'
                                          print("petDocId: $petDocId"); // should be 'ErKHG8o3NF17lpYmM4Yy'

                                          if (petType.isNotEmpty) {
                                            await FirebaseFirestore.instance
                                                .collection(petType)
                                                .doc(petDocId)
                                                .delete();
                                          }

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Pet deleted successfully')),
                                          );
                                        } catch (e) {
                                          print('Delete error: $e');
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Failed to delete pet')),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              );
            },
          );
        },
      ),
    );
  }
}
