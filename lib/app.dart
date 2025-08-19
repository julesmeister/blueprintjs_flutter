import 'package:flutter/material.dart';
import 'theme/blueprint_theme.dart';
import 'pages/home_page.dart';

/// Main Blueprint Flutter Demo Application
class BlueprintDemoApp extends StatelessWidget {
  const BlueprintDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blueprint Flutter Demo',
      theme: BlueprintTheme.lightTheme,
      darkTheme: BlueprintTheme.darkTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}