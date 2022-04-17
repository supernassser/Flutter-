// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/data_view.dart';
import 'package:gym_app/provider/main_provider.dart';
import 'package:gym_app/provider/root_provider.dart';
import 'package:gym_app/widgets/data_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/styles/fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';




import 'build_my_plan_screen.dart';


final picker= ImagePicker();
final firestore = FirebaseFirestore.instance;
TextEditingController titleController = TextEditingController();
TextEditingController detailController = TextEditingController();

late String imageLink ;
String _imgetask = "https://cdn.pixabay.com/photo/2016/03/27/07/08/man-1282232__340.jpg" ;
File? _photo;
final ImagePicker _picker = ImagePicker();

class WeeksVM extends StatelessWidget {

   WeeksVM({Key? key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'MyPlan for',
                  style: TextStyle(
                      color: defultColor,
                      fontFamily: defultFont,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  ' The Week',
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
            Consumer(
              builder: (
                  BuildContext context, WidgetRef ref, Widget? child) {
                return StreamBuilder<QuerySnapshot>(
                    stream:  ref.watch(ItemsMyPlanProvider.stream),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('=======================Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: snapshot.data!.docs.map((
                            DocumentSnapshot document) {
                          detailsmodel data = detailsmodel.name(document);
                          return ItemWeeksView(data: data,);
                        }).toList(),

                      );
                    }
                );
              },

            ),
          ],
        )
      ),
    );
  }

}


sendData()async{
  await firestore.collection("MyPlan")
      .add(
      {'text': title.text,
        'image' : imageLink,
      });
}

class ItemWeeksView extends StatelessWidget {

  late detailsmodel _data;

  ItemWeeksView({Key? key,required detailsmodel data}){
    _data =data ;

  }

  CollectionReference MyPlan = FirebaseFirestore.instance.collection('MyPlan');

  @override
  Widget build(BuildContext context) {
    return Stack(
       children: [
         Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
           return Padding(
             padding: const EdgeInsets.all(9.0),
             child: GestureDetector(
               onTap: () {
                ref.watch(backPlanScreenProvider.state).state = ref.watch(currrentPlanScreenProvider.state).state;//week => List
                 //ref.watch(currrentPlanScreenProvider.state).state = Home_Screen_user();
               },
               child: Padding(
                 padding: const EdgeInsets.only(
                   left: 10.0,
                   right: 10.0,
                 ),
                 child: Container(
                   color: Colors.black12,
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: ListTile(
                       leading: Container(
                         height: 60.0,
                         width: 60.0,
                         child: CircleAvatar(
                           backgroundColor: Colors.white,
                           radius: 50.0,
                           backgroundImage:NetworkImage(_data.image),
                         ),
                       ),
                       title: Text(_data.title,
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                         style: const TextStyle(
                           fontSize: 15.0,
                           fontWeight: FontWeight.bold,
                         ),
                       ) ,
                       subtitle:Text(_data.details,
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                         style: const TextStyle(
                           fontSize: 15.0,
                           fontWeight: FontWeight.bold,
                         ),
                       ) ,
                       trailing:Icon(
                         Icons.arrow_forward_ios_outlined,
                         size: 22.0,
                       ) ,
                     ),
                   ),
                 ),
               ),
             ),

           );
         },

         ),
         Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
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
                           title: const Text('days_dataTitle'),
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
                                           image: NetworkImage(_imgetask),
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

                               SizedBox(height: 6,),
                               Text("add Category name"),
                               SizedBox(height: 6,),
                               Expanded(
                                   child: TextFormField(
                                     controller: titleController,
                                   )),
                               Text("add details "),
                               Expanded(child: TextFormField(
                                 controller: detailController,
                               )),
                             ],
                           ),
                           actions: <Widget>[
                             TextButton.icon(
                               label: const Text('Add tasks'),
                               onPressed:  ()async
                               {

                                 // MyPlan.doc(ref.watch(currenplantItem.state).state).
                                 // collection('days').doc(_data.id).set({"tasks":[
                                 //
                                 //
                                 // ]}) ;
                                 //
                                 //   MyPlan.doc(ref.watch(currrentPlanIdProvider.state).state).
                                 //   collection('days').doc(_data.id).({
                                 //     "tasks":  {
                                 //       "details" : detailController.text ,
                                 //       "image": _imgetask,
                                 //       "text": titleController.text,
                                 //     }
                                 //
                                 //   }).then((value) => print("User Added"))
                                 //       .catchError((error) => print("Failed to add user: $error"));

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
    );
  }
}


List updateDataList({required List oldData ,required Map item}){
  List newList =  oldData;
  newList.add(item);
  return newList  ;


}