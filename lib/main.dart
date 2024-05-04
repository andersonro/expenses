import 'package:expenses/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt'), Locale('pt', 'BR')],
      title: 'Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
        //brightness: Brightness.light,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(color: Colors.white)),
        ),
        appBarTheme: const AppBarTheme(
            color: Colors.purple,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            iconTheme: IconThemeData(color: Colors.white)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
