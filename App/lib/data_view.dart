
// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/styles/fonts.dart';

import 'widgets/data_model.dart';
TextStyle textsty =TextStyle(
    fontSize: 16.0,
    fontFamily: defultFont,
    color: defultColor,
);

TextStyle titleTextstylr =TextStyle(
    fontSize: 18.0,
    fontFamily: defultFont,
    color: Colors.black
);

class Details_View extends StatelessWidget {
  late  detailsmodel _data;

  Details_View({Key? key,required  detailsmodel data }) {
    _data= data ;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return  Column(
                children: [
                  SizedBox(
                    height: 20.0,),
                  Container(
                    child: Text(
                        _data.title,
                        style:titleTextstylr,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Image(
                        fit: BoxFit.fill,
                          image: NetworkImage(
                            _data.image,
                          ),
                          width:double.infinity,
                          height: 170.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,),
                  Expanded(
                    child: Container(
                      child: Text(
                        _data.details,
                        style: textsty,
                      ),
                    ),
                  ),
                ],
              );
            },

          ),
        ),
      ),
    );
  }
}
