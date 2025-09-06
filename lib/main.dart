

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'UI/SignInPage.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyA7TyZ-6C_RfEX6qZ9Z9G50wf4au-TmAkg", appId: '545120632703', messagingSenderId: "1:545120632703:android:fe054d1cc91202b82f644a", projectId: "calorie-tracker-aea6b"),
  );

  runApp(const MaterialApp(
            //theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: SignInPage()));
}

Future<bool> isNew() async {

  DocumentReference documentReference = FirebaseFirestore.instance.collection('NewUser').doc('7KFzfVYcmYqqss75dxzn');
  DocumentSnapshot snapshot = await documentReference.get();
  bool bl = snapshot.get('isNew');
  return bl;
}
