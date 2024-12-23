import 'package:flutter/material.dart';

import 'Features/Home/Ui/home.dart';

void main(){
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Colors.grey.shade600,
        )
      ),
      home: Home(),
    );
  }
}
