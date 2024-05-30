import 'package:colusseum/features/db_helper/constants.dart';
import 'package:colusseum/features/db_helper/mongodb.dart';
import 'package:colusseum/features/user_auth/presentation/widgets/item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      backgroundColor: Colors.black87,
      appBar: AppBar(title: Text("Purchase accessories with winnings", style: TextStyle(color: Color.fromARGB(255, 45, 45, 45), fontWeight: FontWeight.bold, fontSize: 15),)),
      body: Column(children: 
      [
        Center(
          child: Card
              (
                color: Color.fromARGB(136, 59, 59, 59),
                child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
          children: 
          [
            Text("Bolt Of Zeus", style: TextStyle(color: Color.fromARGB(223, 255, 105, 105), fontWeight: FontWeight.bold, fontSize: 20),),
            Text("Bypass any question by typing Zeus in the answer box. Each Bolt can only bypass one question. Multiple bolts can be used in the same quiz", style: TextStyle(color: Color.fromARGB(223, 255, 105, 105), fontWeight: FontWeight.bold, fontSize: 20),),
            Text("Cost: 50, Req. Level: 3", style: TextStyle(color: Color.fromARGB(223, 255, 105, 105), fontWeight: FontWeight.bold, fontSize: 20),),
            GestureDetector(
              onTap: () => 
              {
              if(currentUserCoins >= 50 && currentUserLevel >= 3)
              {
                print("Bought"),
                MongoDatabase.purchaseBolt(),
                MongoDatabase.deductCash(50)
              }
              else
              {
                print("Not Enough Cash!")
              }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(223, 255, 82, 82),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding:  EdgeInsets.all(5),
                  child:  Text("Purchase", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                ),
              
              ),
            )
          ],
                ),
                  ),
              ),
        ),
      ],),
    );
  }
}