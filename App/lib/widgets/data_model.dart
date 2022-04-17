// ignore_for_file: camel_case_types


import 'package:cloud_firestore/cloud_firestore.dart';

class  datamodel{

  late String image;
  late  String text;
  late String id ;
  datamodel({required this.image, required this.text, required this.id});

  factory datamodel.name(DocumentSnapshot map){
    return datamodel (
        id: map.id,
        image:map['image'] as String,
        text: map["text"] as String,
    );
  }
}


class  detailsmodel{
  late String image;
  late  String details;
  late  String title ;
  late String id  ;
  detailsmodel({required this.image, required this.title,required this.details,required this.id});
  factory detailsmodel.name(DocumentSnapshot Document){
    return detailsmodel (
      id: Document.id  ,
      image:Document['image'] as String,
      title: Document["title"] as String,
      details: Document["detail"] as String,
    );
  }

}






