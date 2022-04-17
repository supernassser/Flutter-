

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_app/trining_user/view_model/card_list_vm.dart';

import '../plan/build_my_plan_screen.dart';



StateProvider<Widget> currrentScreenProvider = StateProvider<Widget>((ref) =>bulidHomeItem_vm() );
StateProvider<Widget> backScreenProvider = StateProvider<Widget>((ref) =>  bulidHomeItem_vm() );



StateProvider<Widget> currrentPlanScreenProvider = StateProvider<Widget>((ref) =>bulidPlanItem_vm() );
StateProvider<Widget> backPlanScreenProvider = StateProvider<Widget>((ref) =>  bulidPlanItem_vm() );

StateProvider<String> currrentPlanIdProvider = StateProvider<String>((ref) =>"");




StateProvider<bool> isAdmin = StateProvider<bool>((ref) => false );


