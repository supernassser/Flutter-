

// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/styles/colors.dart';


final firestore=FirebaseFirestore.instance;
late User SignUpuser ;

class Chat_Screen extends StatefulWidget {
  const Chat_Screen({Key? key}) : super(key: key);

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  final auth= FirebaseAuth.instance;
  final messageTextController =TextEditingController();
  String? messagetext;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser(){
    try{
      final user = auth.currentUser;
      if(user != null){
        SignUpuser = user;
      }
    }
    catch (e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: defultColor,
        title: Row(
          children: [
            Image.asset('assets/images/message.png',
              height: 28.0,
              width: 36.0,
            ),
            SizedBox(width: 8),
            Text('MessageMe',
            style: TextStyle(
              fontSize: 18.0
            ),),
          ],
        ),

      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MessageStreamBuilder(),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: defultColor,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageTextController,
                          onChanged: (value) {
                            messagetext= value;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            hintText: 'Write your message here...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          messageTextController.clear();
                          firestore.collection('Messages').add({
                            'text' : messagetext,
                            'sender': SignUpuser.email,
                            'time' : FieldValue.serverTimestamp(),
                          });
                        },
                        child: Text(
                          'send',
                          style: TextStyle(
                            color: defultColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),

                ),

              ],
            ),
          )),
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({Key? key, this.text,this.sender, required this.isMy}) : super(key: key);

      final  String? text;
      final  String? sender;
      final bool isMy;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMy ?CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black45,
          ),),
          SizedBox(
            height:5.0,
          ),
          Material(
            elevation: 5,
           borderRadius:isMy? BorderRadius.only(
             topLeft: Radius.circular(30),
             bottomLeft: Radius.circular(30),
             bottomRight: Radius.circular(30),
           ): BorderRadius.only(
             topRight: Radius.circular(30),
             bottomLeft: Radius.circular(30),
             bottomRight: Radius.circular(30),
           ),
            color: isMy? defultColor : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Text('$text',
                  style:TextStyle(
                    fontSize: 15.0,
                    color: isMy? Colors.white : Colors.black45,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('Messages').orderBy('time').snapshots(),
      builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        List<MessageLine> MessageWidgets =[];

        if(!snapshot.hasData){
          return Center(child: const CircularProgressIndicator());
        }
        final messages = snapshot.data!.docs.reversed;
        for( var message in messages ){
          final messagesText = message.get('text');
          final messagessender = message.get('sender');
          final currenuser = SignUpuser.email;
          final messagewidget =MessageLine(
            text: messagesText ,
            sender: messagessender,
            isMy: currenuser == messagessender ,
          );

          MessageWidgets.add(messagewidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0 ,vertical:20.0 ),
            children: MessageWidgets,
          ),
        );
      } ,
    );
  }
}

