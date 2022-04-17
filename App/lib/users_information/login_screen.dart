// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_app/provider/root_provider.dart';
import 'package:gym_app/users_information/register_screen.dart';
import 'package:gym_app/styles/colors.dart';
import 'package:gym_app/styles/fonts.dart';
import 'package:gym_app/widgets/widgets_model.dart';

import '../home_layout.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);
  static const String namepage = 'Login_Screen';

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final auth = FirebaseAuth.instance;
 final _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  // Future GoogleSignInWithGoogle() async {
  //   final  googleSignInUser=
  //   await _googleSignIn.signIn();
  //   if( googleSignInUser ==null) return;
  //   _user= googleSignInUser as GoogleSignInAccount? ;
  //
  //   GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInUser!.authentication;
  //
  //   final  credential = GoogleAuthProvider.credential(
  //     idToken: googleSignInAuthentication.idToken,
  //     accessToken: googleSignInAuthentication.accessToken,
  //   );
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //
  // }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            'Let\'s Get Started',
                            style: TextStyle(
                              fontSize: 27,
                              color: defultColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: defultFont,
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            'Log in to  your existant account of Q Allure',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontFamily: defultFont,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        FieldWidget(
                                          iconData: Icons.email_outlined,
                                          hintText: 'Enter your email',
                                          labelText: 'Email',
                                          type: TextInputType.name,
                                          validate: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'email must not  be empty';
                                            }
                                            return null;
                                          },
                                          controller: emailcontroller,
                                        ),
                                        SizedBox(
                                          height: 18.0,
                                        ),
                                        FieldWidget(
                                            iconData: Icons.lock,
                                            hintText: 'Enter your password',
                                            labelText: 'password',
                                            type: TextInputType.name,
                                            validate: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'password  must not  be empty';
                                              }
                                              return null;
                                            },
                                            controller: passwordcontroller,
                                            suffixIcon:
                                                Icons.remove_red_eye_outlined,
                                            obscureText: obscureText,
                                            onPressedfun: () {
                                              setState(() {
                                                obscureText = !obscureText;
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.bottomRight,
                        child: MaterialButton(
                          onPressed: () async {

                          },
                          child: Text(
                            'Forget password?',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        return ButtonWidget(
                          text: 'Sign In',
                          fun: () async {
                            try {
                              if (_formKey.currentState!.validate()) {}
                              final newdata =
                                  await auth.signInWithEmailAndPassword(
                                      email: emailcontroller.text.trim(),
                                      password: passwordcontroller.text.trim());
                              if (newdata != null) {
                                FirebaseFirestore.instance
                                    .collection("admin")
                                    .doc(newdata.user!.uid)
                                    .get()
                                    .then((value) => {
                                          if (value.exists)
                                            {
                                              ref.watch(isAdmin.state).state = true,
                                               //NavigatorTo(context, Home_LayOut()),
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(builder: (context)=>Home_LayOut())
                                                  , (route) => false)
                            }
                                          else
                                            {
                                              ref.watch(isAdmin.state).state = false,
                                              //NavigatorTo(context, Home_LayOut()),
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(builder: (context)=>Home_LayOut())
                                                  , (route) => false)
                            }
                                        });
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          backgroung: defultColor,
                          colortext: Colors.white,
                        );
                      },
                    ),
                    SizedBox(
                      height: 19.0,
                    ),
                    Text(
                      'Or connect using',
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Container(
                          //   child: MaterialButton(
                          //     minWidth: 130.0,
                          //     onPressed: () {},
                          //     color: Colors.indigo,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(10.0),
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         Image(
                          //           image: AssetImage(
                          //               'assets/images/facebook.png'),
                          //           height: 20.0,
                          //           width: 20.0,
                          //         ),
                          //         SizedBox(
                          //           width: 10.0,
                          //         ),
                          //         Text(
                          //           'Facebook',
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.white),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Container(
                              child: MaterialButton(
                                  minWidth: 270.0,
                                  height: 40.0,
                                  onPressed: () async {
                                    await signInWithGoogle();
                                  },
                                  color: Color(0xFFEAEAEA),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/Google-logo-PNG.png'),
                                        height: 22.0,
                                        width: 22.0,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        'Google',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    accountLine(
                        onPressed: () {
                          NavigatorTo(context, Register_Screen());
                        },
                        colortext: defultColor,
                        textone: 'Don\'t have an account? ',
                        texttwo: 'Sign Up'),
                  ],
                ),
              ),
            ),
          ),
        ));
  }


}
