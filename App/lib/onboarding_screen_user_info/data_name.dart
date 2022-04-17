// ignore_for_file: prefer_const_constructors



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/onboarding_screen_user_info/data_sex.dart';
import 'package:gym_app/styles/colors.dart';

import '../widgets/widgets_model.dart';



class Name extends StatelessWidget {
   Name({Key? key}) : super(key: key);


  var usernamecontroller=TextEditingController();


   //final auth= FirebaseAuth.instance;
   final firestore =FirebaseFirestore.instance;
   String? name;
   String? sex;
   String? birth;
   String? tall;
   String? weight;
   void getData() async{
     await for(var snapshot in firestore.collection('userdata').snapshots()){
       for( var namedata in snapshot.docs){
         print(namedata.data());
       }
     }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              // Expanded(
              //    child: PageView.builder(
              //      itemBuilder: (contxt,index)=>builddatanameinfo(),
              //
              //    ),
              //  ),
              ButtonWidget(
                text: 'DONE',
                fun: () {
                  firestore.collection('userdata').add({
                    'name':name,
                    'sex':sex,
                    'birth':birth,
                    'tall':tall,
                    'weight':weight,
                  });

                },

                backgroung:defultColor, colortext: Colors.white,
              ),

            ],
          ),
        ),
      ),
    );
  }
   // Widget builddatanameinfo()=> Column(
   //   children: [
   //     Text('Hi! What is your first ',
   //       style: TextStyle(
   //           fontSize: 24.0,
   //           fontWeight: FontWeight.bold
   //       ),
   //     ),
   //     Text('name?',
   //         style: TextStyle(
   //             fontSize: 24.0,
   //             fontWeight: FontWeight.bold
   //         )),
   //     SizedBox(
   //       height: 90.0,
   //     ),
   //    Container(
   //      child: Column(
   //        children: [
   //          TextFormField(
   //            controller:usernamecontroller,
   //            keyboardType:TextInputType.name,
   //            onChanged: ( value){
   //              name=value;
   //            },
   //            onFieldSubmitted: (String value){
   //              print(value);
   //            },
   //            validator:  (value)
   //            {
   //              if (value == null || value.isEmpty)
   //              {
   //                return'name must not  be empty';
   //              }
   //              return null;
   //            },
   //            cursorColor: defultColor,
   //            style: TextStyle(
   //                color: defultColor),
   //            decoration: InputDecoration(
   //              labelText:'Name....',
   //              labelStyle:  TextStyle(
   //                color: Color(0xFF424242),
   //                fontWeight: FontWeight.bold,
   //                fontSize: 17.0,
   //              ),
   //
   //            ),
   //          ),
   //          SizedBox(
   //            height: 50.0,
   //          ),
   //
   //          MaterialButton(
   //            minWidth: 150.0,
   //            height:  50,
   //            color: Color(0xFFEAEAEA),
   //
   //            onPressed:(){
   //              getData();
   //              NavigatorTo(context, Sex());
   //            },
   //            shape: RoundedRectangleBorder(
   //                borderRadius: BorderRadius.circular(19.0)),
   //            child: Text('Next',
   //              style:  TextStyle(
   //                fontSize: 18.0,
   //                color: Colors.black,
   //                fontWeight: FontWeight.bold,
   //              ),),
   //
   //
   //          ),
   //        ],
   //      ),
   //    )
   //   ],
   // );
}
