import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

bool ispressed = false;
Color PrimaryGreen = Colors.teal;
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey.shade300,blurRadius: 20,offset:Offset(0,10))
];

List<BoxShadow> shadowlist1 = [
  BoxShadow(color: Colors.teal.shade100,blurRadius: 20,offset:Offset(0,10))
];

List<Map> menu = [
  {'icon': FontAwesomeIcons.paw,'title':'Adoption'},
  {'icon': FontAwesomeIcons.add,'title':'Add Pet'},
  {'icon': Icons.favorite,'title':'Favorites'},
  {'icon': FontAwesomeIcons.message,'title':'Messages'},
  {'icon':Icons.settings,'title':'Settings'},
];
List<Map> Categories = [
  {'name': 'Cats', 'iconPath': 'assets/images/Cat.png',},
  {'name': 'Dogs', 'iconPath': 'assets/images/dog.png',},
  {'name': 'Bunnies', 'iconPath': 'assets/images/rabbit.png',},
  {'name': 'Parrots', 'iconPath': 'assets/images/parrot.png',},
  {'name': 'Horses', 'iconPath': 'assets/images/horse.png',},
];

List<Map> cats =[
  {'name':'Sola','breed':'Breed1','Distance':'Distance: kms','age':'Age1','imagepath':'assets/images/cat1.png','gender':'male'},
  {'name':'Dola','breed':'Breed2','Distance':'Distance: kms','age':'Age2','imagepath':'assets/images/cat2.png','gender':'female'},
  {'name':'Puggu','breed':'Breed3','Distance':'Distance: kms','age':'Age3','imagepath':'assets/images/cat4.png','gender':'male'},
];

List<Map> dogs = [
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/dog1.png'},
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/dog2.png'},
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/dog2.png'},
];

List<Map> horses = [
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/horse1.png'},
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/horse2.png'},
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/horse3.png'},
];

List<Map> bunnies = [
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/rabbit1.png'},
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/rabbit2.png'},
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/rabbit3.png'},
];

List<Map> parrots = [
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/parrot1.png'},
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/parrot2.png'},
  {'name':'Dugu','breed':'Breed','Distance':'Distance: kms','age':'Age','imagepath':'assets/images/parrot3.png'},
];

List<bool> isTap =[
  false,false,false,false,false,false
];

List<bool> tapped = [
  false,false,false,false,false,
];