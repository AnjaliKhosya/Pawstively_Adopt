import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Configuration.dart';
import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  final VoidCallback opendrawer;
  final String? uid;

  FavoritePage(this.opendrawer, this.uid);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.uid == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.opendrawer,
          ),
        ),
        body: const Center(child: Text('User ID is missing.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.opendrawer,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.uid)
            .collection("favorites")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No favorites yet.'));
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final data = documents[index].data()! as Map<String, dynamic>;

              final name = data['name'] ?? 'N/A';
              final gender = data['gender'] ?? 'N/A';
              final breed = data['breed'] ?? 'N/A';
              final age = data['age'] ?? 'N/A';
              final imageurl = data['imagepath'] ?? '';
              final loc = data['loc'] ?? 'N/A';
              final resn = data['resn'] ?? 'N/A';
              final ownername = data['ownername'] ?? 'N/A';
              final height = data['height'] ?? 'N/A';
              final weight = data['weight']?.toString() ?? 'N/A';
              final price = data['price'] ?? 'N/A';
              final contact_no = data['contact_no'] ?? 'N/A';
              final petType = data['petType'] ?? 'unknown';
              final petId = data['petId'] ?? '';

              final cardColor =
              (index % 2 == 0) ? Colors.blueGrey[300]! : Colors.amber[200]!;

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
                        cardColor,
                        loc,
                        height,
                        weight,
                        price,
                        contact_no,
                        widget.uid!,
                        petId
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'drag',
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                  color: cardColor,
                                ),
                                margin: const EdgeInsets.only(top: 40.0),
                              ),
                              Align(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    height: 160,
                                    width: 130,
                                    child: imageurl.isNotEmpty
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
                            margin: const EdgeInsets.only(top: 60, bottom: 25.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowList,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                          fontFamily: 'gabarito',
                                          fontSize: 30,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          final confirm = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Remove Favorite?'),
                                              content: const Text(
                                                  'Are you sure you want to remove this pet from favorites?'),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Cancel'),
                                                  onPressed: () =>
                                                      Navigator.of(context).pop(false),
                                                ),
                                                TextButton(
                                                  child: const Text('Remove'),
                                                  onPressed: () =>
                                                      Navigator.of(context).pop(true),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (confirm == true) {
                                            // Delete from user's favorites
                                            await FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(widget.uid)
                                                .collection("favorites")
                                                .doc(documents[index].id)
                                                .delete();

                                            // Set isfavorite = false globally
                                            if (petType != 'unknown' && petId.isNotEmpty) {
                                              await FirebaseFirestore.instance
                                                  .collection(petType)
                                                  .doc(petId)
                                                  .update({'isfavorite': false});
                                            }
                                          }
                                        },
                                        icon: Icon(Icons.favorite, color: Colors.red[400]),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 5.0, bottom: 2.0),
                                    child: Text(
                                      breed,
                                      style: const TextStyle(
                                          fontFamily: 'gabarito', color: Colors.black54),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 5.0, bottom: 2.0),
                                    child: Text(
                                      '$age years old',
                                      style: const TextStyle(
                                          fontFamily: 'gabarito', color: Colors.black38),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          size: 20, color: Colors.teal),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          loc,
                                          style: const TextStyle(
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
                                  )
                                ],
                              ),
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
