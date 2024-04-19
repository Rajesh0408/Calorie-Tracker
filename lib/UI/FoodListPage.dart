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
  List list = [];
  int? len;
  int count = 0;
  List<dynamic> countList = [];
  String? date;
  DateTime? savedDateTime;
  // int totalCalories=0;
  int savedTotalCalories = 0;
  Color card = const Color(0xFFe0c3fc);
  Color appbar = const Color(0xFF7b2cbf);
  List bottomSheetList = [];
  DateTime? savedDate;
  Map<String, dynamic>? data;
  List<dynamic>? dataOfCountList;
  DocumentReference? documentReference;
  DocumentReference? documentReferenceForCountList;
  SearchController controller = SearchController();
  String searchText = '';
  List searchList = [];
  List searchIndexList = [];
  bool bl=false;

  @override
  void initState() {
    super.initState();
    readData();

  }

  Future<void> readData() async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('Foods');
      QuerySnapshot querySnapshot = await collectionReference.get();


      // Get the countList
      documentReferenceForCountList = FirebaseFirestore.instance
          .collection('FoodsConsumedToday')
          .doc('XeEl2aYmbHyGfdVsOc9U');
      DocumentSnapshot<Object?>? documentSnapshotForCountList =
          await documentReferenceForCountList?.get();
      countList = documentSnapshotForCountList?.get('countList');

      len = querySnapshot.docs.length;
      // for(int i=0;i<len!;i++) {
      //   countList.add(0);
      // }

      setState(() {
        isTodayNewDay();
        list = querySnapshot.docs.map((doc) => doc.data()).toList();
      // FirebaseFirestore.instance
      //     .collection(
      //     'FoodsConsumedToday') // Replace 'your_collection' with your actual collection name
      //     .doc(
      //     'XeEl2aYmbHyGfdVsOc9U') // Replace 'your_document_id' with the ID of the document containing the array
      //     .update({'countList': countList});

      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: card,
      appBar: AppBar(
        backgroundColor: appbar,
        title: Text('Calorie Tracker For Indian Food'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchBar(
              controller: controller,
              hintText: 'Search...',
              padding: MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                setState(() {
                  //searchText = text.toString();
                  search(searchText);
                });
              },
              onChanged: (text) {
                setState(() {
                  searchText = text.toString();
                  search(searchText);
                });
              },
              leading: Icon(Icons.search, ),
              trailing: [IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                    setState(() {
                      controller.clear();
                      searchText="";
                      search(searchText);
                    });
                },
              ),]
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchList.isEmpty ? list.length : searchList.length,
              itemBuilder: (context, index) {
                if (list.isEmpty) {
                  return const CircularProgressIndicator(); // or any other loading indicator
                }
                Map<String, dynamic> foodData =
                    searchList.isEmpty ? list[index] : searchList[index];
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
                            child: Image.network(
                              "${foodData['image']}",
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    Expanded(
                      child: Text(
                        '${foodData['name']} (${foodData['calories']} cal)',
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
                                setState(() {
                                  if (searchList.isEmpty) {
                                    if (countList[index] != 0) {
                                      countList[index] = countList[index] - 1;
                                    }
                                  } else {
                                    if (countList[searchIndexList[index]] !=
                                        0) {
                                      countList[searchIndexList[index]] =
                                          countList[searchIndexList[index]] - 1;
                                    }
                                  }  });
                                  FirebaseFirestore.instance
                                      .collection(
                                      'FoodsConsumedToday') // Replace 'your_collection' with your actual collection name
                                      .doc(
                                      'XeEl2aYmbHyGfdVsOc9U') // Replace 'your_document_id' with the ID of the document containing the array
                                      .update({'countList': countList});

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
                          '${searchList.isEmpty ? countList[index] : countList[searchIndexList[index]]}',
                          style: const TextStyle(fontSize: 20),
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
                                setState(()  {
                                  if (searchList.isEmpty) {
                                    countList[index] = countList[index] + 1;
                                  } else {
                                    countList[searchIndexList[index]] =
                                        countList[searchIndexList[index]] + 1;
                                  }
                                });
                                  FirebaseFirestore.instance
                                      .collection(
                                      'FoodsConsumedToday') // Replace 'your_collection' with your actual collection name
                                      .doc(
                                      'XeEl2aYmbHyGfdVsOc9U') // Replace 'your_document_id' with the ID of the document containing the array
                                      .update({'countList': countList});

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
                      savedTotalCalories = 0;
                      bottomSheetList.clear();


                      for (int i = 0; i < countList.length; i++) {
                        savedTotalCalories = savedTotalCalories +
                            (countList[i] * (list[i]['calories']) as int);

                        if (countList[i] != 0) {
                          bottomSheetList.add(list[i]);
                        }
                      }
                      Map<String, dynamic> map1 = {
                        "totalCalories": savedTotalCalories
                      };
                      documentReference?.set(map1).whenComplete(() => null);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TotalCaloriesPage(
                                savedTotalCalories, bottomSheetList),
                          ));
                    },
                    child: const Text('Total Calories')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        for (int i = 0; i < len!; i++) {
                          countList[i] = 0;
                        }
                      });
                    },
                    child: const Text('Reset')),
              ],
            ),
          )
        ],
      ),
    );
  }

  void search(String searchText) {
    searchList = [];
    searchIndexList.clear();
    setState(() {
      for (int i = 0; i < list.length; i++) {
        if (list[i]['name'].toLowerCase().contains(searchText.toLowerCase())) {
          searchList.add(list[i]);
          searchIndexList.add(i);
        }
      }
    });
  }

  Future<void> isTodayNewDay() async {
    DocumentReference docReference = FirebaseFirestore.instance
        .collection('TodayDate')
        .doc('5dB7I6qTFwiEeGuUsW8X');
    DocumentSnapshot<Object?>? documentSnapshot = await docReference.get();
    Map<String, dynamic>? data1 =
        documentSnapshot.data() as Map<String, dynamic>?;

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
    } else {
      print("else part");
      Map<String, dynamic> map = {"date": now};
      docReference.set(map).whenComplete(() => print(map));
      setState(() {
        for (int i = 0; i < countList.length; i++) {
          countList[i]=0;
        }
      });
      await FirebaseFirestore.instance
          .collection(
          'FoodsConsumedToday') // Replace 'your_collection' with your actual collection name
          .doc(
          'XeEl2aYmbHyGfdVsOc9U') // Replace 'your_document_id' with the ID of the document containing the array
          .update({'countList': countList});
    }
  }
}
