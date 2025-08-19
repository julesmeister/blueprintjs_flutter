import 'package:flutter/material.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_tag.dart';
import '../../components/blueprint_popover.dart';
import '../../components/blueprint_card.dart';
import '../../components/blueprint_common.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';

class PopoverHoverDemos {
  static Widget buildHoverPopovers(bool popoversEnabled) {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hover-triggered popovers with configurable delays and positioning:',
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
                  child: Text('This popover appears on hover with a short delay.'),
                ),
                interaction: BlueprintPopoverInteraction.hover,
                position: BlueprintPopoverPosition.top,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Quick Hover',
                  variant: BlueprintButtonVariant.outlined,
                  intent: BlueprintIntent.primary,
                  icon: Icons.mouse,
                ),
              ),
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Delayed hover prevents accidental popover triggers. Useful for dense interfaces.'),
                ),
                interaction: BlueprintPopoverInteraction.hover,
                hoverOpenDelay: const Duration(milliseconds: 800),
                hoverCloseDelay: const Duration(milliseconds: 200),
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Delayed Hover',
                  variant: BlueprintButtonVariant.minimal,
                  icon: Icons.schedule,
                ),
              ),
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber, color: BlueprintColors.intentWarning, size: 24),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text(
                      'Important Notice',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                    const Text('This action requires attention'),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.hover,
                position: BlueprintPopoverPosition.left,
                disabled: !popoversEnabled,
                child: BlueprintTags.simple(
                  text: 'Warning',
                  intent: BlueprintIntent.warning,
                  icon: Icons.warning_amber,
                ),
              ),
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Hover popovers work great with buttons, icons, and interactive elements.'),
                ),
                interaction: BlueprintPopoverInteraction.hover,
                position: BlueprintPopoverPosition.top,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Help',
                  variant: BlueprintButtonVariant.outlined,
                  intent: BlueprintIntent.primary,
                  icon: Icons.help_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}