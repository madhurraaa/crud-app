// import 'package:crud_app/views/bottomnavbar.dart';
import 'package:crud_app/views/login.dart';
// import 'package:crud_app/views/login.dart';
// import 'package:crud_app/views/viewusers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,      
      home: LoginScreen(),
    );
  }
}