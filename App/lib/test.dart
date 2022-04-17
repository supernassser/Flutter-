
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/styles/fonts.dart';


class Test_data extends StatelessWidget {
  const Test_data({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: ListView.separated(
          itemBuilder: (context,index)=>Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0
            ),
            child: Container(
              color: Color(0xffebecf0),
              child: GestureDetector(
                onTap: (){},
                child: Row(
                  children: [
                    Container(
                      color: Color(0xffebecf0),
                      height:120.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset('assets/images/test.gif',height:120,width: 120,),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                      ),
                      child: Text('3x10',
                        style:TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: defultFont,

                        ),),
                    )
                  ],
                ),
              ),
            ),
          ),
          separatorBuilder:(context,index)=>SizedBox(
            height: 6.0,
          ),
          itemCount: 12),


    );
  }
}
