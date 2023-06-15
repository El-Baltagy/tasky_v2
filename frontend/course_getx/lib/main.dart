import 'package:course_getx/app/auth/login.dart';
import 'package:course_getx/app/auth/signup.dart';
import 'package:course_getx/app/auth/success.dart';
import 'package:course_getx/app/home.dart';
import 'package:course_getx/app/notes/add.dart';
import 'package:course_getx/app/notes/edit.dart'; 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

late SharedPreferences sharedPref ; 
void main() async {  
  WidgetsFlutterBinding.ensureInitialized() ; 
  sharedPref = await SharedPreferences.getInstance() ;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course PHP Rest API',
      initialRoute:sharedPref.getString("id") == null ? "login" : "home",
      routes: {
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
        "home": (context) => Home(),
        "success": (context) => Success()   , 
        "addnotes": (context) => AddNotes()   , 
        "editnotes": (context) => EditNotes()   , 
      },
    );
  }
}
