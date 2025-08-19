import 'package:flutter/material.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_input.dart';
import '../../components/blueprint_common.dart';
import '../../components/blueprint_card.dart';

class TextAreaDemoSection extends StatelessWidget {
  const TextAreaDemoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      padding: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Text Area (Multi-line)',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintInputGroup(
              placeholder: 'Enter multiple lines of text...',
              maxLines: 4,
              fill: true,
              leftIcon: Icons.notes,
            ),
            const SizedBox(height: 16),
            
            Text(
              'Large Text Area',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintInputGroup(
              placeholder: 'Large text area for longer content...',
              maxLines: 6,
              size: BlueprintInputSize.large,
              fill: true,
              intent: BlueprintIntent.primary,
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Success Text Area',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: BlueprintColors.gray1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlueprintInputGroup(
                        placeholder: 'Success message...',
                        maxLines: 3,
                        intent: BlueprintIntent.success,
                        leftIcon: Icons.check_circle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Warning Text Area',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: BlueprintColors.gray1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlueprintInputGroup(
                        placeholder: 'Warning message...',
                        maxLines: 3,
                        intent: BlueprintIntent.warning,
                        leftIcon: Icons.warning,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}