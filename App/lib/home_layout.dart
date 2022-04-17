


// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/widgets/data_model.dart';
import 'package:gym_app/navigat_bottom_screen/camera_screen.dart';
import 'package:gym_app/provider/root_provider.dart';
import 'package:gym_app/styles/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'plan/build_my_plan_screen.dart';
import 'plan/home_plan.dart';
import 'navigat_bottom_screen/myplan_screen.dart';
import 'navigat_bottom_screen/home_screen_user.dart';
import 'navigat_bottom_screen/search/welcom_Search.dart';
import 'navigat_bottom_screen/settings_screen.dart';


class Home_LayOut extends StatefulWidget {
  const Home_LayOut({Key? key}) : super(key: key);
  static const String namepage='Home_LayOut';


  @override
  State<Home_LayOut> createState() => _Home_LayOutState();
}

class _Home_LayOutState extends State<Home_LayOut> {

  final auth= FirebaseAuth.instance;
  User?  login;


  @override
  void initState() {
    super.initState();
    getCurrentUser();

  }

  void getCurrentUser() async{
    try{
      final userdetal = await auth.currentUser;
      if (userdetal != null) {
        login = userdetal;
        print(login!.email);
      }
    }
    catch(e){
      print(e);
    }

  }

  int currentIndex=0;
  List<Widget>screens=
  [
    Home_Screen_user(),
    Welcome_Search_Screen(),
    Camera_Screen(),
    Home_plan(),
    Settings_Screen(),
  ];
  File? img;
  final imagePicker=ImagePicker();
  Future getImage()async
  {
    // ignore: deprecated_member_use
    final image= await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      img=File(image!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     // drawer: Navigation_Drawer(),
      // floatingActionButton: FloatingActionButton(
      //   elevation: 0.0,
      //   backgroundColor: defultColor,
      //   onPressed:getImage,
      //   child:  Icon(Icons.camera_alt_outlined,),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar:Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          backgroundBlendMode: BlendMode.clear,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor:Colors.white,
          fixedColor: defultColor,
            type:BottomNavigationBarType.fixed ,
            currentIndex:currentIndex ,
            onTap: (index){
              setState(() {
                currentIndex=index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.home),
                label: 'Home',),
              BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.search),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon:  Icon(Icons.camera_alt_outlined),
                  // ImageWidget(imagepath: 'assets/images/icon.png',
                  // height: 30.0),
                  label: 'Camera'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.table_badge_more),
                  label: 'MyPlan'),
              BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.settings_solid),
                  label: 'Settings'),
            ]),
      ),
      body:screens[currentIndex],
    );
  }
}

