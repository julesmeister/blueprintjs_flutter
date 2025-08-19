import 'package:flutter/material.dart';
import 'lib/components/blueprint_input.dart';
import 'lib/components/blueprint_input_custom.dart';
import 'lib/theme/blueprint_theme.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'SF Pro Text',
    ),
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Original BlueprintInputGroup:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              BlueprintInputGroup(
                placeholder: 'Search...',
                leftIcon: Icons.search,
              ),
              SizedBox(height: 20),
              
              Text('Custom BlueprintInputGroupCustom:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              BlueprintInputGroupCustom(
                placeholder: 'Search...',
                leftIcon: Icons.search,
              ),
              SizedBox(height: 20),
              
              Text('Original without icon:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              BlueprintInputGroup(
                placeholder: 'Enter text...',
              ),
              SizedBox(height: 20),
              
              Text('Custom without icon:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              BlueprintInputGroupCustom(
                placeholder: 'Enter text...',
              ),
            ],
          ),
        ),
      ),
    ),
  ));
}