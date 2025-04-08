import 'package:flutter/material.dart';
class settings_page extends StatefulWidget {
  VoidCallback opendrawer;
  settings_page(this.opendrawer);

  @override
  State<settings_page> createState() => _settings_pageState();
}

class _settings_pageState extends State<settings_page> {
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
          title: Text('Settings',style: TextStyle(color: Colors.black,fontFamily: 'gabarito',fontSize: 24),),

          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.green,
        ),
      ),
    );
  }
}
