import 'package:calorie_tracker/FireBaseAuth/FirebaseAuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'FoodListPage.dart';
import 'SignUpPage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FirebaseAuthServices auth = FirebaseAuthServices();

  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  String? email;
  String? password;
  Color card = const Color(0xFFe0c3fc);
  Color appbar = const Color(0xFF7b2cbf);
  bool signing= false;
  bool emailValid=true;
  bool passwordValid=true;

  @override
  void dispose() {
    // TODO: implement dispose
    emailCon.dispose();
    passwordCon.dispose();
    super.dispose();
  }

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
                errorText: emailValid? null: "Invalid email"
              ),
              onChanged: (val) {
                setState(() {
                  email = val.toString();
                  emailValid= RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email!);
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
                errorText: passwordValid?null:"Password length should be >=8"
              ),
              onChanged: (val) {
                setState(() {
                  password = val.toString();
                  passwordValid = password!.length>=8;

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
                 if(email!=null && password!=null && passwordValid && emailValid) {
                   signIn();
                 } else {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                     content: const Text("Please fill the above details correctly"),
                     duration: Duration(seconds: 2),
                     backgroundColor: appbar,
                   ));
                 }
                },
                child: signing? CircularProgressIndicator():const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20),
                )),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                child: const Text(
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

  void signIn() async{
    setState(() {
      signing= true;
    });
    User? user = await auth.signInWithEmailAndPassword(email!, password!);
    if(user!=null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodListPage(email!),
          ));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Successfully Signed In"),
        duration: Duration(seconds: 2),
        backgroundColor: appbar,
      ));
      setState(() {
        signing= false;
      });
    } else {
      setState(() {
        signing= false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to Sign In"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }
}
