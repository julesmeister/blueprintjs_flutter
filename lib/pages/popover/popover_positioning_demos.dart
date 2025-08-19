import 'package:flutter/material.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_popover.dart';
import '../../components/blueprint_card.dart';
import '../../components/blueprint_common.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';

class PopoverPositioningDemos {
  static Widget buildPositioningDemo(bool popoversEnabled) {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popover positioning options with automatic collision detection:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w500,
              color: BlueprintColors.textColorMuted,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Center(
            child: Container(
              padding: const EdgeInsets.all(BlueprintTheme.gridSize * 3),
              child: Column(
                children: [
                  // Top row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Top Left position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.topLeft,
                        disabled: !popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Top Left',
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Top Center position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.top,
                        disabled: !popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Top',
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Top Right position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.topRight,
                        disabled: !popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Top Right',
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BlueprintTheme.gridSize * 2),
                  
                  // Middle row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Left position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.left,
                        disabled: !popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Left',
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(BlueprintTheme.gridSize),
                        decoration: BoxDecoration(
                          color: BlueprintColors.lightGray3,
                          borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
                        ),
                        child: const Text(
                          'Target Element',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Right position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.right,
                        disabled: !popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Right',
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BlueprintTheme.gridSize * 2),
                  
                  // Bottom row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Bottom Left position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.bottomLeft,
                        disabled: !popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Bottom Left',
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Bottom Center position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.bottom,
                        disabled: !popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Bottom',
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Bottom Right position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.bottomRight,
                        disabled: !popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Bottom Right',
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}