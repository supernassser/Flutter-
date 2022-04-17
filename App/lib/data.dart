
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/styles/fonts.dart';
import 'package:gym_app/test.dart';
import 'package:gym_app/widgets/widgets_model.dart';

class Data_days extends StatelessWidget {
  const Data_days({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          expandedHeight: 220.0,
          pinned: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: const Text("Days",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: defultFont,
                )),

          ),
        ),
      ];
    },
    body:ListView(
      children: [
        Container(
          color: Color(0xffebecf0),
          height: 60.0,
          child: ListTile(
            onTap:(){
              NavigatorTo(context, Test_data());
            },
            title: const Text( 'Day 1',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: defultFont,
              color: defultColor
            ),),
            trailing:IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ) ,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Container(
          color: Color(0xffebecf0),
          height: 60.0,
          child: ListTile(
            onTap:(){},
            title: const Text( 'Day 2',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: defultFont,
                  color: defultColor
              ),),
            trailing:IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ) ,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Container(
          color: Color(0xffebecf0),
          height: 60.0,
          child: ListTile(
            onTap:(){},
            title: const Text( 'Day 3',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: defultFont,
                  color: defultColor
              ),),
            trailing:IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ) ,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Container(
          color: Color(0xffebecf0),
          height: 60.0,
          child: ListTile(
            onTap:(){},
            title: const Text( 'Day 4',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: defultFont,
                  color: defultColor
              ),),
            trailing:IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ) ,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Container(
          color: Color(0xffebecf0),
          height: 60.0,
          child: ListTile(
            onTap:(){},
            title: const Text( 'Day 5',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: defultFont,
                  color: defultColor
              ),),
            trailing:IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ) ,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Container(
          color: Color(0xffebecf0),
          height: 60.0,
          child: ListTile(
            onTap:(){},
            title: const Text( 'Day 6',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: defultFont,
                  color: defultColor
              ),),
            trailing:IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ) ,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Container(
          color: Color(0xffebecf0),
          height: 60.0,
          child: ListTile(
            onTap:(){},
            title: const Text( 'Day 7',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: defultFont,
                  color: defultColor
              ),),
            trailing:IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ) ,
          ),
        ),

      ],
    ),
    ),
    );


  }
}
