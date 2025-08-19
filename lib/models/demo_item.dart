import 'package:flutter/material.dart';

/// Model class representing a demo item in the Blueprint component showcase
class DemoItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget? page;

  DemoItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.page,
  });
}