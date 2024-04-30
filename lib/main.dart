import 'package:expenses/view/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            color: Colors.blue,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            )),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
