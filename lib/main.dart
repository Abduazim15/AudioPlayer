import 'package:abookplayer/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          background: Colors.grey.shade900,
          primary: Colors.grey.shade600,
          secondary: Colors.grey.shade800,
          inversePrimary: Colors.grey.shade300
        )

      ),
    );
  }
}
