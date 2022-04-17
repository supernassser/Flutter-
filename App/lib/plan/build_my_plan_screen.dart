// ignore_for_file: prefer_const_constructors

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
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../widgets/data_model.dart';
import '../navigat_bottom_screen/myplan_screen.dart';

final picker= ImagePicker();
final firestore = FirebaseFirestore.instance;
TextEditingController title = TextEditingController();
TextEditingController subtitle = TextEditingController();
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


sendData()async{
  await firestore.collection("MyPlan")
      .add(
      {'text': title.text,
        'image' : imageLink,
      });
}


class bulidPlanItem_vm extends StatelessWidget {
  const bulidPlanItem_vm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(isAdmin.state).state == true ?
            FloatingActionButton(
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text('AlertDialog Title'),
                          content:  Column(
                            children: [
                              const Text("add Category Image"),
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
                                        ),//Image.network(img!),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 2,
                                        right: 2,
                                        child: IconButton(
                                          onPressed: (){
                                            imgFromGallery(context);
                                          },
                                          icon: Icon(Icons.add,color: Colors.red,),
                                        )),
                                  ],
                                ),
                              ),
                              const Text("add Category name"),
                              SizedBox(height: 6,),
                              Expanded(child: TextFormField(
                                controller: title,
                              )),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton.icon(
                              label: const Text('Add'),
                              onPressed: ()
                              {
                                sendData();
                              },
                              icon: Icon(Icons.add),

                            ),
                          ],
                        ));
              },
              child: const Icon(Icons.add),
            ) : Container(
              height: 0.0,
              width: 0.0,
            );

          },),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'MyPlan',
                    style: TextStyle(
                        color: defultColor,
                        fontFamily: defultFont,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Consumer (
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: ref.watch(MyPlanProvider.stream),
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
                          return MyPlan_Screen(data: data,documentId:document.id,ref: ref,);
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
