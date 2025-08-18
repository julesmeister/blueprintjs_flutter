import 'package:flutter/material.dart';

class TooltipTest extends StatelessWidget {
  final Widget child;
  final String text;

  const TooltipTest({
    super.key,
    required this.child,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text,
      decoration: BoxDecoration(
        color: const Color(0xFF394B59),
        borderRadius: BorderRadius.circular(3),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      waitDuration: const Duration(milliseconds: 100),
      showDuration: const Duration(seconds: 30),
      child: child,
    );
  }
}

class BlueprintTooltipsTest {
  static Widget simple({
    required Widget child,
    required String content,
    bool disabled = false,
  }) {
    if (disabled) return child;
    return TooltipTest(child: child, text: content);
  }

  static Widget intent({
    required Widget child,
    required String content,
    required intent,
    bool disabled = false,
  }) {
    return simple(child: child, content: content, disabled: disabled);
  }

  static Widget compact({
    required Widget child,
    required String content,
    bool disabled = false,
  }) {
    return simple(child: child, content: content, disabled: disabled);
  }
}