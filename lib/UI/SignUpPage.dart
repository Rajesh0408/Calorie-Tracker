import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Color card = const Color(0xFFe0c3fc);
  Color appbar = const Color(0xFF7b2cbf);
  int? height;
  int? weight;
  String gender = "Male";
  List activityLevelList = [
    "Sedentary (little or no exercise)",
    "Lightly active (light exercise/sports 1-3 days/week)",
    "Moderately active (moderate exercise/sports 3-5 days/week)",
    "Very active (hard exercise/sports 6-7 days a week)",
    "Extra active (very hard exercise/sports & physical job or 2x training)"
  ];
  List goalList = [
    "I want to gain weight",
    "I want to loss weight",
    "I want to maintain the weight"
  ];
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameCon = TextEditingController();
    TextEditingController weightCon = TextEditingController();
    TextEditingController heightCon = TextEditingController();
    TextEditingController ageCon = TextEditingController();
    TextEditingController emailCon = TextEditingController();
    TextEditingController passwordCon = TextEditingController();
    TextEditingController genderCon = TextEditingController();
    TextEditingController activityLevelCon = TextEditingController();
    String name;
    String email;
    String password;
    int weight;
    int height;
    int age;

    String activityLevel;
    String? groupValue;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text('Calorie Tracker For Indian Food'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7b2cbf)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 25.0, top: 5, bottom: 5),
            child: TextField(
              controller: nameCon,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                hintText: "Name",
              ),
              onChanged: (val) {
                setState(() {
                  name = val.toString();
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 25.0, top: 5, bottom: 5),
            child: TextField(
              controller: emailCon,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                hintText: "Email",
              ),
              onChanged: (val) {
                setState(() {
                  email = val.toString();
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 25.0, top: 5, bottom: 5),
            child: TextField(
              controller: passwordCon,
              decoration: InputDecoration(
                icon: Icon(Icons.password),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                hintText: "Password",
              ),
              onChanged: (val) {
                setState(() {
                  password = val.toString();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 25.0, top: 15, bottom: 5),
            child: TextField(
              controller: weightCon,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Image.asset("assets/weight.png"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                hintText: "Weight (Kg)",
              ),
              onChanged: (val) {
                setState(() {
                  weight = int.parse(val);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 25.0, top: 15, bottom: 5),
            child: TextField(
              controller: heightCon,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.height),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                hintText: "Height (CM)",
              ),
              onChanged: (val) {
                setState(() {
                  height = int.parse(val);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 25.0, top: 15, bottom: 5),
            child: TextField(
              controller: ageCon,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Image.asset("assets/age.png"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                hintText: "Age",
              ),
              onChanged: (val) {
                setState(() {
                  age = int.parse(val);
                });
              },
            ),
          ),
          // RadioMenuButton(value: value, groupValue: groupValue, onChanged: onChanged, child: child),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Image.asset("assets/gender.png"),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Gender:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Radio(
                  value: "Male",
                  groupValue: gender,
                  onChanged: (val) {
                    setState(() {
                      gender = val!.toString();
                    });
                  },
                ),
                Text(
                  'Male',
                  style: TextStyle(fontSize: 16),
                ),
                Radio(
                  value: "Female",
                  groupValue: gender,
                  onChanged: (val) {
                    setState(() {
                      gender = val!.toString();
                    });
                  },
                ),
                Text(
                  'Female',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Image.asset("assets/workout.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 0.0, top: 8, bottom: 8),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          // underline: ,
                          items:
                              activityLevelList.map<DropdownMenuItem>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: SizedBox(
                                width: 300, // Adjust as needed
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropDownValue = value;
                            });
                          },
                          value: dropDownValue,
                          hint: const Text("Activity level"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Image.asset("assets/goal.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 0.0, top: 8, bottom: 8),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          // underline: ,
                          items: goalList.map<DropdownMenuItem>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: SizedBox(
                                width: 300, // Adjust as needed
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropDownValue = value;
                            });
                          },
                          value: dropDownValue,
                          hint: const Text("Goal"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45.0, right: 45),
            child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Start the journey of Calorie!!',
                  style: TextStyle(fontSize: 20),
                )),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {

                },
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
