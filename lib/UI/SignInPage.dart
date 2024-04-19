import 'package:flutter/material.dart';

import 'FoodListPage.dart';
import 'SignUpPage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  String? email;
  String? password;
  Color card = const Color(0xFFe0c3fc);
  Color appbar = const Color(0xFF7b2cbf);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appbar,
        title: const Text('Calorie Tracker For Indian Food'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Welcome Back",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7b2cbf)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Enter your credentials to Sign In",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          SizedBox(height: 10,),
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
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoodListPage(),));

                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20),
                )),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
