
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// HomePage
  AutoDisposeStreamProvider<QuerySnapshot<Object?>> workoutProvider =
  StreamProvider.autoDispose<QuerySnapshot>((ref) =>
    FirebaseFirestore.instance.collection("WorkOut").snapshots());

  StateProvider<String> currentItem = StateProvider<String>((ref) =>  " ");

AutoDisposeStreamProvider<QuerySnapshot<Object?>> ItemsProvider =
StreamProvider.autoDispose<QuerySnapshot>((ref) =>
    FirebaseFirestore.instance.collection("WorkOut").doc(ref.watch(currentItem.state).state).collection("arm").snapshots());


//MyPlan

AutoDisposeStreamProvider<QuerySnapshot<Object?>> MyPlanProvider =
StreamProvider.autoDispose<QuerySnapshot>((ref) =>
    FirebaseFirestore.instance.collection("MyPlan").snapshots());

StateProvider<String> currenplantItem = StateProvider<String>((ref) =>  " ");


AutoDisposeStreamProvider<QuerySnapshot<Object?>> ItemsMyPlanProvider =
StreamProvider.autoDispose<QuerySnapshot>((ref) =>
    FirebaseFirestore.instance.collection("MyPlan").doc(ref.watch(currenplantItem.state).state).collection("days").snapshots());


AutoDisposeStreamProvider<QuerySnapshot<Object?>> MyUserDataProvider =
StreamProvider.autoDispose<QuerySnapshot>((ref) =>
    FirebaseFirestore.instance.collection("UserData").snapshots());