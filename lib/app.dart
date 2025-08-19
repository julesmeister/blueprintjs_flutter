import 'package:flutter/material.dart';
import 'theme/blueprint_theme.dart';
import 'pages/home_page.dart';

/// Main Blueprint Flutter Component Library Demo Application
class BlueprintFlutterApp extends StatelessWidget {
  const BlueprintFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blueprint.js Flutter Components',
      theme: BlueprintTheme.lightTheme,
      darkTheme: BlueprintTheme.darkTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}