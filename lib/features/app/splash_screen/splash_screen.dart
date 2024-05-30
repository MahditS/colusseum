import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   final Widget child;
  const SplashScreen({super.key, required this.child});
 

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState()
  {
    super.initState();
    Future.delayed(const Duration(seconds: 3), 
                  (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child), 
                      (route) => false);
                    }
                  );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 300,),
            Text("Colosseum", style: TextStyle(color: Color.fromARGB(255, 255, 119, 119), fontSize: 35, fontWeight: FontWeight.bold),),
            Text("Study To The Death", style: TextStyle(color: Color.fromARGB(255,255,119,119), fontSize: 15))
          ],
        ),
    ));
  }
}