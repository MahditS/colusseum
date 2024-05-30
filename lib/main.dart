import 'package:colusseum/features/app/splash_screen/splash_screen.dart';
import 'package:colusseum/features/db_helper/mongodb.dart';
import 'package:colusseum/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  

  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();

  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyBnDKJCk5QMrUxxLgTM6seN_CkLVR2O_x0", appId: "1:792388898191:web:d4ada8b951975cb2760ffa", messagingSenderId: "792388898191", projectId: "colusseum-ea5ba"));
  

  await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Colosseum',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(child: LoginPage(),),
    );
  }
}

