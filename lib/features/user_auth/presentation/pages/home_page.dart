
import 'package:colusseum/features/db_helper/constants.dart';
import 'package:colusseum/features/db_helper/mongodb.dart';
import 'package:colusseum/features/user_auth/presentation/pages/create_page.dart';
import 'package:colusseum/features/user_auth/presentation/pages/join_page.dart';
import 'package:colusseum/features/user_auth/presentation/pages/shop_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
    
  String _userEmail = ' ';

  @override
  initState()  {
    super.initState();
    Fluttertoast.showToast;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
     setState(() {_userEmail = user.email!;});
    }
    
  }

 
  
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      backgroundColor: Colors.black87,
      // ignore: prefer_const_constructors
      appBar: AppBar(title: Text(_userEmail, style: TextStyle(color: Color.fromARGB(255, 45, 45, 45), fontWeight: FontWeight.bold, fontSize: 15),)),
      body: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.account_circle, color: Colors.white, size: 200,),
              Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 80),
            child: Text("Welcome, Champion!", style: TextStyle(color: Color.fromARGB(255, 255, 119, 119), fontWeight: FontWeight.bold, fontSize: 50),),
          ),
            ],
          ),
          Text("Level " + currentUserLevel.toString(), style: TextStyle(color: Color.fromARGB(255, 255, 119, 119), fontWeight: FontWeight.bold, fontSize: 25),),
          Text("Money " + currentUserCoins.toString(), style: TextStyle(color: Color.fromARGB(255, 255, 119, 119), fontWeight: FontWeight.bold, fontSize: 25),),
          Text("Bolts Of Zeus " + currentUserBolts.toString(), style: TextStyle(color: Color.fromARGB(255, 255, 119, 119), fontWeight: FontWeight.bold, fontSize: 25),),
          GestureDetector(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePage()));},
            child: const Card(color: Color.fromARGB(224, 225, 67, 67), child: Padding(
              padding: EdgeInsets.all(15),
              child: Text("Start Match", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 29),),
            )),
          ),
          const SizedBox(height: 25,),
          GestureDetector(
            onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => const JoinPage()));},
            child: const Card(color: Color.fromARGB(224, 225, 67, 67), child: Padding(
              padding: EdgeInsets.all(15),
              child: Text("Join Match", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 29),),
            )),
          ),
          const SizedBox(height: 25,),
          GestureDetector(
            onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => const ShopPage()));},
            // ignore: prefer_const_constructors
            child: Card(color: Color.fromARGB(224, 225, 67, 67), child: Padding(
              padding: const EdgeInsets.all(15),
              child: const Text("Shop", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 29),),
            )),
          ),

          ],
      ),
    );
  
  }
  }