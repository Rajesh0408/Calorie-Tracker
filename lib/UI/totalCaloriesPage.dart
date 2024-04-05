import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class TotalCaloriesPage extends StatefulWidget {
  int? totalCalories;
  TotalCaloriesPage(this.totalCalories, {super.key});

  @override
  State<TotalCaloriesPage> createState() => _TotalCaloriesPageState();
}

class _TotalCaloriesPageState extends State<TotalCaloriesPage> {
  int? totalCalories;
  Color card = const Color(0xFFe0aaff);
  Color appbar = const Color(0xFF7b2cbf);

  @override
  void initState() {
    super.initState();
    totalCalories = widget.totalCalories;
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
                borderRadius: BorderRadius.circular(20.0),
                color: card

              ),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Center(
                      child: Text(
                    'TOTAL CALORIES',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(height: 140,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$totalCalories',
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' cal',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(height: 100,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(totalCalories! > 1800 && totalCalories! < 2800
                        ? "That's correct amount of calories and very healthy to consume!"
                        : totalCalories! < 1800
                            ? "Very Low Calories. Please take more calories"
                            : "That's a lot of calories and very unhealthy for you", style: TextStyle(fontSize: 20, color: totalCalories! < 1800 || totalCalories! > 2800?Colors.red : Colors.green ),),
                  ),
                  SizedBox(height: 120,),
                  const Text('Average daily intake for men is 2500 calories', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                  const Text('Average daily intake for women is 2000 calories', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                  SizedBox(height: 30,),

                ],
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ButtonStyle(
                padding:MaterialStatePropertyAll(EdgeInsets.only(left: 100, right: 100, top: 15,bottom: 15)),
              ),
                onPressed: () {
                  Navigator.pop(context);
                }, child: const Text('Recalculate')),
          ],
        ),
      ),
    );
  }
}
