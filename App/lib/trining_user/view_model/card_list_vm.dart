// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gym_app/provider/main_provider.dart';
import 'package:gym_app/provider/root_provider.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/styles/fonts.dart';
import 'package:gym_app/trining_user/view/trining_body_card.dart';
import 'package:gym_app/trining_user/view/trining_item_card_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../widgets/data_model.dart';

final picker= ImagePicker();
final firestore = FirebaseFirestore.instance;
TextEditingController title = TextEditingController();
TextEditingController subtitle = TextEditingController();
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
    final downimage = await ref.getDownloadURL() ;
    imageLink = downimage as String ;
    String _image = downimage as String ;
  return _image ;
  } catch (e) {
    print('error occured');
    return " ";
  }
}

sendData()async{
  await firestore.collection("WorkOut")
      .add(
      {'text': title.text,
       'image' : imageLink,
      });
}


class bulidHomeItem_vm extends StatelessWidget {
  const bulidHomeItem_vm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return ref.watch(isAdmin.state).state == true ?
        FloatingActionButton(
          backgroundColor: defultColor,
          onPressed: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title:  Text('MY DATA'),
                      content: Column(
                        children: [
                          SizedBox(
                            height: 12.0),
                           Text("add exercise Image",
                          style: TextStyle(
                            color: defultColor,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(
                            height: 35.0),
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
                                    ),//Image.network(img!),
                                  ),
                                ),
                                Positioned(
                                    bottom:88.0,
                                    right: 2,
                                    child: IconButton(
                                      onPressed: (){
                                        imgFromGallery(context);
                                      },
                                      icon: Icon(Icons.add,
                                        color: Color(0xFFC1BDBD),),
                                    )),
                              ],
                            ),
                          ),
                           Text("add exercise name",
                            style: TextStyle(
                                color: defultColor,
                                fontWeight: FontWeight.bold
                            ),),
                          SizedBox(
                            height: 12.0),
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
                        ],
                      ),
                      actions: <Widget>[
                        TextButton.icon(
                          label: const Text('Add',
                          style: TextStyle(
                            color: defultColor,
                            fontWeight: FontWeight.bold
                          ),),
                          onPressed: ()
                          {
                            sendData();
                          },
                          icon: Icon(Icons.add,
                          color: defultColor,),

                        ),
                      ],
                    ));
          },
          child: const Icon(Icons.add,),
        ) : Container(
          height: 0.0,
          width: 0.0,
        );

      },),
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 12.0,
            ),
            Padding(
              padding:  EdgeInsets.only(
                left: 25.0
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child:Column(
                  children: [
                    SizedBox(
                      height: 13.0,
                    ),
                    Container(
                      child:Text('Choose a',
                        style: TextStyle(
                            fontSize: 26.0,
                            fontFamily: defultFont,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0
                      ),
                      child: Container(
                        child:Text('WorkOut',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: defultFont,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Consumer (
              builder: (
                  BuildContext context, WidgetRef ref, Widget? child) {
                return StreamBuilder<QuerySnapshot>(
                  stream: ref.watch(workoutProvider.stream),
                  builder:
                      (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    return ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        datamodel data = datamodel.name(document);
                        return MainTreningCardView(data: data);
                      }).toList(),
                    );

                  },
                );
              },
            ),
          ],
        ),
      )
    );
  }
}


