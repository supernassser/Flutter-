
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/styles/fonts.dart';
import 'package:gym_app/users_information/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/widgets_model.dart';

class BoardingModel{
   late final String image;
   late final String title;
   late final String body;

   BoardingModel({
     required this.image,
     required this.title,
     required this.body,
});
}
class On_Boarding extends StatefulWidget {
  static const String namepage='On_Boarding';

  @override
  State<On_Boarding> createState() => _On_BoardingState();
}

class _On_BoardingState extends State<On_Boarding> {

  var  boardingController =PageController();

List<BoardingModel> boarding=
[
  BoardingModel(
    image: 'assets/images/image1.jpg',
    title: 'Workout Anywhere',
    body: 'Workout at home,outside or in a gym without any trainer.',
  ),
  BoardingModel(
    image: 'assets/images/image7.jpg',
    title: 'Stay strong & Healthy ',
    body: 'We want you to stay strong and healthy, so we have provided you information sports equipment.'
        '                 Enjoy!!',
  ),
  BoardingModel(
    image: 'assets/images/image3.png',
    title: ' Energize Your Life!',
    body: 'Don\'t miss the fitness!!',
  ),

];
 bool isLast=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          defultTextButton(
          onPressedfun:(){
            NavigatorAndFinish(context, Login_Screen());
    },
      text:'SKIP',
      color: defultColor,
      FontFamily: defultFont,
      FontWeight: FontWeight.bold,
    ),

        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  controller: boardingController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (int index){
                    if(index == boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                    }
                    else{
                      setState(() {
                        isLast=false;
                      });
                    }
                  },
                  itemBuilder: (context,index)=>BuildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                )
            ),
            SizedBox(
              height:40.0 ,
            ),
            Row(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    effect:  const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defultColor,
                      expansionFactor: 4,
                      dotHeight: 11,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed:()
                  {
                    if(isLast){
                      NavigatorAndFinish(context, Login_Screen());
                    }
                    else
                      {
                      boardingController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.easeInOutCirc
                      );
                    }

                  },
                  backgroundColor: defultColor,
                  child: const Icon(Icons.arrow_forward_ios,
                  ),

                ),

              ],
            )


          ],
        ),
      )
    );
  }

}
