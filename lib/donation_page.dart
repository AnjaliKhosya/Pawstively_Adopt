import 'package:flutter/material.dart';
import 'package:pet_adoption/menu_page.dart';
class donation_page extends StatefulWidget {
  VoidCallback opendrawer;
  donation_page(this.opendrawer);

  @override
  State<donation_page> createState() => _donation_pageState();
}

class _donation_pageState extends State<donation_page> {
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
          title: Text('Donation',style: TextStyle(color: Colors.black,fontFamily: 'gabarito',fontSize: 24),),

          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}

