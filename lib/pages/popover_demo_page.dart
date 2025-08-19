import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_icon.dart';
import '../components/blueprint_popover.dart';
import '../components/popover_models.dart';
import '../components/blueprint_tag.dart';
import '../components/demo_page_scaffold.dart';
import '../components/blueprint_common.dart';

class PopoverDemoPage extends StatefulWidget {
  const PopoverDemoPage({Key? key}) : super(key: key);

  @override
  State<PopoverDemoPage> createState() => _PopoverDemoPageState();
}

class _PopoverDemoPageState extends State<PopoverDemoPage> {
  int _clickCount = 0;

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Popovers',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildSection('Basic Popovers', _buildBasicPopovers()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Hover Popovers', _buildHoverPopovers()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Positioning', _buildPositioningDemo()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Menu Popovers', _buildMenuPopovers()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Confirmation Popovers', _buildConfirmationPopovers()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Complex Content', _buildComplexContentDemo()),
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

  Widget _buildBasicPopovers() {
    return Wrap(
      spacing: BlueprintTheme.gridSize * 2,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintPopovers.click(
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('This is a basic popover with simple text content.'),
          ),
          child: BlueprintButton(
            text: 'Click me',
            variant: BlueprintButtonVariant.outlined,
          ),
        ),
        BlueprintPopovers.click(
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Minimal popover style with border.'),
          ),
          minimal: true,
          child: BlueprintButton(
            text: 'Minimal Style',
            variant: BlueprintButtonVariant.minimal,
          ),
        ),
        BlueprintPopovers.click(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rich Content',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: BlueprintTheme.fontSize,
                ),
              ),
              const SizedBox(height: BlueprintTheme.gridSize * 0.5),
              const Text('Popovers can contain any widget content.'),
              const SizedBox(height: BlueprintTheme.gridSize),
              BlueprintTags.simple(
                text: 'Example Tag',
                intent: BlueprintIntent.primary,
                size: BlueprintTagSize.small,
              ),
            ],
          ),
          child: BlueprintButton(
            text: 'Rich Content',
            intent: BlueprintIntent.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildHoverPopovers() {
    return Wrap(
      spacing: BlueprintTheme.gridSize * 2,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintPopovers.hover(
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('This popover appears on hover.'),
          ),
          child: BlueprintIcons.info(),
        ),
        BlueprintPopovers.hover(
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Hover with custom delay timing.'),
          ),
          hoverOpenDelay: const Duration(milliseconds: 500),
          hoverCloseDelay: const Duration(milliseconds: 100),
          child: BlueprintButton(
            text: 'Slow Hover',
            variant: BlueprintButtonVariant.minimal,
            icon: Icons.schedule,
          ),
        ),
        BlueprintPopovers.hover(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlueprintIcons.warningTriangle(),
              const SizedBox(height: BlueprintTheme.gridSize * 0.5),
              const Text('Warning information'),
            ],
          ),
          position: BlueprintPopoverPosition.left,
          child: BlueprintTags.simple(
            text: 'Hover me',
            intent: BlueprintIntent.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildPositioningDemo() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 4),
        child: Column(
          children: [
            BlueprintPopovers.click(
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Top popover'),
              ),
              position: BlueprintPopoverPosition.top,
              child: BlueprintTags.simple(text: 'Top', intent: BlueprintIntent.primary),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlueprintPopovers.click(
                  content: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Left popover'),
                  ),
                  position: BlueprintPopoverPosition.left,
                  child: BlueprintTags.simple(text: 'Left', intent: BlueprintIntent.success),
                ),
                BlueprintPopovers.click(
                  content: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Center default position'),
                  ),
                  child: BlueprintTags.simple(text: 'Center', intent: BlueprintIntent.warning),
                ),
                BlueprintPopovers.click(
                  content: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Right popover'),
                  ),
                  position: BlueprintPopoverPosition.right,
                  child: BlueprintTags.simple(text: 'Right', intent: BlueprintIntent.danger),
                ),
              ],
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlueprintPopovers.click(
                  content: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Bottom left aligned'),
                  ),
                  position: BlueprintPopoverPosition.bottomLeft,
                  child: BlueprintTags.minimal(text: 'Bottom Left'),
                ),
                BlueprintPopovers.click(
                  content: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Bottom right aligned'),
                  ),
                  position: BlueprintPopoverPosition.bottomRight,
                  child: BlueprintTags.minimal(text: 'Bottom Right'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuPopovers() {
    return Wrap(
      spacing: BlueprintTheme.gridSize * 2,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintPopovers.menu(
          items: [
            _buildMenuItem(Icons.edit, 'Edit', () => _showSnackBar('Edit clicked')),
            _buildMenuItem(Icons.copy, 'Copy', () => _showSnackBar('Copy clicked')),
            _buildMenuItem(Icons.share, 'Share', () => _showSnackBar('Share clicked')),
            const Divider(height: 1),
            _buildMenuItem(Icons.delete, 'Delete', () => _showSnackBar('Delete clicked'), danger: true),
          ],
          child: BlueprintButton(
            text: 'Actions',
            icon: Icons.more_vert,
            variant: BlueprintButtonVariant.outlined,
          ),
        ),
        BlueprintPopovers.menu(
          items: [
            _buildMenuItem(Icons.inbox, 'Inbox (3)', () => _showSnackBar('Inbox opened')),
            _buildMenuItem(Icons.send, 'Sent', () => _showSnackBar('Sent opened')),
            _buildMenuItem(Icons.drafts, 'Drafts (1)', () => _showSnackBar('Drafts opened')),
            const Divider(height: 1),
            _buildMenuItem(Icons.archive, 'Archive', () => _showSnackBar('Archive opened')),
            _buildMenuItem(Icons.folder, 'Folders', () => _showSnackBar('Folders opened')),
          ],
          position: BlueprintPopoverPosition.bottomRight,
          child: BlueprintButton(
            text: 'Mail Menu',
            icon: Icons.mail,
            intent: BlueprintIntent.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap, {bool danger = false}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: BlueprintTheme.gridSize,
          vertical: BlueprintTheme.gridSize * 0.5,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: danger ? BlueprintColors.intentDanger : BlueprintColors.textColor,
            ),
            const SizedBox(width: BlueprintTheme.gridSize),
            Text(
              label,
              style: TextStyle(
                color: danger ? BlueprintColors.intentDanger : BlueprintColors.textColor,
                fontSize: BlueprintTheme.fontSizeSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationPopovers() {
    return Wrap(
      spacing: BlueprintTheme.gridSize * 2,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintPopovers.confirmation(
          title: 'Delete Item',
          message: 'Are you sure you want to delete this item? This action cannot be undone.',
          onConfirm: () => _showSnackBar('Item deleted'),
          onCancel: () => _showSnackBar('Cancelled'),
          child: BlueprintButton(
            text: 'Delete Item',
            intent: BlueprintIntent.danger,
            icon: Icons.delete,
          ),
        ),
        BlueprintPopovers.confirmation(
          title: 'Save Changes',
          message: 'Save your changes before continuing?',
          onConfirm: () => _showSnackBar('Changes saved'),
          onCancel: () => _showSnackBar('Changes discarded'),
          confirmText: 'Save',
          cancelText: 'Discard',
          confirmIntent: BlueprintIntent.primary,
          child: BlueprintButton(
            text: 'Save Changes',
            intent: BlueprintIntent.primary,
            icon: Icons.save,
          ),
        ),
        BlueprintPopovers.confirmation(
          title: 'Send Message',
          message: 'Send this message to all team members?',
          onConfirm: () => _showSnackBar('Message sent'),
          confirmText: 'Send',
          confirmIntent: BlueprintIntent.success,
          child: BlueprintButton(
            text: 'Send Message',
            intent: BlueprintIntent.success,
            icon: Icons.send,
          ),
        ),
      ],
    );
  }

  Widget _buildComplexContentDemo() {
    return Wrap(
      spacing: BlueprintTheme.gridSize * 2,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintPopovers.click(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BlueprintIcons.info(),
                  const SizedBox(width: BlueprintTheme.gridSize * 0.5),
                  const Text(
                    'User Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: BlueprintTheme.fontSize,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('John Doe'),
              const Text(
                'Software Engineer',
                style: TextStyle(
                  color: BlueprintColors.textColorMuted,
                  fontSize: BlueprintTheme.fontSizeSmall,
                ),
              ),
              const SizedBox(height: BlueprintTheme.gridSize),
              Wrap(
                spacing: BlueprintTheme.gridSize * 0.5,
                children: [
                  BlueprintTags.simple(text: 'Flutter', size: BlueprintTagSize.small),
                  BlueprintTags.simple(text: 'Dart', size: BlueprintTagSize.small),
                  BlueprintTags.simple(text: 'React', size: BlueprintTagSize.small),
                ],
              ),
              const SizedBox(height: BlueprintTheme.gridSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlueprintButton(
                    text: 'View Profile',
                    variant: BlueprintButtonVariant.minimal,
                    onPressed: () => _showSnackBar('Profile opened'),
                  ),
                ],
              ),
            ],
          ),
          maxWidth: 250,
          child: BlueprintButton(
            text: 'User Profile',
            icon: Icons.person,
            variant: BlueprintButtonVariant.outlined,
          ),
        ),
        BlueprintPopovers.click(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Click Counter',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: BlueprintTheme.fontSize,
                ),
              ),
              const SizedBox(height: BlueprintTheme.gridSize),
              Text('You have clicked $_clickCount times'),
              const SizedBox(height: BlueprintTheme.gridSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlueprintButton(
                    text: '+',
                    variant: BlueprintButtonVariant.minimal,
                    onPressed: () => setState(() => _clickCount++),
                  ),
                  BlueprintButton(
                    text: 'Reset',
                    variant: BlueprintButtonVariant.minimal,
                    onPressed: () => setState(() => _clickCount = 0),
                  ),
                  BlueprintButton(
                    text: '-',
                    variant: BlueprintButtonVariant.minimal,
                    onPressed: () => setState(() => _clickCount = _clickCount > 0 ? _clickCount - 1 : 0),
                  ),
                ],
              ),
            ],
          ),
          child: BlueprintButton(
            text: 'Interactive Content',
            icon: Icons.touch_app,
            intent: BlueprintIntent.primary,
          ),
        ),
      ],
    );
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