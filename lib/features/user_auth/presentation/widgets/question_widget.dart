import 'package:colusseum/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final Text? question; 
  final Text? optionA;
  final Text? optionB;
  final Text? optionC;
  final Text? optionD;
  final TextEditingController? controller;
  const QuestionWidget({super.key, this.question, this.optionA, this.optionB,  this.optionC, this.optionD, this.controller});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column
    (
      crossAxisAlignment: CrossAxisAlignment.center,
      children: 
      [
        Card
        (
          color: Color.fromARGB(223, 255, 137, 253),
          child: Padding(

            padding: const EdgeInsets.all(40),
            child: widget.question,
          ),
        ),
        // SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card
            (
              color: Color.fromARGB(223, 255, 71, 71),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                child: widget.optionA,
              ),
            ),
            Card
        (
          color: Color.fromARGB(223, 84, 121, 255),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
            child: widget.optionB,
          ),
        ),
          ],
        ),
        Row(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card
            (
              color: Color.fromARGB(223, 252, 255, 105),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                child: widget.optionC,
              ),
            ),
            Card
        (
          color: Color.fromARGB(223, 144, 255, 100),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left:10, top: 10, bottom: 10),
            child: widget.optionD,
          ),
        )
          ],
        ),
        
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 695.0),
            child: FormContainerWidget
            (
              controller: widget.controller,
              hintText: "Answer",
              isPasswordField: false,
            ),
          ),
        
      ],
    );
  }
}