
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_app/styles/fonts.dart';
import 'package:gym_app/users_information/login_screen.dart';
import 'package:gym_app/widgets/widgets_model.dart';

class Settings_Screen extends StatelessWidget {
  final firestore =FirebaseFirestore.instance;
  final _googleSignIn = GoogleSignIn();
   Settings_Screen({Key? key}) : super(key: key);
   @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
      NavigatorTo(context, Login_Screen());

    }


    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:   Column(
              children: [
                SizedBox(
                  height: 70.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 50.0,
                        backgroundImage:NetworkImage('https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg')
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: firestore.collection('userdata').snapshots(),
                        builder: (context,Snapshot){
                        return Text("usernamecontroller",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily:defultFont,
                            color: Colors.black87
                          ),);
                        }),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0
                  ),
                  child: Divider(
                    color: Colors.black,
                    height: 22,
                  ),
                ),
                SizedBox(
                  height: 28.0,
                ),
                Expanded(
                    child: ListView(
                      children: [
                        Container(
                          color: Color(0xffebecf0),
                          height: 60.0,
                          child: ListTile(
                            onTap:(){},
                            leading:Image.asset('assets/images/dark-mode .png',
                              height: 35.0,
                              width: 35.0,),
                            title: Text( 'Dark Mode'),
                          ),
                        ),
                        SizedBox(
                       height: 12.0,
                     ),
                        // Container(
                        //   color: Color(0xffebecf0),
                        //   height: 60.0,
                        //   child: ListTile(
                        //     onTap:(){},
                        //       leading:Image.asset('assets/images/account.png',
                        //         height: 35.0,
                        //         width: 35.0,),
                        //       title: Text( 'Account Settings'),
                        //       subtitle: Text('Privacy , Security '),
                        //       trailing:IconButton(
                        //         icon: Icon(Icons.arrow_forward_ios),
                        //         onPressed: () {},
                        //       ) ,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 12.0,
                        // ),
                        Container(
                          color: Color(0xffebecf0),
                          height: 60.0,
                          child: ListTile(
                            onTap:(){},
                            leading:Image.asset('assets/images/languages.png',
                              height: 35.0,
                              width: 35.0,),
                            title: Text( 'Language'),
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
                            onTap:() async{

                            },
                            leading:Image.asset('assets/images/delete.png',
                              height: 35.0,
                              width: 35.0,),
                            title: Text( 'Delete Account'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0
                          ),
                          child: Divider(
                            color: Colors.black,
                            height: 22,
                          ),
                        ),
                        Container(
                          color: Color(0xffebecf0),
                          height: 60.0,
                          child: ListTile(
                            onTap:() async{
                              await signOut();
                            },
                            leading:Image.asset('assets/images/log-out.png',
                            height: 35.0,
                            width: 35.0,),
                            title: Text( 'Logout'),
                          ),
                        ),
                      ],
                    ))
              ],

            ),
          ),

        ),
      ),
    );
  }
}
