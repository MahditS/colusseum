// ignore_for_file: constant_identifier_names

// import 'dart:html';

import 'package:colusseum/features/db_helper/constants.dart';
import 'package:colusseum/features/db_helper/mongodb.dart';
import 'package:colusseum/features/user_auth/firebase_auth_implementation.dart';
import 'package:colusseum/features/user_auth/presentation/pages/home_page.dart';
import 'package:colusseum/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController username_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController password_controller = TextEditingController();
  
  @override
  void dispose()
  {
    username_controller.dispose();
    password_controller.dispose();
    email_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: const Text("Sign Up", style:TextStyle(fontSize: 30, color: Color.fromARGB(255, 255, 119, 119), fontWeight: FontWeight.bold)), backgroundColor: const Color.fromARGB(255, 54, 54, 54),),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
             FormContainerWidget
            (
              controller: email_controller,
              hintText: "Email",
              isPasswordField: false,
            ),
            const SizedBox(height: 25),
             FormContainerWidget
            (
              controller: username_controller,
              hintText: "Username",
              isPasswordField: false,
            ),
            const SizedBox(height: 25)
            , FormContainerWidget
            (
              controller: password_controller,
              hintText: "Password",
              isPasswordField: true,
              
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: signUp,
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(223, 255, 82, 82),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 640.0, vertical: 8),
                  child:  Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                ),
              
              ),
            )
          ],
        ),
      ),
    );

    
  }

  void signUp() async {
    String username = username_controller.text;
    String password= password_controller.text;
    String email = email_controller.text;

    User? user = await _auth.signUpWithUsernameAndPassword(email, password);

    if(user != null)
    {
      print("User Created");
      // ignore: use_build_context_synchronously
      currentUserDart = user.email;
      MongoDatabase.insertUser(currentUserDart, 0, 0, 0);
      var arr = await MongoDatabase.findUser(currentUserDart);
      var lvl;
      var xp;
      var money;
      for(var doc in arr)
      {
       lvl = doc["Level"];
       xp = doc["Exp"];
       money = doc["Coins"];
      }
      currentUserExp = xp;
      currentUserLevel = lvl;
      currentUserCoins = money;
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
    else
    {
      print("There is an error :(");
    }
  }
}