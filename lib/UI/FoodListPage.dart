



import 'dart:ffi';

import 'package:calorie_tracker/UI/totalCaloriesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FoodListPage extends StatefulWidget {
    const FoodListPage({super.key});

    @override
    State<FoodListPage> createState() => _FoodListPageState();
  }

  class _FoodListPageState extends State<FoodListPage> {
    List? list;
    int? len;
    int count=0;
    List<int> countList=[];
    String? date;
    DateTime? savedDateTime;
    // int totalCalories=0;
    int savedTotalCalories=0;
    Color card = const Color(0xFFe0c3fc);
    Color appbar = const Color(0xFF7b2cbf);
    List bottomSheetList=[];
    DateTime? savedDate;
    Map<String, dynamic>? data;
    List<dynamic>? dataOfCountList;
    DocumentReference? documentReference;
    DocumentReference? documentReferenceForCountList;
    List? countListArray;

    @override
    void initState() {
      super.initState();
      readData();
    }

    Future<void> readData() async {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('Foods');
      QuerySnapshot querySnapshot = await collectionReference.get();

      //Get the total calories
      documentReference = FirebaseFirestore.instance.collection('TotalCalories').doc('7NELlvkDVQ6PLMVdbqpg');
      DocumentSnapshot<Object?>? documentSnapshot = await documentReference?.get();
      data = documentSnapshot?.data() as Map<String, dynamic>?;
      savedTotalCalories = data?['totalCalories'];

      //Get the countList
      documentReferenceForCountList = FirebaseFirestore.instance.collection('FoodsConsumedToday').doc('XeEl2aYmbHyGfdVsOc9U');
      DocumentSnapshot<Object?>? documentSnapshotForCountList = await documentReferenceForCountList?.get();
      dataOfCountList = documentSnapshotForCountList?.get('countList') ;
      //countListArray = dataOfCountList?['countList'] ;
      print("dataOfCountList: $dataOfCountList");


      setState(() {
        len = querySnapshot.docs.length;
        for(int i=0;i<len!;i++) {
          countList.add(0);
        }
        list = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        // backgroundColor: card,
        appBar: AppBar(
          backgroundColor: appbar,
          title: Text('Calorie Tracker For Indian Food'),),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: len ?? 0,
                itemBuilder: (context, index) {
                  if (list == null || list!.isEmpty) {
                    return const CircularProgressIndicator(); // or any other loading indicator
                  }


                  Map<String, dynamic> foodData = list![index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Hero(
                              tag: 'image$index',
                              child: Image.network("${foodData['image']}",fit: BoxFit.cover,),
                            )
                        ),
                      ),
                      Expanded(
                        child: Text('${foodData['name']} (${foodData['calories']} cal)',
                        overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: FloatingActionButton(
                                heroTag: 'minus$index',
                                onPressed: () {
                                  if(countList[index]!=0) {
                                    setState(() {
                                      countList[index]=countList[index]-1;
                                    });
                                  }
                                },
                                child: const Center(
                                  child: Text(
                                    '-',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Text(
                            '${countList[index]}',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: FloatingActionButton(
                                heroTag: 'plus$index',
                                onPressed: () {
                                  setState(() {
                                    countList[index]=countList[index]+1;
                                  });

                                },
                                child: const Text(
                                  '+',
                                  style: TextStyle(fontSize: 30),
                                )),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                        ],
                      )

                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {

                        if(await isTodayNewDay()) {
                          savedTotalCalories=0;
                          bottomSheetList.clear();
                        }
                        print(savedTotalCalories);
                          for(int i=0; i<countList.length;i++) {
                            savedTotalCalories =savedTotalCalories +  (countList[i]*(list?[i]['calories']) as int );

                            if(countList[i]!=0) {
                                bottomSheetList.add(list?[i]);
                              }
                          }
                        Map<String, dynamic> map1 = {"totalCalories": savedTotalCalories};
                        documentReference?.set(map1).whenComplete(() => null);
                        print(bottomSheetList);
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  TotalCaloriesPage(savedTotalCalories, bottomSheetList),));

                      },

                      child: const Text('Total Calories')),
                  ElevatedButton(onPressed: () {
                    setState(() {
                       for(int i=0;i<len!;i++) {
                        countList[i]=0;
                      }
                    });
                  }, child: const Text('Reset')),
                ],
              ),
            )
          ],
        ),
      );
    }
    Future<bool> isTodayNewDay() async {

      DocumentReference docReference = FirebaseFirestore.instance.collection('TodayDate').doc('5dB7I6qTFwiEeGuUsW8X');
      DocumentSnapshot<Object?>? documentSnapshot = await docReference.get();
      Map<String, dynamic>? data1 = documentSnapshot.data() as Map<String, dynamic>?;

      if (data1 != null) {
        Timestamp? timestamp = data1['date'] as Timestamp?;
        print("Timestamp: $timestamp");

        if (timestamp != null) {
          savedDateTime = timestamp.toDate();
          print("Date: $savedDateTime");
        }
      }

      DateTime now = DateTime.now();

        if (savedDateTime?.year == now.year &&
            savedDateTime?.month == now.month &&
            savedDateTime?.day == now.day) {
          return false;
        } else {
          Map<String, dynamic> map = {"date": now};
          docReference.set(map).whenComplete(() => print(map));
          return true;
        }

    }
  }