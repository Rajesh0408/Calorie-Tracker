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
    // List<Integer> count;

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
        list = querySnapshot.docs.map((doc) => doc.data()).toList();
        print(list);
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Calorie Tracker For Indian Food')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 2,//len ?? 0,
                itemBuilder: (context, index) {
                  if (list == null || list!.isEmpty) {
                    return const CircularProgressIndicator(); // or any other loading indicator
                  }
                  print(len);

                  Map<String, dynamic> foodData = list![index];
                  print(foodData['name']);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image(
                                image: AssetImage('assets/chappathi.jpeg'))),
                      ),
                      Text('${foodData['name']} (${foodData['calories']} cal)'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: FloatingActionButton(
                                onPressed: () {
                                  if(count!=0) {
                                    setState(() {
                                      count--;
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
                            '${count}',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    count++;
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text('Total Calories')),
                  ElevatedButton(onPressed: () {}, child: const Text('Reset')),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
