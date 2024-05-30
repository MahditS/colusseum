import 'package:colusseum/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {

  
  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card
    (
      color: Colors.black54,
      child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: 
        [
          Text("Bolt Of Zeus", style: TextStyle(color: Color.fromARGB(224, 255, 67, 67), fontWeight: FontWeight.bold, fontSize: 20),),
          Text("Bypass any question by typing Zeus in the answer box. Each Bolt can only bypass one question. Multiple bolts can be used in the same quiz", style: TextStyle(color: Color.fromARGB(224, 255, 67, 67), fontWeight: FontWeight.bold, fontSize: 20),),
          Text("Cost: 50, Req. Level: 3", style: TextStyle(color: Color.fromARGB(224, 255, 67, 67), fontWeight: FontWeight.bold, fontSize: 20),),
        
        ],
      ),
                ),
    );
  }
}