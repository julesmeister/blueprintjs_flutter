import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Test 1: Simple input with placeholder
              Container(
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 14, height: 1.0),
                        decoration: InputDecoration(
                          hintText: 'Placeholder text',
                          hintStyle: TextStyle(fontSize: 14, height: 1.0),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              
              // Test 2: Input with icon and placeholder
              Container(
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12, right: 8),
                      child: Icon(Icons.search, size: 16),
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 14, height: 1.0),
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(fontSize: 14, height: 1.0),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ));
}