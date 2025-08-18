import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_button.dart';

// Reusable tab content widget
class TabContent extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const TabContent({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BlueprintTheme.gridSize),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: BlueprintTheme.gridSize),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: BlueprintTheme.fontSizeLarge,
                    fontWeight: FontWeight.w600,
                    color: BlueprintColors.headingColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          Text(
            description,
            style: const TextStyle(
              color: BlueprintColors.textColorMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          BlueprintButton(
            text: 'Action Button',
            intent: BlueprintIntent.primary,
            icon: Icons.play_arrow,
            onPressed: () => _showSnackBar(context, 'Action button pressed in $title'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentPrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}