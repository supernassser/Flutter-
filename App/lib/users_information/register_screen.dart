

// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/navigat_bottom_screen/home_screen_user.dart';
import 'package:gym_app/plan/weeks_screen.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/styles/fonts.dart';
import 'package:gym_app/widgets/widgets_model.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({Key? key}) : super(key: key);
  static const String namepage='Register_Screen';
  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {


  final auth= FirebaseAuth.instance;

  var usernamecontroller=TextEditingController();
  var emailcontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  var passwordcontroller=TextEditingController();

  bool showmodalprogress = false;

  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

    SignUp() async{
      var formdata =_formKey.currentState;
      if(formdata!.validate()){
        try {
          final userCredential = await auth.createUserWithEmailAndPassword(
              email:emailcontroller.text.trim() ,
              password:passwordcontroller.text.trim());

          if(userCredential !=null){

            var userInfo=FirebaseFirestore.instance.collection("Users").doc().set({
              'pasword':passwordcontroller.text,
              'uemail':userCredential.user?.email ,
              'usermail':usernamecontroller.text,
             'userphone':phonecontroller.text ,
            });
            NavigatorTo(context, Home_Screen_user());
          }
          setState(() {
            showmodalprogress=false;
          });
        } catch (e) {
          print(e);
        }
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Center(
              child:defultTextButton(
              onPressedfun:(){
        Navigator.pop(context,MaterialPageRoute(
        builder: (context){
        return Login_Screen();
        }));
        },
          text:'Back',
          color: defultColor,
          FontFamily: defultFont,
          FontSize: 18.0,
          FontWeight: FontWeight.bold,
        ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall:showmodalprogress,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children:
                    [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 'logo',
                            child: Container(
                              child:Lottie.network('https://assets10.lottiefiles.com/packages/lf20_e96Pi2.json',
                                  width: 80.0,
                                  height: 70.0),
                            ),
                          ),
                          SizedBox(
                            width: 12.0,),
                          Text('Sign Up',
                            // Text('Flash Chat')
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),

                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 35.0,
                            ),
                            Container(
                              child:Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    FieldWidget(
                                      iconData: Icons.person,
                                      hintText: 'Enter your User name',
                                      labelText: 'User name',
                                      type: TextInputType.name,

                                      validate:  (value)
                                      {
                                        if (value == null || value.isEmpty)
                                        {
                                          return'name must not  be empty';
                                        }
                                        return null;
                                      },
                                     controller: usernamecontroller,

                                    ),
                                    SizedBox(
                                      height: 18.0,
                                    ),
                                    FieldWidget(
                                      iconData:  Icons.email_outlined,
                                      hintText: 'Enter your email',
                                      labelText: 'Email',
                                      type: TextInputType.name,
                                      validate:  (value)
                                      {
                                        if (value == null || value.isEmpty)
                                        {
                                          return'email must not  be empty';
                                        }
                                        return null;
                                      },
                                       controller: emailcontroller,

                                    ),
                                    SizedBox(
                                      height: 18.0,
                                    ),
                                    FieldWidget(
                                      iconData: Icons.phone,
                                      hintText: 'Enter your Phone Number',
                                      labelText: ' Phone Number',
                                      type: TextInputType.phone,
                                      validate:  (value)
                                      {
                                        //phone=value;
                                        if (value == null || value.isEmpty)
                                        {
                                          return'name must not  be empty';
                                        }
                                        return null;
                                      },
                                       controller: phonecontroller,

                                    ),
                                    SizedBox(
                                      height: 18.0,
                                    ),
                                    FieldWidget(
                                        iconData:Icons.lock,
                                        hintText: 'Enter your password',
                                        labelText: 'password',
                                        type: TextInputType.name,
                                        validate: (value){
                                          if (value == null || value.isEmpty) {
                                            return'password  must not  be empty';
                                          }
                                          return null;
                                        },
                                        controller: passwordcontroller,
                                        suffixIcon: Icons.remove_red_eye_outlined,
                                        obscureText:obscureText,
                                        onPressedfun: (){
                                          setState(() {
                                            obscureText= !obscureText;

                                          });
                                        }

                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      ButtonWidget(
                        text: 'CREATE',
                        fun: () {
                          setState(() {
                            showmodalprogress=true;
                          });
                          SignUp();
                        },
                        backgroung:defultColor, colortext: Colors.white,
                      ),
                      SizedBox(
                        height: 22.0,
                      ),
                      accountLine(
                          onPressed: ()
                          {
                            NavigatorTo(context, Login_Screen());
                          },
                          colortext: defultColor,
                          textone: 'Already have an account? ',
                          texttwo: 'Sign In'),

                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
