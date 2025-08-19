import 'package:flutter/material.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_popover.dart';
import '../../components/blueprint_card.dart';
import '../../components/blueprint_common.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';

class PopoverBasicDemos {
  static Widget buildBasicPopovers(bool popoversEnabled, Function(String) showSnackBar) {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Click-triggered popovers with different content types and positioning options:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w500,
              color: BlueprintColors.textColorMuted,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Wrap(
            spacing: BlueprintTheme.gridSize * 2,
            runSpacing: BlueprintTheme.gridSize,
            children: [
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('This is a simple popover with some helpful content.'),
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Basic Popover',
                  intent: BlueprintIntent.primary,
                ),
              ),
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lightbulb, color: BlueprintColors.intentWarning, size: 32),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text(
                      'Pro Tip',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                    const Text('Popovers can contain rich content including icons, buttons, and more.'),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    BlueprintButton(
                      text: 'Got it!',
                      size: BlueprintButtonSize.small,
                      onPressed: () => showSnackBar('Tip acknowledged!'),
                    ),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.click,
                position: BlueprintPopoverPosition.top,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Rich Content',
                  variant: BlueprintButtonVariant.outlined,
                  icon: Icons.lightbulb_outline,
                ),
              ),
              BlueprintPopover(
                content: Container(
                  width: 250,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [BlueprintColors.blue1, BlueprintColors.blue3],
                          ),
                          borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
                        ),
                        child: const Center(
                          child: Text(
                            'Custom Content',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: BlueprintTheme.gridSize),
                      const Text('Popovers can contain any custom widgets and layouts.'),
                    ],
                  ),
                ),
                interaction: BlueprintPopoverInteraction.click,
                position: BlueprintPopoverPosition.right,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Custom Layout',
                  variant: BlueprintButtonVariant.minimal,
                  intent: BlueprintIntent.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}