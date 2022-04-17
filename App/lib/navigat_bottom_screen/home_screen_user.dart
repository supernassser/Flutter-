

// ignore_for_file: prefer_const_constructors

import 'package:gym_app/widgets/data_model.dart';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_app/chat_screen/chat_screen.dart';
import 'package:gym_app/provider/root_provider.dart';
import 'package:gym_app/styles/fonts.dart';
import 'package:gym_app/trining_user/view_model/card_list_vm.dart';
import 'package:gym_app/widgets/widgets_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Home_Screen_user extends StatefulWidget {
   Home_Screen_user({Key? key,}) {}

  static const String namepage='Home_Screen';

  @override
  State<Home_Screen_user> createState() => _Home_Screen_userState();
}

class _Home_Screen_userState extends State<Home_Screen_user> {
  var searchController= TextEditingController();
  List Home_Data  =[];
  late var data;

  CollectionReference data_home= FirebaseFirestore
       .instance.collection('WorkOut');

   getData() async {
     var responsebody= await data_home.get();
     responsebody.docs.forEach((element) {
       setState(() {
         Home_Data.add(element.data());
       });
     });
   }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return   IconButton(icon:ref.watch(backScreenProvider.state).state == ref.watch(currrentScreenProvider.state).state  ?
          Icon( Icons.refresh) : Icon( Icons.arrow_back)
            ,onPressed: (){
              ref.watch(backScreenProvider.state).state == ref.watch(currrentScreenProvider.state)
                  .state?ref.watch(backScreenProvider.state).state =  bulidHomeItem_vm():
              ref.watch(currrentScreenProvider.state).state =  ref.watch(backScreenProvider.state).state;
          },);
        },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Fitness Now!!',
          style: TextStyle(
              color: Colors.grey,
              fontFamily: defultFont,
              fontWeight: FontWeight.bold,
              fontSize: 22.0),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: MaterialButton(
              onPressed: ()
              {
                NavigatorTo(context, Chat_Screen());
              },
              child: Image.asset('assets/images/message.png',
                height: 35.0,
                width: 50.0,
              ),

            ),

          ),
        ],
      ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
          ),
          child:Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(currrentScreenProvider.state).state;
          },),
        ),
    );
  }
}
