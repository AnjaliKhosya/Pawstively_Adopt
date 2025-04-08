import 'package:flutter/material.dart';

class Favorite with ChangeNotifier{
  String? id;
  String? productid;
  String? name;
  String? breed;
  int? age;
  String? distance;
  String? imagepath;
  String? gender;

  Favorite({
    required this.id,
    required this.productid,
    required this.name,
    required this.breed,
    required this.age,
    required this.distance,
    required this.imagepath,
    required this.gender,
  });

  Favorite.fromMap(Map<String,dynamic> res)
  : id = res['id'],
    productid = res['productid'],
    name = res['name'],
    breed = res['breed'],
    age = res['age'],
    distance = res['distance'],
    imagepath = res['imagepath'],
    gender = res['gender'];

  Map<String, Object?> toMap(){
    final Map<String,dynamic> data = <String, dynamic>{};

      data['id']= id;
      data['productid']= productid;
      data['name']= name;
      data['breed']=breed;
      data['age']= age;
      data['distance']= distance;
      data['imagepath']= imagepath;
      data['gender']= gender;
   return data;

  }
}