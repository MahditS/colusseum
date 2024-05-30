import 'package:colusseum/features/db_helper/constants.dart';
import 'package:colusseum/features/db_helper/mongodb.dart';
import 'package:colusseum/features/user_auth/presentation/pages/wait_page.dart';
import 'package:colusseum/features/user_auth/presentation/widgets/question_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  String _userEmail = ' ';
  List<String> questions = [];
  List<String> optionA = [];
  List<String> optionB = [];
  List<String> optionC = [];
  List<String> optionD = [];
  List<String> answers = [];
  List<String> playerAnswers = [];
  var corrects = 0;
  var controllers = [];
  TextStyle sty = TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 20);
  TextStyle qsty = TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 35);


  

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
     setState(() {_userEmail = user.email!;});
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
   
    
    return Scaffold
    (
    backgroundColor: Colors.black87, 
    appBar: AppBar(title: Text(currentMatch, style: const TextStyle(color: Color.fromARGB(255, 45, 45, 45), fontWeight: FontWeight.bold, fontSize: 15),)),
    body: Column(
    crossAxisAlignment: CrossAxisAlignment.start,  
    children: 
    [
      GestureDetector(
          onTap: ()
          async 
          {
           var arr = await MongoDatabase.findMatch(currentMatch);
           var qs;
           var a;
           var b;
           var c;
           var d;
           var ans;
           for(var doc in arr)
           {
            qs = doc['Questions'];
            a = doc['OptionA'];
            b = doc['OptionB'];
            c = doc['OptionC'];
            d = doc['OptionD'];
            ans = doc['Correct'];
            setState(() 
            {
            questions.addAll(qs.cast<String>());
            optionA.addAll(a.cast<String>());
            optionB.addAll(b.cast<String>());
            optionC.addAll(c.cast<String>());
            optionD.addAll(d.cast<String>());
            answers.addAll(ans.cast<String>()); 

            });
            
           }
           setState(() {
           questions = questions.toSet().toList();
           optionA = optionA.toSet().toList();
           optionB = optionB.toSet().toList();
           optionC = optionC.toSet().toList();
           optionD = optionD.toSet().toList();
          //  answers = answers.toSet().toList();
           });
          
           for(String i in questions)
           {
            controllers.add(TextEditingController());
           }

          },
            child: const Card(
              color: Color.fromARGB(224, 225, 67, 67),
              child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Start Quiz", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 10),),
            ),),
          ),
          
          Expanded(child:         
          ListView.builder(
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
          // print(optionA[1]);
          return QuestionWidget
          (
            question: Text(questions[index], style: qsty),
            optionA: Text(optionA[index], style: sty,),
            optionB: Text(optionB[index], style: sty,),
            optionC: Text(optionC[index], style: sty,),
            optionD: Text(optionD[index], style: sty,),
            controller: controllers[index],
          );
  }),),
          GestureDetector(
            onTap: ()
            {
            corrects = 0;
            while(playerAnswers.length != controllers.length)
            {
            for(TextEditingController textcont in controllers)
            {
              playerAnswers.add(textcont.text);
            }  
            }
            for (int i = 0; i < questions.length; i++) {
            
            if(answers[i].toLowerCase() == playerAnswers[i].toLowerCase())
            {
              corrects++;
            }
            if(playerAnswers[i] == "Zeus" && currentUserBolts > 0)
            {
              print("Zeus Used");
              corrects++;
              MongoDatabase.deductBolt();
            }
            }
            MongoDatabase.addPlayerScore(corrects * 1000);
            MongoDatabase.submit();
            print(corrects * 1000);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Wait_Page()));
            // print(answers);
            },
            child: Center(
              child: Card(
                  color: Color.fromARGB(224, 225, 67, 67),
                  child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Submit", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 20),),
                ),),
            ),
          ),
          ]
          ),

    );
  }
}