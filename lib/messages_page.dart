import 'package:flutter/material.dart';
class message_page extends StatefulWidget {
  VoidCallback opendrawer;
  message_page(this.opendrawer);

  @override
  State<message_page> createState() => _message_pageState();
}

class _message_pageState extends State<message_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          setState(() {
            widget.opendrawer();
          });
        },),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
    );
  }
}
