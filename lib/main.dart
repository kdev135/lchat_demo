import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lchat/firebase_options.dart';
import 'package:lchat/screens/home_screen.dart';
import 'package:lchat/screens/login_screen.dart';

void main() async{
  
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
 runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
final FirebaseAuth auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home:auth.currentUser !=null ?  HomeScreen() :  LoginScreen(),
    );
  }
}
