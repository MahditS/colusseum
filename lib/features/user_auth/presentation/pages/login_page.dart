// import 'dart:html';

import 'package:colusseum/features/db_helper/constants.dart';
import 'package:colusseum/features/db_helper/mongodb.dart';
import 'package:colusseum/features/user_auth/firebase_auth_implementation.dart';
import 'package:colusseum/features/user_auth/presentation/pages/home_page.dart';
import 'package:colusseum/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:colusseum/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  
  @override
  void dispose()
  {
    password_controller.dispose();
    email_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: const Text("Login", style:TextStyle(fontSize: 30, color: Color.fromARGB(255, 255, 119, 119), fontWeight: FontWeight.bold)), backgroundColor: const Color.fromARGB(255, 54, 54, 54),),
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
            const SizedBox(height: 25)
            , FormContainerWidget
            (
              controller: password_controller,
              hintText: "Password",
              isPasswordField: true,
              
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap:signIn
              ,
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(223, 255, 82, 82),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 640.0, vertical: 8),
                  child:  Text("Login", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                ),
              
              )
            ),
             Row
            (
            mainAxisAlignment: MainAxisAlignment.center, 
            children: 
              [
                const Text("Don't have an account?", style: TextStyle(color: Colors.white, fontSize: 15),),
                const SizedBox(width: 5,), 
                GestureDetector
                (
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));}, 
                child: const Text("Sign Up!", style: TextStyle(color: Colors.blue, fontSize: 15),)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void signIn() async {
    String password= password_controller.text;
    String email = email_controller.text;
    
    User? user = await _auth.signInWithUsernameAndPassword(email, password);

    if(user != null)
    {
      print("User Logged in");
      // ignore: use_build_context_synchronously
      currentUserDart = user.email;
      var arr = await MongoDatabase.findUser(currentUserDart);
      var lvl;
      var xp;
      var money;
      var bolts;
      for(var doc in arr)
      {
       lvl = doc["Level"];
       xp = doc["Exp"];
       money = doc["Coins"];
       bolts = doc["Bolts"];
      }
      currentUserExp = xp;
      currentUserLevel = lvl;
      currentUserCoins = money;
      currentUserBolts = bolts;

      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
      
    }
    else
    {
      print("There is an error :(");
    }
  }
}
