import 'package:calorie_tracker/UI/FoodListPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyA7TyZ-6C_RfEX6qZ9Z9G50wf4au-TmAkg", appId: '545120632703', messagingSenderId: "", projectId: "calorie-tracker-aea6b"),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home: FoodListPage()));
}
