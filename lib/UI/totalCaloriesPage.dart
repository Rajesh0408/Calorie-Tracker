import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class TotalCaloriesPage extends StatefulWidget {
  int? totalCalories;
  List? bottomSheetList;
  TotalCaloriesPage(this.totalCalories, this.bottomSheetList, {super.key});

  @override
  State<TotalCaloriesPage> createState() => _TotalCaloriesPageState();
}

class _TotalCaloriesPageState extends State<TotalCaloriesPage> {
  int? totalCalories;
  Color card = const Color(0xFFe0aaff);
  Color appbar = const Color(0xFF7b2cbf);
  DateTime time = DateTime.now();
  List? bottomSheetList;
  int? len;
  int? remainingCalories;
  ValueNotifier<double> valueNotifierEaten = ValueNotifier<double>(0.0);
  ValueNotifier<double> valueNotifierRemaining = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    totalCalories = widget.totalCalories;
    bottomSheetList = widget.bottomSheetList;
    len = bottomSheetList?.length;
    changeEatenProgressValue(totalCalories!);
    changeRemainingProgressValue(totalCalories!);
    print(time);
  }

  void changeEatenProgressValue(int totalCalories) {
    valueNotifierEaten.value = (totalCalories / 1800) * 100;
  }

  void changeRemainingProgressValue(int totalCalories) {
    remainingCalories = 1800 - totalCalories;
    if (remainingCalories! < 0) {
      remainingCalories = 0;
    }
    valueNotifierRemaining.value = (remainingCalories! / 1800) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar,
        title: Text('Calorie Tracker For Indian Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0), color: card),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                      child: Text(
                    'TOTAL CALORIES \n  INTAKE TODAY',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(
                    height: 40,
                  ),
                  if (totalCalories!>1800)
                    const Text("Heyyy!! You achieved today's goal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),),
                    const SizedBox(
                      height: 40,
                    ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SimpleCircularProgressBar(
                            valueNotifier: valueNotifierEaten,
                            mergeMode: true,
                            onGetText: (double value) {
                              return Text(
                                '${value.toInt()}%',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$totalCalories',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              const Text(
                                ' cal',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.green),
                              ),
                            ],
                          ),
                          Text(
                            'Eaten',
                            style: TextStyle(fontSize: 20, color: Colors.green),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SimpleCircularProgressBar(
                            valueNotifier: valueNotifierRemaining,
                            mergeMode: true,
                            onGetText: (double value) {
                              return Text(
                                '${value.toInt()}%',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$remainingCalories ',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              const Text(
                                ' cal',
                                style:
                                    TextStyle(fontSize: 25, color: Colors.red),
                              ),
                            ],
                          ),
                          Text(
                            'Remaining',
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0,right: 25),
                    child: Text(
                      totalCalories! > 1800 && totalCalories! < 2800
                          ? "That's correct amount of calories and very healthy to consume!"
                          : totalCalories! < 1800
                              ? "Very Low Calories. Please take more calories"
                              : "That's a lot of calories and very unhealthy for you",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: totalCalories! < 1800 || totalCalories! > 2800
                              ? Colors.red
                              : Colors.green),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Average daily intake for men is 2500 calories',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Average daily intake for women is 2000 calories',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.only(
                          left: 30, right: 30, top: 15, bottom: 15)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Recalculate')),
                ElevatedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.only(
                          left: 30, right: 30, top: 15, bottom: 15)),
                    ),
                    onPressed: () {
                      BottomSheet();
                    },
                    child: const Expanded(child: Text("Foods consumed today"))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future BottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemCount: len,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(9.0),
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Hero(
                          tag: 'image$index',
                          child: Image.network(
                            "${bottomSheetList?[index]['image']}",
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Text(
                      '${bottomSheetList?[index]['name']} (${bottomSheetList?[index]['calories']} cal)',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              );
            },
          );
        });
  }
}
