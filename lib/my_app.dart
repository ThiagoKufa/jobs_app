import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobsApp',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}
