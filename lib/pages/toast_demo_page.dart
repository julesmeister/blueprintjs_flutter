import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_toast.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_switch.dart';
import '../components/blueprint_section.dart';

class ToastDemoPage extends StatefulWidget {
  const ToastDemoPage({Key? key}) : super(key: key);

  @override
  State<ToastDemoPage> createState() => _ToastDemoPageState();
}

class _ToastDemoPageState extends State<ToastDemoPage> {
  final GlobalKey<BlueprintToasterState> _toasterKey = GlobalKey<BlueprintToasterState>();
  BlueprintToastPosition _position = BlueprintToastPosition.top;
  bool _includeAction = false;
  Duration _timeout = const Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    // Initialize global toaster when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_toasterKey.currentState != null) {
        BlueprintToasts.initialize(_toasterKey.currentState!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toast Components'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildControls(),
                const SizedBox(height: BlueprintTheme.gridSize * 2),
                _buildSection('Basic Toasts', _buildBasicToasts()),
                const SizedBox(height: BlueprintTheme.gridSize * 3),
                _buildSection('Intent-based Toasts', _buildIntentToasts()),
                const SizedBox(height: BlueprintTheme.gridSize * 3),
                _buildSection('Toasts with Actions', _buildActionToasts()),
                const SizedBox(height: BlueprintTheme.gridSize * 3),
                _buildSection('Custom Toasts', _buildCustomToasts()),
                const SizedBox(height: BlueprintTheme.gridSize * 3),
                _buildSection('Toast Features', _buildFeaturesDemo()),
              ],
            ),
          ),
          // Toast Container
          BlueprintToaster(
            key: _toasterKey,
            position: _position,
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize),
      decoration: BoxDecoration(
        color: BlueprintColors.lightGray5,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Toast Settings:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: BlueprintColors.headingColor,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          
          // Position Selection
          const Text('Position:', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: BlueprintTheme.gridSize * 0.5),
          Wrap(
            spacing: BlueprintTheme.gridSize,
            children: [
              for (final position in BlueprintToastPosition.values)
                GestureDetector(
                  onTap: () => setState(() => _position = position),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BlueprintTheme.gridSize,
                      vertical: BlueprintTheme.gridSize * 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: _position == position
                          ? BlueprintColors.intentPrimary
                          : BlueprintColors.lightGray3,
                      borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
                    ),
                    child: Text(
                      _positionToString(position),
                      style: TextStyle(
                        color: _position == position
                            ? Colors.white
                            : BlueprintColors.textColor,
                        fontSize: BlueprintTheme.fontSizeSmall,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: BlueprintTheme.gridSize),
          
          // Options
          Row(
            children: [
              BlueprintSwitches.withLabel(
                label: 'Include Action Button',
                value: _includeAction,
                onChanged: (value) => setState(() => _includeAction = value),
              ),
              const SizedBox(width: BlueprintTheme.gridSize * 2),
              BlueprintButton(
                text: 'Clear All Toasts',
                variant: BlueprintButtonVariant.minimal,
                intent: BlueprintIntent.danger,
                icon: Icons.clear_all,
                onPressed: () => _toasterKey.currentState?.clear(),
              ),
            ],
          ),
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

  Widget _buildBasicToasts() {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Show Basic Toast',
          onPressed: () => _showToast(
            message: 'This is a basic toast message',
          ),
        ),
        BlueprintButton(
          text: 'Show Toast with Icon',
          icon: Icons.info,
          onPressed: () => _showToast(
            message: 'Toast with custom icon',
            icon: Icons.star,
          ),
        ),
        BlueprintButton(
          text: 'Show Long Message',
          onPressed: () => _showToast(
            message: 'This is a much longer toast message that demonstrates how the toast handles longer text content that may wrap to multiple lines.',
          ),
        ),
      ],
    );
  }

  Widget _buildIntentToasts() {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Info Toast',
          intent: BlueprintIntent.primary,
          onPressed: () => BlueprintToasts.info(
            'This is an informational message',
            actionText: _includeAction ? 'Learn More' : null,
            onAction: _includeAction ? () => _showSnackBar('Learn More clicked') : null,
          ),
        ),
        BlueprintButton(
          text: 'Success Toast',
          intent: BlueprintIntent.success,
          onPressed: () => BlueprintToasts.success(
            'Operation completed successfully!',
            actionText: _includeAction ? 'View Details' : null,
            onAction: _includeAction ? () => _showSnackBar('View Details clicked') : null,
          ),
        ),
        BlueprintButton(
          text: 'Warning Toast',
          intent: BlueprintIntent.warning,
          onPressed: () => BlueprintToasts.warning(
            'Please review your settings',
            actionText: _includeAction ? 'Review' : null,
            onAction: _includeAction ? () => _showSnackBar('Review clicked') : null,
          ),
        ),
        BlueprintButton(
          text: 'Error Toast',
          intent: BlueprintIntent.danger,
          onPressed: () => BlueprintToasts.danger(
            'An error occurred while processing',
            actionText: _includeAction ? 'Retry' : null,
            onAction: _includeAction ? () => _showSnackBar('Retry clicked') : null,
          ),
        ),
      ],
    );
  }

  Widget _buildActionToasts() {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Toast with Undo',
          onPressed: () => _showToast(
            message: 'File deleted',
            intent: BlueprintIntent.success,
            actionText: 'Undo',
            onAction: () => _showSnackBar('File restored!'),
          ),
        ),
        BlueprintButton(
          text: 'Toast with Refresh',
          onPressed: () => _showToast(
            message: 'Connection lost',
            intent: BlueprintIntent.warning,
            actionText: 'Refresh',
            onAction: () => _showSnackBar('Refreshing...'),
          ),
        ),
        BlueprintButton(
          text: 'Toast with Details',
          onPressed: () => _showToast(
            message: 'Update available',
            intent: BlueprintIntent.primary,
            actionText: 'Update Now',
            onAction: () => _showSnackBar('Starting update...'),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomToasts() {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintButton(
          text: 'Persistent Toast',
          variant: BlueprintButtonVariant.outlined,
          onPressed: () => _showToast(
            message: 'This toast will not auto-dismiss',
            intent: BlueprintIntent.primary,
            timeout: Duration.zero, // No timeout
          ),
        ),
        BlueprintButton(
          text: 'Quick Toast (2s)',
          variant: BlueprintButtonVariant.outlined,
          onPressed: () => _showToast(
            message: 'Quick dismissing toast',
            timeout: const Duration(seconds: 2),
          ),
        ),
        BlueprintButton(
          text: 'Custom Icon Toast',
          variant: BlueprintButtonVariant.outlined,
          onPressed: () => _showToast(
            message: 'Custom icon notification',
            icon: Icons.notifications,
            intent: BlueprintIntent.success,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesDemo() {
    return BlueprintSections.simple(
      title: 'Features Overview',
      children: [
        const Text(
          'Toast Features:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        const Text('• Automatic dismissal after timeout (configurable)'),
        const Text('• Hover to pause auto-dismiss timer'),
        const Text('• Multiple positioning options (top, bottom, corners)'),
        const Text('• Intent-based styling (primary, success, warning, danger)'),
        const Text('• Optional action buttons for user interaction'),
        const Text('• Custom icons and persistent toasts'),
        const Text('• Smooth slide and fade animations'),
        const Text('• Global toast management system'),
        const SizedBox(height: BlueprintTheme.gridSize),
        
        const Text(
          'Usage Patterns:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 0.5),
        const Text('• Use info toasts for general notifications'),
        const Text('• Use success toasts for completed operations'),
        const Text('• Use warning toasts for important notices'),
        const Text('• Use error toasts for failures that need attention'),
        const Text('• Add action buttons for recoverable errors or related actions'),
        const Text('• Use persistent toasts for critical information'),
      ],
    );
  }

  String _positionToString(BlueprintToastPosition position) {
    switch (position) {
      case BlueprintToastPosition.top:
        return 'Top';
      case BlueprintToastPosition.topLeft:
        return 'Top Left';
      case BlueprintToastPosition.topRight:
        return 'Top Right';
      case BlueprintToastPosition.bottom:
        return 'Bottom';
      case BlueprintToastPosition.bottomLeft:
        return 'Bottom Left';
      case BlueprintToastPosition.bottomRight:
        return 'Bottom Right';
    }
  }

  void _showToast({
    required String message,
    BlueprintIntent intent = BlueprintIntent.none,
    IconData? icon,
    Duration timeout = const Duration(seconds: 5),
    String? actionText,
    VoidCallback? onAction,
  }) {
    _toasterKey.currentState?.show(BlueprintToastOptions(
      message: message,
      intent: intent,
      icon: icon,
      timeout: timeout,
      actionText: actionText,
      onAction: onAction,
      key: DateTime.now().millisecondsSinceEpoch.toString(),
    ));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentPrimary,
      ),
    );
  }
}