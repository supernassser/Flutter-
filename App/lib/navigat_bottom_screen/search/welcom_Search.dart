
import 'package:flutter/material.dart';
import 'package:gym_app/navigat_bottom_screen/search/search_screen.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/widgets/widgets_model.dart';

class Welcome_Search_Screen extends StatelessWidget {
  const Welcome_Search_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
    buildWelcomItem(
    image: 'assets/images/search.png',
    title: 'Get a suitable option for your exercise',
    body: 'It will help you to get the best results related to your training and exercise.'),
            Spacer(),
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
                   NavigatorTo(context, Search_Screen());
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
      ),
    );
  }
}
