import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'configuration.dart';
import 'detail_page.dart';
class adoption extends StatefulWidget {
  VoidCallback opendrawer;
  String current_loc;
  adoption(this.opendrawer,this.current_loc);
  @override
  State<adoption> createState() => _adoptionState();
}

class _adoptionState extends State<adoption> {

  String selected="";
  String itemType="";
  final auth = FirebaseAuth.instance;
  late var firestore;
  //***************Handle selection**********************
  void handle(String selectedCategory)
  {
    if(selectedCategory=="Cats")
      itemType = "cats";
    else if(selectedCategory=="Dogs")
      itemType = "dogs";
    else if(selectedCategory=="Bunnies")
      itemType = "rabbits";
    else if(selectedCategory=="Parrots")
      itemType = "parrots";
    else if(selectedCategory=="Horses")
      itemType = "horses";
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) =>Scaffold(
          //*********************Starting***************************
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //**************page appBar********************
                Container(height: 50,color: Colors.white,),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                      [
                        IconButton(onPressed: ()
                        {
                          setState(() {
                            widget.opendrawer();
                          });
                        }, icon: Icon(Icons.menu)),
                        Column(
                          children:
                          [
                            Text('Location',style: TextStyle(color: Colors.black45,fontSize: 15,),),
                            Row(
                              children:
                              [
                                Icon(Icons.location_on_sharp,color: Colors.teal[800],),
                                Text(widget.current_loc,style: TextStyle(fontSize: 15,fontFamily: 'gabarito'),),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.brown.shade100,
                            child: Image.asset('assets/images/profile.png',color: Colors.black87,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //*****************Text field*****************************
               /* Container(

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)),

                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0,left: 8.0,right: 8.0),
                    child: Container(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(width: 1,color: Colors.black)
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1,color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Search pet to adopt',
                          hintStyle: TextStyle(color: Colors.black38),
                          prefixIcon: Icon(Icons.search,color: Colors.black54,),
                        ),
                        cursorColor: Colors.black,
                        cursorHeight: 20,
                        autocorrect: true,

                      ),
                    ),
                  ),
                ),*/

                //********************** selection of pet ***********************
                Padding(
                  padding: const EdgeInsets.only(left:8.0,right: 8.0,top:10.0),
                  child: Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Categories.length,
                      itemBuilder: (context,index){
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: (){
                                  if(tapped.contains(true))
                                  {
                                    int ind = tapped.indexOf(true);
                                    tapped[ind] = false;
                                    tapped[index] = true;
                                  }
                                  else
                                  {
                                    tapped[index] = true;
                                  }
                                  selected = Categories[index]['name'].toString();
                                  setState(() {
                                    handle(selected);
                                  });
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(Categories[index]['iconPath'],width: 50,height: 50,),
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: tapped[index]?shadowlist1:shadowList,
                                    color: tapped[index]?Colors.teal[300]:Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),

                                ),
                              ),
                            ),
                            Text(Categories[index]['name'],style: TextStyle(color: Colors.black54,fontSize: 17,fontFamily: ' gabarito',fontWeight: FontWeight.w200),),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                //*******************List of pets**********************
                if(itemType!="")
                customcode(itemType,widget.current_loc),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//*************** Custom Code of list of pet***************************
class customcode extends StatelessWidget {
  String itemType;
  String user_loc;
  customcode(this.itemType,this.user_loc);
  var color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(itemType).snapshots(),
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

                  // Use the null-aware operator to safely access the 'name' property
                  String name = documentData?['Name'] ?? 'N/A';
                  String gender = documentData?['Gender'] ?? 'N/A';
                  String breed = documentData?['Breed'] ?? 'N/A';
                  String age = documentData?['Age'] ?? 'N/A';
                  String imageurl = documentData?['image'] ?? 'N/A';
                  String loc = documentData?['loc'] ?? 'N/A';
                  String resn = documentData?['resn'] ?? 'N/A';
                  String ownername = documentData?['Owner name']?? 'N/A';
                  String height = documentData?['height']??'N/A';
                  String weight = documentData?['weight']??'N/A';
                  String price = documentData?['price']??'N/A';
                  String contact_no = documentData?['contact_no']??'N/A';
                  // Return a widget based on the data
                  return GestureDetector(
                    onTap: ()async{
                      if(index%2==0)
                        color = Colors.blueGrey[300];
                      else
                        color = Colors.amber[200];
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>detail_page(name,ownername,resn,breed,age,imageurl,gender,color,loc,height,weight,price,contact_no)));

                    },
                    child: Hero(
                      tag: 'drag',
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
                                          width: 130,
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
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(name,style: TextStyle(fontFamily: 'gabarito',fontSize: 30),),
                                          Icon(gender=="female"?Icons.female_outlined:Icons.male_outlined,size: 20,color: Colors.black38,)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0,bottom: 2.0),
                                      child: Text(breed,style: TextStyle(fontFamily: 'gabarito',color: Colors.black54),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0,bottom: 2.0),
                                      child: Text('$age years old',style: TextStyle(fontFamily: 'gabarito',color: Colors.black38),),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on,size: 20,color: Colors.teal,),
                                        Expanded(
                                          child: Container(
                                              width: 120,
                                              child: Text(loc,style:  TextStyle(fontFamily: 'gabarito',color: Colors.black38,fontSize: 13),)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
         )
         ),
     );

  }
}

String generateUnqueId()
{
  DateTime now = DateTime.now();
  String timestamp = now.microsecondsSinceEpoch.toString();
  return "pet_$timestamp";
}






