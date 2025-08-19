import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_dialog.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_input.dart';
import '../components/demo_page_scaffold.dart';
import '../components/blueprint_common.dart';

class DialogDemoPage extends StatelessWidget {
  const DialogDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Dialogs',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildSection('Basic Dialogs', _buildBasicDialogs(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Factory Method Dialogs', _buildFactoryDialogs(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Custom Dialogs', _buildCustomDialogs(context)),
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

  Widget _buildBasicDialogs(BuildContext context) {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Simple Dialog',
          intent: BlueprintIntent.primary,
          onPressed: () => _showSimpleDialog(context),
        ),
        BlueprintButton(
          text: 'Dialog with Icon',
          intent: BlueprintIntent.success,
          onPressed: () => _showDialogWithIcon(context),
        ),
        BlueprintButton(
          text: 'Dialog with Actions',
          intent: BlueprintIntent.warning,
          onPressed: () => _showDialogWithActions(context),
        ),
        BlueprintButton(
          text: 'No Close Button',
          intent: BlueprintIntent.danger,
          onPressed: () => _showNoCloseDialog(context),
        ),
      ],
    );
  }

  Widget _buildFactoryDialogs(BuildContext context) {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Alert Dialog',
          icon: Icons.info,
          onPressed: () => _showAlertDialog(context),
        ),
        BlueprintButton(
          text: 'Confirm Dialog',
          icon: Icons.help,
          onPressed: () => _showConfirmDialog(context),
        ),
        BlueprintButton(
          text: 'Prompt Dialog',
          icon: Icons.edit,
          onPressed: () => _showPromptDialog(context),
        ),
      ],
    );
  }

  Widget _buildCustomDialogs(BuildContext context) {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Large Dialog',
          variant: BlueprintButtonVariant.outlined,
          onPressed: () => _showLargeDialog(context),
        ),
        BlueprintButton(
          text: 'Form Dialog',
          variant: BlueprintButtonVariant.outlined,
          onPressed: () => _showFormDialog(context),
        ),
        BlueprintButton(
          text: 'List Dialog',
          variant: BlueprintButtonVariant.outlined,
          onPressed: () => _showListDialog(context),
        ),
      ],
    );
  }

  void _showSimpleDialog(BuildContext context) {
    BlueprintDialog.show(
      context: context,
      title: const Text('Welcome'),
      body: const Text('This is a simple Blueprint dialog with a title and body content.'),
    );
  }

  void _showDialogWithIcon(BuildContext context) {
    BlueprintDialog.show(
      context: context,
      title: const Text('Success'),
      icon: const Icon(Icons.check_circle, color: BlueprintColors.intentSuccess),
      body: const Text('Your action was completed successfully!'),
    );
  }

  void _showDialogWithActions(BuildContext context) {
    BlueprintDialog.show(
      context: context,
      title: const Text('Save Changes?'),
      icon: const Icon(Icons.save, color: BlueprintColors.intentWarning),
      body: const Text('You have unsaved changes. Would you like to save them before continuing?'),
      actions: [
        BlueprintButton(
          text: 'Cancel',
          variant: BlueprintButtonVariant.minimal,
          onPressed: () => Navigator.of(context).pop(),
        ),
        BlueprintButton(
          text: "Don't Save",
          variant: BlueprintButtonVariant.minimal,
          onPressed: () {
            Navigator.of(context).pop();
            _showSnackBar(context, 'Changes discarded');
          },
        ),
        BlueprintButton(
          text: 'Save',
          intent: BlueprintIntent.primary,
          onPressed: () {
            Navigator.of(context).pop();
            _showSnackBar(context, 'Changes saved');
          },
        ),
      ],
    );
  }

  void _showNoCloseDialog(BuildContext context) {
    BlueprintDialog.show(
      context: context,
      title: const Text('Modal Dialog'),
      body: const Text('This dialog cannot be closed by clicking outside or using the escape key.'),
      canEscapeKeyClose: false,
      canOutsideClickClose: false,
      isCloseButtonShown: false,
      actions: [
        BlueprintButton(
          text: 'OK',
          intent: BlueprintIntent.primary,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _showAlertDialog(BuildContext context) {
    BlueprintDialogs.alert(
      context: context,
      title: 'Information',
      message: 'This is an alert dialog created using the factory method.',
      icon: const Icon(Icons.info, color: BlueprintColors.intentPrimary),
      onConfirm: () => _showSnackBar(context, 'Alert acknowledged'),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    BlueprintDialogs.confirm(
      context: context,
      title: 'Delete Item',
      message: 'Are you sure you want to delete this item? This action cannot be undone.',
      icon: const Icon(Icons.warning, color: BlueprintColors.intentWarning),
      confirmText: 'Delete',
      cancelText: 'Keep',
      onConfirm: () => _showSnackBar(context, 'Item deleted'),
      onCancel: () => _showSnackBar(context, 'Deletion cancelled'),
    );
  }

  void _showPromptDialog(BuildContext context) async {
    final result = await BlueprintDialogs.prompt(
      context: context,
      title: 'Enter Name',
      message: 'Please enter your name:',
      placeholder: 'Your name here...',
      defaultValue: 'John Doe',
      icon: const Icon(Icons.person, color: BlueprintColors.intentPrimary),
    );

    if (context.mounted && result != null && result.isNotEmpty) {
      _showSnackBar(context, 'Hello, $result!');
    }
  }

  void _showLargeDialog(BuildContext context) {
    BlueprintDialog.show(
      context: context,
      title: const Text('Large Dialog'),
      width: 600,
      height: 400,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This is a larger dialog with custom dimensions.',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
              'nisi ut aliquip ex ea commodo consequat.',
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            const Text(
              'Duis aute irure dolor in reprehenderit in voluptate velit esse '
              'cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat '
              'cupidatat non proident, sunt in culpa qui officia deserunt mollit '
              'anim id est laborum.',
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: BlueprintColors.lightGray3,
                borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
              ),
              child: const Center(
                child: Text('Content area'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFormDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    BlueprintDialog.show(
      context: context,
      title: const Text('User Information'),
      icon: const Icon(Icons.person_add, color: BlueprintColors.intentPrimary),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Please fill in your information:'),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintInputGroup(
            placeholder: 'Full Name',
            leftIcon: Icons.person,
            controller: nameController,
            fill: true,
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintInputGroup(
            placeholder: 'Email Address',
            leftIcon: Icons.email,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            fill: true,
          ),
        ],
      ),
      actions: [
        BlueprintButton(
          text: 'Cancel',
          variant: BlueprintButtonVariant.minimal,
          onPressed: () => Navigator.of(context).pop(),
        ),
        BlueprintButton(
          text: 'Submit',
          intent: BlueprintIntent.primary,
          onPressed: () {
            Navigator.of(context).pop();
            _showSnackBar(context, 'Form submitted: ${nameController.text}');
          },
        ),
      ],
    );
  }

  void _showListDialog(BuildContext context) {
    final items = [
      'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
      'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon',
    ];

    BlueprintDialog.show(
      context: context,
      title: const Text('Select Item'),
      icon: const Icon(Icons.list, color: BlueprintColors.intentPrimary),
      body: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
              leading: const Icon(Icons.circle, size: 8),
              onTap: () {
                Navigator.of(context).pop();
                _showSnackBar(context, 'Selected: ${items[index]}');
              },
            );
          },
        ),
      ),
    );
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