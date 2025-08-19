import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import 'blueprint_button.dart';
import 'blueprint_navbar.dart';
import 'blueprint_common.dart';

class DemoPageScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const DemoPageScaffold({
    Key? key,
    required this.title,
    required this.child,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 16),
            child: BlueprintNavbar(
              padding: EdgeInsets.zero,
              children: [
                BlueprintButton(
                  icon: Icons.arrow_back,
                  variant: BlueprintButtonVariant.minimal,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: BlueprintTheme.gridSize),
                BlueprintNavbarHeading(text: title),
                if (actions != null) ...[
                  const Spacer(),
                  ...actions!,
                ],
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}