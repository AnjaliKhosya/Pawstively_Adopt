import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'configuration.dart';
import 'detail_page.dart';

class favorite_page extends StatefulWidget {
  VoidCallback opendrawer;
  favorite_page(this.opendrawer);

  @override
  State<favorite_page> createState() => _favorite_pageState();
}

class _favorite_pageState extends State<favorite_page> {

  var color;
  DocumentReference? doc;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            setState(() {
              widget.opendrawer();
            });
          },),
        ),
        body: Container(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("favorites").snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot>snapshot) {
                  if (snapshot.hasError) {
                    // If there's an error with the stream, handle it here
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // If the stream has emitted data, you can work with it
                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    // You can now use 'documents' to build your UI or perform other operations
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context,index)
                      {
                        // Access data from each document using 'documents[index].data()'
                        Map<String, dynamic>? documentData = documents[index].data() as Map<String, dynamic>?;
                        bool isfavorite = true;
                        // Use the null-aware operator to safely access the 'name' property
                        String name = documentData?['Name'] ?? 'N/A';
                        String gender = documentData?['Gender'] ?? 'N/A';
                        String breed = documentData?['Breed'] ?? 'N/A';
                        String age = documentData?['Age'] ?? 'N/A';
                        String imageurl = documentData?['imagurl'] ?? 'N/A';
                        String loc = documentData?['loc'] ?? 'N/A';
                        String resn = documentData?['resn'] ?? 'N/A';
                        String ownername = documentData?['Owner name']?? 'N/A';
                        String doc_id = documents[index].id;
                        String height = documentData?['height']??'N/A';
                        String weight = documentData?['weight']??'N/A';
                        String price = documentData?['price']??'N/A';
                        String contact_no = documentData?['contact_no']??'N/A';
                        // Return a widget based on the data
                        return GestureDetector(
                          onTap: (){
                            if(index%2==0)
                              color = Colors.blueGrey[300];
                            else
                              color = Colors.amber[200];
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>detail_page(name,ownername,resn,breed,age,imageurl,gender,color,loc,height,weight,price,contact_no)));
                          },
                          child: Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            height: 220,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: shadowList,
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: (index%2==0)? Colors.blueGrey[300]: Colors.amber[200],

                                        ),

                                        margin: EdgeInsets.only(top: 40.0),
                                      ),
                                      Align(
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Container(
                                              height: 160,
                                              child: imageurl!=null?Image.network(imageurl):Container()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container(
                                  margin: EdgeInsets.only(top: 60,bottom: 25.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: shadowList,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 1.0,left: 14.0,right: 5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(name,style: TextStyle(fontFamily: 'gabarito',fontSize: 25),),
                                             IconButton(onPressed: ()async{
                                                isfavorite = false;
                                                DocumentReference _documentReference = FirebaseFirestore.instance.collection("favorites").doc(doc_id);
                                                await _documentReference.delete();

                                             }, icon: Icon(
                                               isfavorite?Icons.favorite:Icons.favorite_border_sharp,
                                               color: isfavorite? Colors.red[400]:Colors.white,
                                             ),
                                             ),
                                            ]
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0,bottom: 2.0),
                                          child: Text(breed,style: TextStyle(fontFamily: 'gabarito',color: Colors.black54),),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0,bottom: 4.0),
                                          child: Text('$age years old',style: TextStyle(fontFamily: 'gabarito',color: Colors.black38),),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.location_on,size: 20,color: Colors.teal,),
                                            Container(
                                              width: 120,
                                                child: Text('${loc} km',style:  TextStyle(fontFamily: 'gabarito',color: Colors.black26),))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
            )
        ),
      ),
    );
  }
}
