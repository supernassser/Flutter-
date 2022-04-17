// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/data_view.dart';
import 'package:gym_app/provider/main_provider.dart';

import 'package:gym_app/provider/root_provider.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/styles/fonts.dart';
import 'package:gym_app/widgets/data_model.dart';
class CardItemVM extends StatelessWidget {

  CardItemVM({Key? key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 80,
              child: Text(
                'your exercises',
                style: TextStyle(
                  color: defultColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: defultFont
                ),
              ),
            ),
             SizedBox(
              height: 20.0,
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return StreamBuilder<QuerySnapshot>(
                    stream:  ref.watch(ItemsProvider.stream),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: snapshot.data!.docs.map((
                            DocumentSnapshot document) {
                          detailsmodel data = detailsmodel.name(document);
                          return ItemCardView(data: data) ;
                        }).toList(),

                      );
                    }
                );
              },

            ),
          ],
        ),
      ),
    );
  }

}

class ItemCardView extends StatelessWidget {
 late detailsmodel _data;
   ItemCardView({Key? key,required detailsmodel data}){
     _data =data ;
   }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return Padding(
        padding: const EdgeInsets.all(9.0),
        child: GestureDetector(
          onTap: () {
            ref.watch(backScreenProvider.state).state = ref.watch(currrentScreenProvider.state).state;//arm => List
            ref.watch(currrentScreenProvider.state).state = Details_View(data: _data);
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: Container(
                padding:  EdgeInsets.all(15.0),
                height: 100.0,
                color: Colors.white,
                child: Row(
                  children: [
                     Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image(
                              image: NetworkImage(_data.image
                              ),
                              width: 90.0,
                              height: 100.0)),
                    ),
                     SizedBox(
                         width: 7.0),
                    DottedLine(
                      direction: Axis.vertical,
                     dashColor: Colors.red,
                      dashRadius: 20,
                      lineThickness:2,
                      ),
                    SizedBox(
                        width: 7.0),
                     Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment
                            .center,
                        children: [
                          Text(_data.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },

    );
  }
}

