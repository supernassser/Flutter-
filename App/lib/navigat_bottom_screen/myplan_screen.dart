

// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_new

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/widgets/data_model.dart';
import 'package:gym_app/provider/main_provider.dart';
import 'package:gym_app/provider/root_provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

import '../plan/weeks_screen.dart';


final picker= ImagePicker();
final firestore = FirebaseFirestore.instance;
TextEditingController title = TextEditingController();
TextEditingController detail = TextEditingController();

late String imageLink ;
String _imge = "https://cdn.pixabay.com/photo/2016/03/27/07/08/man-1282232__340.jpg" ;
File? _photo;
final ImagePicker _picker = ImagePicker();

Future<String> imgFromGallery(context) async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    _photo = File(pickedFile.path);
    String x = uploadFile(context) as String;
    return x ;
  } else {
    print('No image selected.');
    return "";
  }
}
Future<String> uploadFile(context) async {
  if (_photo == null) return "";
  final fileName = basename(_photo!.path);
  final destination = 'image/$fileName';
  try {
    final ref = firebase_storage.FirebaseStorage.instance.ref(destination).child('image/');
    var date =  await ref.putFile(_photo!);
    final x = await ref.getDownloadURL() ;
    imageLink = x as String ;
    String _image = x as String ;
    return _image ;
  } catch (e) {
    print('error occured');
    return " ";
  }
}

dataDetailSend( var _data)async{
  await firestore.collection("MyPlan").doc(_data.id).collection("days").add({
    "title": title.text,
    "image":imageLink,
    "detail":detail.text,
  }

  ).then((_)async {
  }).catchError((error) => print('Failed: $error'));


}


class MyPlan_Screen extends StatelessWidget {

  late datamodel _data;
  late String _docId ;
  MyPlan_Screen({Key? key,required datamodel data,required String documentId ,required WidgetRef ref}){
    _data =data;
    _docId=documentId ;
  }
  CollectionReference MyPlan = FirebaseFirestore.instance.collection('MyPlan');

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left:20.0,
              right: 20.0,
            ),
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return  GestureDetector(
                  onTap:() async{
                    ref.watch(currrentPlanIdProvider.state).state =   _docId ;
                    ref.watch(currenplantItem.state).state =   _docId ;
                    ref.watch(backPlanScreenProvider.state).state = ref.watch(currrentPlanScreenProvider.state).state;//days => List
                    ref.watch(currrentPlanScreenProvider.state).state = WeeksVM() ;

                  },
                  child: Container(
                    height: 150.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      image:new DecorationImage(
                        image: NetworkImage(_data.image),
                        fit:BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                width: 300,
                padding: EdgeInsets.all(8),
                child: Text( "${_data.text}",
                  style: TextStyle(
                      fontSize: 20,
                      color:Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(isAdmin.state).state == true ?  Positioned(
                bottom: 5,
                right: 5,
                child:TextButton(
                  child:Text ("add data"),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title: const Text('AlertDialog Title'),
                            content:  Column(
                              children: [
                                const Text("add trining Image"),
                                SizedBox(height: 6,),
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 150.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0),
                                            bottomRight: Radius.circular(20.0),
                                          ),
                                          image:DecorationImage(
                                            image: NetworkImage(_imge),
                                            fit:BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 2,
                                          right: 2,
                                          child: IconButton(
                                            onPressed: (){
                                              MyPlan.doc(_data.id).set({
                                                "days":[
                                                  {
                                                    "details": {
                                                      "image":imgFromGallery(context),
                                                      "text":title,
                                                      "details":detail
                                                    },
                                                    "image":_imge,
                                                    "text": title
                                                  }
                                                ],
                                              }).then((value) => print("User Added"))
                                                  .catchError((error) => print("Failed to add user: $error"));
                                            },
                                            icon: Icon(Icons.add,color: Colors.red,),
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 6,),
                                Text("add Category name"),
                                SizedBox(height: 6,),
                                Expanded(
                                    child: TextFormField(
                                      controller: title,
                                    )),
                                Text("add details "),
                                Expanded(child: TextFormField(
                                  controller: detail,
                                )),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton.icon(
                                label: const Text('Add'),
                                onPressed:  ()async
                                {
                                  dataDetailSend(_data);
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),

                    );
                  },)): Container(
              height: 0.0,
              width: 0.0,
            );
          },)
        ],
      ),
    );

  }
}


