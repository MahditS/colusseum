import 'package:colusseum/features/db_helper/constants.dart';
import 'package:colusseum/features/user_auth/presentation/pages/quiz_page.dart';
import 'package:colusseum/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter/material.dart';

import '../../../db_helper/mongodb.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  TextEditingController code = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: const Text("Join with code"),),
      body: Column
      (
        children: 
        [
          const SizedBox(height: 25),
          const Text("Enter code here", style:TextStyle(color: Color.fromARGB(255, 255, 119, 119), fontWeight: FontWeight.bold, fontSize: 35),),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 500),
            child: FormContainerWidget(hintText: "Match Code here", isPasswordField: false, controller: code,),
          ),
          const SizedBox(height: 25),
          GestureDetector(
          onTap: ()
          async {
            // if(MongoDatabase.findMatch(code.text) != null)
            // {
            var subs = 0;
            var arr = await MongoDatabase.findMatch(code.text);
            for (var doc in arr)
            {
               subs = doc["Submissions"];
            }
            print(arr);
            if(arr.isEmpty || subs >= 2)
            {
              print("No Such Match!");
            }
            else
            {
            currentMatch = code.text;
            Navigator.push(context,MaterialPageRoute(builder: (context) => const QuizPage()));
            }
            // }

          },
            child: const Card(
              color: Color.fromARGB(224, 225, 67, 67),
              child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("Join Match", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 25),),
            ),),
          )

        ],
      ),
    );
  }
}