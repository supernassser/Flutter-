


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/widgets/widgets_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class buildCameraonboardingItem{
  late final String image;
  late final String title;
  late final String body;

  buildCameraonboardingItem({
    required this.image,
    required this.title,
    required this.body,
  });
}
class Camera_Screen extends StatefulWidget {
  @override
  State<Camera_Screen> createState() => _Camera_ScreenState();
}
class _Camera_ScreenState extends State<Camera_Screen> {
  var  boardingCameraController =PageController();

  List<buildCameraonboardingItem> boarding =[
  buildCameraonboardingItem(
      image:  'assets/images/camera_on_bo.png',
      title: 'Use the camera to get enough information',
      body: ' It will help you get the best results related to your workouts faster and easier.'),
  buildCameraonboardingItem(
      image:  'assets/images/scan.png',
      title: 'Use the camera to take pictures of sports equipment',
      body: 'The program will provide you the results that can be practiced on this device.')
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
            ),
            Expanded(
                child:PageView.builder(
                    itemBuilder: (context,index)=>buildWelcomCameraItem(boarding[index]),
                    itemCount:boarding.length ,
                  controller:boardingCameraController ,
                ),),
            //Spacer(),
            SmoothPageIndicator(
                controller:boardingCameraController ,
                count: boarding.length,
                effect:  const  JumpingDotEffect(
                  dotColor: Colors.grey,
                  activeDotColor: defultColor,
                  dotHeight: 12,
                  dotWidth: 11,
                  spacing: 5,
                ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0
              ),
              child: MaterialButton(
                elevation: 9.0,
                color: defultColor,
                height: 50.0,
                minWidth:double.infinity,
                onPressed: (){
                  getImage();
                },
                child: Text('NEXT',
                  style:  TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
            ),


          ],
        ),
      )
    );
  }
}
