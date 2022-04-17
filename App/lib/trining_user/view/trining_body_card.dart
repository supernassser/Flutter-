// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, unnecessary_new

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/widgets/data_model.dart';
import 'package:gym_app/provider/main_provider.dart';
import 'package:gym_app/provider/root_provider.dart';
import 'package:gym_app/trining_user/view/trining_item_card_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';


final picker= ImagePicker();
final firestore = FirebaseFirestore.instance;
TextEditingController title = TextEditingController();
TextEditingController detail = TextEditingController();

late String imageLink ;
String _imge = "https://i.ytimg.com/vi/FgnrC7BIxnE/maxresdefault.jpg" ;
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
  await firestore.collection("WorkOut").doc(_data.id).collection("arm").add({
    "title": title.text,
    "image":imageLink,
    "detail":detail.text,
  }

  ).then((_)async {
  }).catchError((error) => print('Failed: $error'));


}


class MainTreningCardView extends StatelessWidget {

  late datamodel _data;
  MainTreningCardView({Key? key,required datamodel data}){
    _data =data;

  }
  CollectionReference WorkOut = FirebaseFirestore.instance.collection('WorkOut');

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
                    ref.watch(currentItem.state).state = await  _data.id ;
                    ref.watch(backScreenProvider.state).state = ref.watch(currrentScreenProvider.state).state;//arm => List
                    ref.watch(currrentScreenProvider.state).state = CardItemVM() ;

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
          Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(isAdmin.state).state == true ?  Positioned(
                bottom: 10,
                right: 25,
                child:Container(
                  height: 30.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: defultColor)
                            )
                        )
                    ),
                    child:Text ("add data",
                    style: TextStyle(
                      color: Colors.black
                    ),),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              title: const Text('MY DATA'),
                              content:  Column(
                                children: [
                                  SizedBox(
                                      height: 12.0),
                                   Text("add exercise Image",
                                    style: TextStyle(
                                        color: defultColor,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6),
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
                                                WorkOut.doc(_data.id).set({
                                                  "arm":[
                                                    {
                                                      "details":{
                                                        "image":imgFromGallery(context),
                                                        "text":title,
                                                        "details":detail
                                                      },
                                                      "image":_imge,
                                                      "text": title,
                                                    }
                                                  ],
                                                }).then((value) => print("User Added"))
                                                    .catchError((error) => print("Failed to add user: $error"));
                                              },
                                              icon: Icon(Icons.add,color: Color(0xFFC1BDBD)),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Text("add exercise name",
                                    style: TextStyle(
                                        color: defultColor,
                                        fontWeight: FontWeight.bold
                                    )),
                                  SizedBox(height: 12.0),
                                  Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText:'enter data .....',
                                          labelStyle: new TextStyle(
                                            color: const Color(0xFF424242),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                          ),

                                          focusedBorder:OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: defultColor,width: 1),
                                          ),

                                        ),
                                        controller: title,
                                      )),
                                  Text("add details ",
                                    style: TextStyle(
                                        color: defultColor,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText:'enter data .....',
                                          labelStyle: new TextStyle(
                                            color: const Color(0xFF424242),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                          ),

                                          focusedBorder:OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: defultColor,width: 1),
                                          ),

                                        ),
                                    controller: detail,
                                  )),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton.icon(
                                  label:  Text('Add',
                                    style: TextStyle(
                                        color: defultColor,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  onPressed:  ()async
                                  {
                                    dataDetailSend(_data);
                                  },
                                  icon: Icon(Icons.add,
                                  color: defultColor,),
                                ),
                              ],
                            ),

                      );
                    },),
                )): Container(
              height: 0.0,
              width: 0.0,
            );
          },)
        ],
      ),
    );

  }
}


