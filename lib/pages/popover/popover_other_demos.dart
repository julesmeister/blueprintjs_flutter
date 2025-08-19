import 'package:flutter/material.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_popover.dart';
import '../../components/blueprint_menu.dart';
import '../../components/blueprint_card.dart';
import '../../components/blueprint_common.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';

class PopoverOtherDemos {
  static Widget buildConfirmationPopovers(Function(String) showSnackBar) {
    return Wrap(
      spacing: BlueprintTheme.gridSize * 2,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintPopovers.confirmation(
          title: 'Delete Item',
          message: 'Are you sure you want to delete this item? This action cannot be undone.',
          onConfirm: () => showSnackBar('Item deleted'),
          onCancel: () => showSnackBar('Deletion cancelled'),
          child: const BlueprintButton(
            text: 'Delete Item',
            intent: BlueprintIntent.danger,
            icon: Icons.delete,
          ),
        ),
        BlueprintPopovers.confirmation(
          title: 'Save Changes',
          message: 'Do you want to save your changes before closing?',
          confirmText: 'Save',
          cancelText: 'Discard',
          confirmIntent: BlueprintIntent.primary,
          position: BlueprintPopoverPosition.top,
          onConfirm: () => showSnackBar('Changes saved'),
          onCancel: () => showSnackBar('Changes discarded'),
          child: const BlueprintButton(
            text: 'Close Document',
            variant: BlueprintButtonVariant.outlined,
            icon: Icons.close,
          ),
        ),
      ],
    );
  }

  static Widget buildIntentPopovers(bool popoversEnabled) {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popovers with different intent colors and styling:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w500,
              color: BlueprintColors.textColorMuted,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Wrap(
            spacing: BlueprintTheme.gridSize,
            runSpacing: BlueprintTheme.gridSize,
            children: [
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Primary action popover with important information.'),
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Primary',
                  intent: BlueprintIntent.primary,
                  size: BlueprintButtonSize.small,
                ),
              ),
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Success popover indicating completed actions.'),
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Success',
                  intent: BlueprintIntent.success,
                  size: BlueprintButtonSize.small,
                ),
              ),
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Warning popover for important notifications.'),
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Warning',
                  intent: BlueprintIntent.warning,
                  size: BlueprintButtonSize.small,
                ),
              ),
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Danger popover for destructive or critical actions.'),
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Danger',
                  intent: BlueprintIntent.danger,
                  size: BlueprintButtonSize.small,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildInteractiveContentDemo(bool popoversEnabled, int clickCount, Function(int) updateClickCount, Function(String) showSnackBar) {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popovers can contain interactive elements and complex layouts:',
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
                content: Container(
                  width: 200,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Click Counter',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: BlueprintTheme.gridSize),
                      Text('Count: $clickCount'),
                      const SizedBox(height: BlueprintTheme.gridSize),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BlueprintButton(
                            text: '+',
                            size: BlueprintButtonSize.small,
                            onPressed: () => updateClickCount(clickCount + 1),
                          ),
                          BlueprintButton(
                            text: '-',
                            size: BlueprintButtonSize.small,
                            variant: BlueprintButtonVariant.outlined,
                            onPressed: () => updateClickCount(clickCount - 1),
                          ),
                          BlueprintButton(
                            text: 'Reset',
                            size: BlueprintButtonSize.small,
                            variant: BlueprintButtonVariant.minimal,
                            onPressed: () => updateClickCount(0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                interaction: BlueprintPopoverInteraction.click,
                position: BlueprintPopoverPosition.bottom,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Interactive Content',
                  icon: Icons.touch_app,
                  variant: BlueprintButtonVariant.outlined,
                ),
              ),
              BlueprintPopover(
                content: Container(
                  width: 250,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Actions',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: BlueprintTheme.gridSize),
                      const Text('Choose an action to perform:'),
                      const SizedBox(height: BlueprintTheme.gridSize),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: BlueprintButton(
                              text: 'Send Email',
                              icon: Icons.email,
                              variant: BlueprintButtonVariant.outlined,
                              onPressed: () => showSnackBar('Email sent!'),
                            ),
                          ),
                          const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                          SizedBox(
                            width: double.infinity,
                            child: BlueprintButton(
                              text: 'Export Data',
                              icon: Icons.download,
                              variant: BlueprintButtonVariant.outlined,
                              onPressed: () => showSnackBar('Data exported!'),
                            ),
                          ),
                          const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                          SizedBox(
                            width: double.infinity,
                            child: BlueprintButton(
                              text: 'Generate Report',
                              icon: Icons.assignment,
                              variant: BlueprintButtonVariant.outlined,
                              onPressed: () => showSnackBar('Report generated!'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                interaction: BlueprintPopoverInteraction.click,
                position: BlueprintPopoverPosition.left,
                disabled: !popoversEnabled,
                child: const BlueprintButton(
                  text: 'Action Menu',
                  icon: Icons.apps,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildRealWorldExamples(bool popoversEnabled, Function(String) showSnackBar) {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Common pattern for displaying contextual actions and help information.',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w500,
              color: BlueprintColors.textColorMuted,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Container(
            padding: const EdgeInsets.all(BlueprintTheme.gridSize),
            decoration: BoxDecoration(
              color: BlueprintColors.lightGray5,
              borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
              border: Border.all(color: BlueprintColors.gray5),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Document Settings',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: BlueprintTheme.gridSize * 0.5),
                      Text(
                        'Configure document properties and sharing options.',
                        style: TextStyle(color: BlueprintColors.textColorMuted),
                      ),
                    ],
                  ),
                ),
                BlueprintPopover(
                  content: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Document settings allow you to configure:\n'
                      '• Title and description\n'
                      '• Access permissions\n'
                      '• Sharing options\n'
                      '• Export formats',
                    ),
                  ),
                  interaction: BlueprintPopoverInteraction.hover,
                  position: BlueprintPopoverPosition.top,
                  disabled: !popoversEnabled,
                  child: const BlueprintButton(
                    icon: Icons.help_outline,
                    variant: BlueprintButtonVariant.minimal,
                    size: BlueprintButtonSize.small,
                  ),
                ),
                const SizedBox(width: BlueprintTheme.gridSize),
                BlueprintButton(
                  text: 'Edit Settings',
                  icon: Icons.settings,
                  size: BlueprintButtonSize.small,
                  onPressed: () => showSnackBar('Settings dialog opened'),
                ),
                const SizedBox(width: BlueprintTheme.gridSize * 0.5),
                BlueprintButton(
                  text: 'Print',
                  icon: Icons.print,
                  variant: BlueprintButtonVariant.outlined,
                  size: BlueprintButtonSize.small,
                  onPressed: () => showSnackBar('Print dialog opened'),
                ),
                const SizedBox(width: BlueprintTheme.gridSize),
                BlueprintPopovers.menu(
                  items: [
                    BlueprintMenuItem(
                      text: 'Undo',
                      icon: Icons.undo,
                      onTap: () => showSnackBar('Undo'),
                    ),
                    BlueprintMenuItem(
                      text: 'Redo',
                      icon: Icons.redo,
                      onTap: () => showSnackBar('Redo'),
                    ),
                    BlueprintMenuDivider(),
                    BlueprintMenuItem(
                      text: 'Cut',
                      icon: Icons.content_cut,
                      onTap: () => showSnackBar('Cut'),
                    ),
                    BlueprintMenuItem(
                      text: 'Copy',
                      icon: Icons.content_copy,
                      onTap: () => showSnackBar('Copy'),
                    ),
                    BlueprintMenuItem(
                      text: 'Paste',
                      icon: Icons.content_paste,
                      onTap: () => showSnackBar('Paste'),
                    ),
                  ],
                  child: IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}