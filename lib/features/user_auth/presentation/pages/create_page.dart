// ignore_for_file: prefer_const_constructors

// import 'dart:ffi';
import 'dart:math';
import 'package:colusseum/features/db_helper/mongodb.dart';
import 'package:colusseum/features/user_auth/presentation/pages/home_page.dart';
import 'package:colusseum/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late String matchCode;
  List<String> questions = [];
  List<String> optionA = [];
  List<String> optionB = [];
  List<String> optionC = [];
  List<String> optionD = [];
  List<String> corrects = [];
  TextEditingController qcont = TextEditingController();
  TextEditingController acont = TextEditingController();
  TextEditingController bcont = TextEditingController();
  TextEditingController ccont = TextEditingController();
  TextEditingController dcont = TextEditingController();
  TextEditingController correctCont = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Generate a random string of length 6 when the widget initializes
    matchCode = generateRandomString(6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('Create Match'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 500.0),
        child: Column(
            children: [
              Text(
                'Match Code: $matchCode',
                style:TextStyle(color: Color.fromARGB(255, 255, 119, 119), fontWeight: FontWeight.bold, fontSize: 50),
              ),
              SizedBox(height: 15),
              Text(
                'Create a question',
                style:TextStyle(color: Color.fromARGB(255, 255, 119, 119), fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 10),
              FormContainerWidget(
                controller: qcont,
                isPasswordField: false,
                hintText: "Question",
              ),
              SizedBox(height:10),
              FormContainerWidget(
                controller: acont,
                isPasswordField: false,
                hintText: "Option A",
              ),
              SizedBox(height:10),
              FormContainerWidget(
                controller: bcont,
                isPasswordField: false,
                hintText: "Option B",
              ),
              SizedBox(height:10),
              FormContainerWidget(
                controller: ccont,
                isPasswordField: false,
                hintText: "Option C",
              ),
              SizedBox(height:10),
              FormContainerWidget(
                controller: dcont,
                isPasswordField: false,
                hintText: "Option D",
              ),
              SizedBox(height:10),
              FormContainerWidget(
                controller: correctCont,
                isPasswordField: false,
                hintText: "Answer",
              ),
              GestureDetector(
              onTap: (){addQuestion(qcont.text, acont.text, bcont.text, ccont.text, dcont.text, correctCont.text);},
              child: Card(color: Color.fromARGB(224, 255, 67, 67), child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Add Question", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
              )),
            ),
              SizedBox(height: 10),
              GestureDetector(
              onTap: (){createMatch(); Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage()));},
              child: Card(color: Color.fromARGB(224, 225, 67, 67), child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Start Match", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
              )),
            ),
            ],
          ),
      ),
      );
  }

  void addQuestion(String q, String a, String b, String c, String d, String correct){
    questions.add(q);
    optionA.add(a);
    optionB.add(b);
    optionC.add(c);
    optionD.add(d);
    corrects.add(correct);
    ccont.clear();
    acont.clear();
    correctCont.clear();
    bcont.clear();
    dcont.clear();
    qcont.clear();
  }

  void createMatch(){
    print(questions);
    print(optionA);
    print(optionB);
    print(optionC);
    print(optionD);
    print(corrects);
    MongoDatabase.insertQuestion(matchCode, questions, optionA, optionB, optionC, optionD, corrects);


  }
  // Function to generate a random string
  String generateRandomString(int length) {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789_/!@#%&';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}
