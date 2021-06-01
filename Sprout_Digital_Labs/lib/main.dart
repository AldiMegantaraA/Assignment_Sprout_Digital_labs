import 'package:flutter/material.dart';
import 'package:sprout_digital_labs/pages/contacts.dart';


void main() { 
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      home: GetUserData(),
    );
  }
}