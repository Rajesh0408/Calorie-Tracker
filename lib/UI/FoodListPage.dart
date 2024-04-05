

import 'package:calorie_tracker/UI/totalCaloriesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';

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
    int totalCalories=0;
    Color card = const Color(0xFFe0c3fc);
    Color appbar = const Color(0xFF7b2cbf);

    @override
    void initState() {
      super.initState();
      readData();
    }

    Future<void> readData() async {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('Foods');
      QuerySnapshot querySnapshot = await collectionReference.get();

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
                  print(foodData['name']);
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
                      onPressed: () {
                        totalCalories=0;
                          for(int i=0; i<countList.length;i++) {
                              totalCalories += (countList[i]*(list?[i]['calories']) as int );
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  TotalCaloriesPage(totalCalories),));
                          print(totalCalories);
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
  }
