import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_alert.dart';
import '../components/demo_page_scaffold.dart';
import '../components/blueprint_common.dart';

class AlertDemoPage extends StatelessWidget {
  const AlertDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Alerts',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Basic Alerts', _buildBasicAlerts(context)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Confirmation Dialogs', _buildConfirmationDialogs(context)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Custom Alerts', _buildCustomAlerts(context)),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: BlueprintTheme.fontSizeLarge,
            fontWeight: FontWeight.w600,
            color: BlueprintColors.headingColor,
          ),
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        content,
      ],
    );
  }

  Widget _buildBasicAlerts(BuildContext context) {
    final buttons = [
      BlueprintButton(
        text: 'Info Alert',
        intent: BlueprintIntent.primary,
        icon: Icons.info_outline,
        onPressed: () => BlueprintAlertHelper.showInfo(
          context: context,
          title: 'Information',
          content: const Text('This is an informational alert with some helpful details.'),
        ),
      ),
      BlueprintButton(
        text: 'Success Alert',
        intent: BlueprintIntent.success,
        icon: Icons.check_circle_outline,
        onPressed: () => BlueprintAlertHelper.showSuccess(
          context: context,
          title: 'Success!',
          content: const Text('Your operation completed successfully.'),
        ),
      ),
      BlueprintButton(
        text: 'Warning Alert',
        intent: BlueprintIntent.warning,
        icon: Icons.warning_amber_outlined,
        onPressed: () => BlueprintAlertHelper.showWarning(
          context: context,
          title: 'Warning',
          content: const Text('Please be careful with this action. It may have consequences.'),
        ),
      ),
      BlueprintButton(
        text: 'Error Alert',
        intent: BlueprintIntent.danger,
        icon: Icons.error_outline,
        onPressed: () => BlueprintAlertHelper.showError(
          context: context,
          title: 'Error',
          content: const Text('Something went wrong. Please try again later.'),
        ),
      ),
    ];
    
    return _buildTwoColumnLayout(buttons);
  }

  Widget _buildTwoColumnLayout(List<Widget> buttons) {
    final List<Widget> rows = [];
    
    for (int i = 0; i < buttons.length; i += 2) {
      final List<Widget> rowChildren = [
        Expanded(child: buttons[i]),
      ];
      
      if (i + 1 < buttons.length) {
        rowChildren.add(const SizedBox(width: BlueprintTheme.gridSize));
        rowChildren.add(Expanded(child: buttons[i + 1]));
      } else {
        rowChildren.add(const Expanded(child: SizedBox()));
      }
      
      rows.add(Row(children: rowChildren));
      if (i + 2 < buttons.length) {
        rows.add(const SizedBox(height: BlueprintTheme.gridSize));
      }
    }
    
    return Column(children: rows);
  }

  Widget _buildConfirmationDialogs(BuildContext context) {
    final buttons = [
      BlueprintButton(
        text: 'Delete Item',
        intent: BlueprintIntent.danger,
        icon: Icons.delete_outline,
        onPressed: () async {
          final result = await BlueprintAlertHelper.showConfirm(
            context: context,
            title: 'Delete Item',
            content: const Text('Are you sure you want to delete this item? This action cannot be undone.'),
            confirmText: 'Delete',
            cancelText: 'Cancel',
            intent: BlueprintIntent.danger,
          );
          _showSnackBar(context, result == true ? 'Item deleted' : 'Delete cancelled');
        },
      ),
      BlueprintButton(
        text: 'Save Changes',
        intent: BlueprintIntent.primary,
        icon: Icons.save_outlined,
        onPressed: () async {
          final result = await BlueprintAlertHelper.showConfirm(
            context: context,
            title: 'Save Changes',
            content: const Text('Do you want to save your changes before leaving?'),
            confirmText: 'Save',
            cancelText: 'Discard',
            intent: BlueprintIntent.primary,
          );
          _showSnackBar(context, result == true ? 'Changes saved' : 'Changes discarded');
        },
      ),
      BlueprintButton(
        text: 'Logout',
        intent: BlueprintIntent.warning,
        icon: Icons.logout,
        onPressed: () async {
          final result = await BlueprintAlertHelper.showConfirm(
            context: context,
            title: 'Logout',
            content: const Text('Are you sure you want to logout?'),
            confirmText: 'Logout',
            cancelText: 'Stay',
            intent: BlueprintIntent.warning,
          );
          _showSnackBar(context, result == true ? 'Logged out' : 'Staying logged in');
        },
      ),
    ];
    
    return _buildTwoColumnLayout(buttons);
  }

  Widget _buildCustomAlerts(BuildContext context) {
    final buttons = [
      BlueprintButton(
        text: 'Rich Content Alert',
        intent: BlueprintIntent.primary,
        onPressed: () => BlueprintAlertHelper.show(
          context: context,
          title: 'Rich Content',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('This alert contains rich content:'),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.check, color: BlueprintColors.intentSuccess, size: 16),
                  SizedBox(width: 4),
                  Text('Feature 1'),
                ],
              ),
              const Row(
                children: [
                  Icon(Icons.check, color: BlueprintColors.intentSuccess, size: 16),
                  SizedBox(width: 4),
                  Text('Feature 2'),
                ],
              ),
              const Row(
                children: [
                  Icon(Icons.check, color: BlueprintColors.intentSuccess, size: 16),
                  SizedBox(width: 4),
                  Text('Feature 3'),
                ],
              ),
            ],
          ),
          icon: Icons.featured_play_list,
        ),
      ),
      BlueprintButton(
        text: 'No Icon Alert',
        intent: BlueprintIntent.none,
        onPressed: () => BlueprintAlertHelper.show(
          context: context,
          title: 'Simple Alert',
          content: const Text('This is a simple alert without an icon.'),
        ),
      ),
      BlueprintButton(
        text: 'Long Content Alert',
        intent: BlueprintIntent.primary,
        onPressed: () => BlueprintAlertHelper.show(
          context: context,
          title: 'Terms and Conditions',
          content: const SingleChildScrollView(
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
              'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
              'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
              'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia '
              'deserunt mollit anim id est laborum.\n\n'
              'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium '
              'doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore '
              'veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
            ),
          ),
          confirmText: 'I Agree',
          cancelText: 'Cancel',
          icon: Icons.article_outlined,
        ),
      ),
    ];
    
    return _buildTwoColumnLayout(buttons);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentPrimary,
      ),
    );
  }
}