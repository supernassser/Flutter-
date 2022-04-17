import 'package:flutter/material.dart';
import 'package:gym_app/navigat_bottom_screen/camera_screen.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/styles/fonts.dart';

import '../onboarding_screen/on_boarding_screen.dart';


Widget BuildBoardingItem(
    BoardingModel model)=> Column(
  children:
  [
    Expanded(
      child: Image(
        // ignore: unnecessary_string_interpolations
        image: AssetImage('${model.image}'),
      ),
    ),
    Container(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          SizedBox(
            height: 11.0,
          ),
          Text('${model.title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
                fontFamily:defultFont,
            ),),
          SizedBox(
            height: 50.0,
          ),
          Text('${model.body}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 19,
                fontFamily:defultFont,
            ),),


        ],
      ),


    ),
  ],
);


Widget ButtonWidget({
  double width=double.infinity,
  double height=44.0,
  required Color backgroung,
  required VoidCallback fun,
  String? Function(String?)? onChanged ,
  required String text,
  required Color colortext,

})=>  Container(
  child: MaterialButton(
    minWidth: width,
    height:  height=50,
    color: backgroung,
    onPressed:fun,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0)),
    child: Text(text,
      style:  TextStyle(
        fontSize: 18.0,
        color: colortext,
        fontWeight: FontWeight.bold,
      ),),


  ),
);


Widget ImageWidget({
  required String imagepath,
  double? height,
  double? width,

})=>
Container(
  height: height,
width: width,
child: Image.asset(imagepath,
 ),
);

Widget FieldWidget({
  TextEditingController? controller,
  required TextInputType  type,
  String? hintText,
  required String labelText,
  required IconData iconData,
  required String? Function(String?)? validate,
  String? Function(String?)? onChanged ,
  VoidCallback? onTap ,
  IconData? suffixIcon,
  VoidCallback? onPressedfun,
  bool obscureText = false,


})=> Container(
  child:TextFormField(
    controller:controller,
    keyboardType:type,
    onTap:onTap ,
    onChanged: (String value){
      print(value);
    },
    onFieldSubmitted: (String value){
      print(value);
    },
    validator: validate,
    obscureText:obscureText,
    cursorColor: defultColor,
    style: TextStyle(
        color: defultColor),
    decoration: InputDecoration(
        hintText:hintText,
        labelText:labelText,
        labelStyle: new TextStyle(
          color: const Color(0xFF424242),
          fontWeight: FontWeight.bold,
          fontSize: 13.0,
        ),

        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(23.0),
          borderSide:
          BorderSide(
              color: defultColor,width: 1),
        ),
        prefixIcon: Icon(
          iconData,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          onPressed:onPressedfun,
          icon: Icon(
            suffixIcon,
            color: Colors.grey,
          ),
        )
    ),
  ),
);

Widget accountLine({
  required VoidCallback? onPressed,
  required String textone,
  required String texttwo,
  required Color colortext,
})=> Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(textone),
      TextButton(
          onPressed:onPressed,
          child:Text(texttwo,
            style: TextStyle(
                color:colortext,
            ),))

    ],
  ),
);



void  NavigatorTo(context,widght)=> Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context)=>  widght,
    )
);


void NavigatorAndFinish(context,widght)=>Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(
    builder:(context)=>widght ),
        (route) => false);

Widget defultTextButton(
{
  required VoidCallback onPressedfun,
  required String text,
  Color? color,
  String? FontFamily,
  FontWeight? FontWeight,
  double? FontSize
}
    )=>
    TextButton(
  onPressed:onPressedfun,
  child: Text(text,
    style: TextStyle(
      color:color,
      fontFamily: FontFamily,
      fontSize: FontSize,
      fontWeight: FontWeight,
    ),),
);

Widget buildStoryItem({
  required Color color,
}
    )=>Container(
  height: 200.0,
  width: 316,

  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(22.0),
    color: color,
  ),

);



Widget buildWelcomItem({
  required String image,
  required String title,
  required String body,
})=>
    Container(
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(38.0),
        child: Image.asset(image),
      ),
      SizedBox(
          height: 15.0
      ),
      Text(title,
        style: TextStyle(
          fontFamily:defultFont,
          fontSize: 18.0,
          fontWeight:FontWeight.bold,
        ),),
      SizedBox(
          height: 13.0
      ),
      Text(body,
        style: TextStyle(
          fontFamily:defultFont,
          color: Colors.grey,
          fontSize: 15.0,
        ),),
    ],
  ),
);

Widget buildWelcomCameraItem(buildCameraonboardingItem model)=>
    Container(
      child: Column(
        children: [
          Image.asset('${model.image}'),
          SizedBox(
              height: 15.0
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Text('${model.title}',
                    style: TextStyle(
                      fontFamily:defultFont,
                      fontSize: 18.0,
                      fontWeight:FontWeight.bold,
                    ),),
                  SizedBox(
                      height: 13.0
                  ),
                  Text('${model.body}',
                    style: TextStyle(
                      fontFamily:defultFont,
                      color: Colors.grey,
                      fontSize: 15.0,
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );








