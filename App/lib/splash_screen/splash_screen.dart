

// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_app/onboarding_screen/on_boarding_screen.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/widgets/widgets_model.dart';
import 'package:lottie/lottie.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);
  static const String namepage='Splash_Screen';

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> with SingleTickerProviderStateMixin{
  late AnimationController  animationController;

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds:8),
            (){
          NavigatorTo(context, On_Boarding());
        });
    animationController=AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 100.0,
    );
    animationController.forward();
    animationController.addListener(() {
      setState(() {
      });
      print(animationController.value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child:Lottie.network('https://assets10.lottiefiles.com/packages/lf20_e96Pi2.json',
                  width: 200.0,
                  height: 300.0),
            ),
            SizedBox(
              height: 60,),
            Text('${animationController.value.toInt()}%',
              // Text('Flash Chat')
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
            CircularProgressIndicator(
              valueColor:AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 5,
              backgroundColor: defultColor,
            ),
          ],
        ),
      ),
    );
  }
}
