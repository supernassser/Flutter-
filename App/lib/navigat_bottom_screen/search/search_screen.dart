
import 'package:flutter/material.dart';
import 'package:gym_app/styles/colors.dart';

class Search_Screen extends StatelessWidget {

  var searchController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
body: Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Column(

    children: [

   TextFormField(
     controller: searchController,
     keyboardType: TextInputType.text,
     validator: (value)
     {
  if( value!.isEmpty)
    {
      print('Please enter some text');
    }
  return null;
     },
     style: const TextStyle(
         color: defultColor),
     cursorColor: defultColor,
     decoration: InputDecoration(
         hintText:"Search...",
         labelText:"  Search",
         labelStyle:  const TextStyle(
           color:  Color(0xFF424242),
           fontWeight: FontWeight.bold,
           fontSize: 16.0,
         ),


         enabledBorder: const OutlineInputBorder(
           borderSide: BorderSide(color: defultColor, width: 8.0),
         ),


         focusedBorder:OutlineInputBorder(
           borderRadius: BorderRadius.circular(10.0),
           borderSide:
           const BorderSide(
               color: defultColor,width: 10),
         ),

         suffixIcon: IconButton(
           onPressed:(){},
           icon: const Icon(
             Icons.search,
             color:defultColor ,
             size: 35.0,
           ),

         )

     ),

   )

    ],

  ),
),
    );
  }
}
