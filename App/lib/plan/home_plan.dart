
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/provider/root_provider.dart';
import 'package:gym_app/styles/fonts.dart';

import 'build_my_plan_screen.dart';

class Home_plan extends StatefulWidget {
  const Home_plan(
      {Key? key});
  static const String namepage='Home_Plan_Screen';

  @override
  State<Home_plan> createState() => _Home_planState();
}

class _Home_planState extends State<Home_plan> {

  List Plan_Data  =[];
  late var data;

  CollectionReference data_home= FirebaseFirestore
      .instance.collection('MyPlan');

  getData() async {
    var responsebody= await data_home.get();
    responsebody.docs.forEach((element) {
      setState(() {
        Plan_Data.add(element.data());
      });
    });
    print(Plan_Data);
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
          return   IconButton(icon:ref.watch(backPlanScreenProvider.state).state == ref.watch(currrentPlanScreenProvider.state).state  ?
          Icon( Icons.refresh) : Icon( Icons.arrow_back)
            ,onPressed: (){
              ref.watch(backPlanScreenProvider.state).state == ref.watch(currrentPlanScreenProvider.state)
                  .state?ref.watch(backPlanScreenProvider.state).state =  bulidPlanItem_vm():
              ref.watch(currrentPlanScreenProvider.state).state =  ref.watch(backPlanScreenProvider.state).state;
            },);
        },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        // title: Text('Fitness Now!!',
        //   style: TextStyle(
        //       color: Colors.grey,
        //       fontFamily: defultFont,
        //       fontWeight: FontWeight.bold,
        //       fontSize: 22.0),),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(top:12.0),
        //     child: MaterialButton(
        //       onPressed: ()
        //       {
        //         NavigatorTo(context, Chat_Screen());
        //       },
        //       child: Image.asset('assets/images/message.png',
        //         height: 35.0,
        //         width: 50.0,
        //       ),
        //
        //     ),
        //
        //   ),
      //  ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
        ),
        child:Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return ref.watch(currrentPlanScreenProvider.state).state;
        },),
      ),
    );
  }
}
