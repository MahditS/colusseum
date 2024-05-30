import 'dart:math';

import 'package:colusseum/features/db_helper/constants.dart';
import 'package:colusseum/features/db_helper/mongodb.dart';
import 'package:colusseum/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Wait_Page extends StatefulWidget {
  const Wait_Page({super.key});

  @override
  State<Wait_Page> createState() => _Wait_PageState();
}

class _Wait_PageState extends State<Wait_Page> {
  String winOrLose = 'Waiting For Opponent to Finish';
  int sub = 0;
  var exp;
  var lvl;
  var coins;
  var players = [];
  var scores = [];
  var og_scores = [];
  var isWine = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, 
      body: Column
      (
        children: 
        [
          Center(
            child: Card(
                    color: Color.fromARGB(224, 225, 67, 67),
                    child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(winOrLose, style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 20),),
                  ),),
          ),
          Center(
            child: GestureDetector(
              onTap: () async
              {
                var arr = await MongoDatabase.findMatch(currentMatch);
                var arr2 = await MongoDatabase.findUser(currentUserDart);
                for(var doc in arr)
                {
                   sub = doc["Submissions"];
                   players = doc["Players"];
                   scores = doc["Scores"];
                   og_scores = List<int>.from(doc['Scores']); 
                   scores.sort();
                   scores = scores.reversed.toList();
                }
                
                if(sub == 2 && scores[0] != scores[1])
                {
                  var highScore = scores[0];
                  var highScoreIndex = og_scores.indexOf(highScore);
                  var winner = players[highScoreIndex];
                  setState(() {
                    winOrLose = "The Victor Is: " + winner;
                  });
                  print(og_scores);
                  print(scores);
                  print(players);
                  print(highScore);
                  print(highScoreIndex);
                  print(winner);
                  if(winner == currentUserDart)
                  {
                    MongoDatabase.win1();
                    MongoDatabase.win2();
                    for(var doc in arr2)
                    {
                    exp = doc["Exp"];
                    lvl = doc["Level"];
                    coins = doc["Coins"];
                    }
                    MongoDatabase.win3((exp/100).floor());
                    currentUserExp = exp;
                    currentUserLevel = lvl;
                    currentUserCoins = coins;
                  }
                  isWine = 1;
                }
                else if(sub == 2 && scores[0] == scores[1])
                {
                  setState((){
                    winOrLose = "The Victor Is " + players[0];
                  });
                  isWine = 1;
                }
            
              },
              child: Card(
                      color: Color.fromARGB(224, 225, 67, 67),
                      child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Refresh", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 20),),
                    ),),
            ),
          ),
          Expanded(child:         
          ListView.builder(
          itemCount: isWine,
          itemBuilder: (BuildContext context, int index) {
          return Center(
            child: GestureDetector(
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()))},
              child: Card(
                          color: Color.fromARGB(224, 225, 67, 67),
                          child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Return To Home", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 20),),
                        ),),
            ),
          );
  }),),
        ],
      ),
    );
  }
}