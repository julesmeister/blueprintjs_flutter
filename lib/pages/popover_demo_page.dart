import '../components/blueprint_button.dart';
import '../components/blueprint_icon.dart';
import '../components/blueprint_popover.dart';
import '../components/blueprint_menu.dart';
import '../components/blueprint_tag.dart';
import '../components/blueprint_card.dart';
import '../components/blueprint_switch.dart';
import '../components/demo_page_scaffold.dart';
import '../components/blueprint_common.dart';

class PopoverDemoPage extends StatefulWidget {
  const PopoverDemoPage({super.key});

  @override
  State<PopoverDemoPage> createState() => _PopoverDemoPageState();
}

class _PopoverDemoPageState extends State<PopoverDemoPage> {
  int _clickCount = 0;
  bool _popoversEnabled = true;

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
          _buildSection('Popover Positioning', _buildPositioningDemo()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Menu Popovers', _buildMenuPopovers()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Confirmation Popovers', _buildConfirmationPopovers()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Intent Colors', _buildIntentPopovers()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Interactive Content', _buildInteractiveContentDemo()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Real-world Examples', _buildRealWorldExamples()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Controls', _buildControls()),
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
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Click-triggered popovers with different content styles:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w500,
              color: BlueprintColors.textColorMuted,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Wrap(
            spacing: BlueprintTheme.gridSize * 2,
            runSpacing: BlueprintTheme.gridSize * 2,
            children: [
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('This is a basic popover with simple text content. Perfect for quick information displays.'),
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !_popoversEnabled,
                child: const BlueprintButton(
                  text: 'Basic Popover',
                  variant: BlueprintButtonVariant.outlined,
                ),
              ),
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Minimal style removes shadows and uses subtle borders.'),
                ),
                interaction: BlueprintPopoverInteraction.click,
                minimal: true,
                disabled: !_popoversEnabled,
                child: const BlueprintButton(
                  text: 'Minimal Style',
                  variant: BlueprintButtonVariant.minimal,
                ),
              ),
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rich Content Example',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: BlueprintTheme.fontSizeLarge,
                        color: BlueprintColors.headingColor,
                      ),
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text('Popovers can contain any Flutter widget including:'),
                    const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                    const Text('• Text with various styles'),
                    const Text('• Tags and badges'),
                    const Text('• Icons and buttons'),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    Wrap(
                      spacing: BlueprintTheme.gridSize * 0.5,
                      children: [
                        BlueprintTags.simple(
                          text: 'Flutter',
                          intent: BlueprintIntent.primary,
                          size: BlueprintTagSize.small,
                        ),
                        BlueprintTags.simple(
                          text: 'Blueprint',
                          intent: BlueprintIntent.success,
                          size: BlueprintTagSize.small,
                        ),
                      ],
                    ),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.click,
                maxWidth: 280,
                disabled: !_popoversEnabled,
                child: const BlueprintButton(
                  text: 'Rich Content',
                  intent: BlueprintIntent.primary,
                  icon: Icons.auto_awesome,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoverPopovers() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hover-triggered popovers with different timing and content:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w500,
              color: BlueprintColors.textColorMuted,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Wrap(
            spacing: BlueprintTheme.gridSize * 2,
            runSpacing: BlueprintTheme.gridSize * 2,
            children: [
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Quick information appears instantly on hover. Perfect for help icons and tooltips.'),
                ),
                interaction: BlueprintPopoverInteraction.hover,
                disabled: !_popoversEnabled,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlueprintIcons.info(),
                    const SizedBox(width: BlueprintTheme.gridSize * 0.5),
                    const Text('Info Icon'),
                  ],
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
                disabled: !_popoversEnabled,
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
                disabled: !_popoversEnabled,
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
                disabled: !_popoversEnabled,
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

  Widget _buildPositioningDemo() {
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
                        disabled: !_popoversEnabled,
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
                        disabled: !_popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Top',
                          intent: BlueprintIntent.primary,
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
                        disabled: !_popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Top Right',
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BlueprintTheme.gridSize * 3),
                  // Middle row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Left side position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.left,
                        disabled: !_popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Left',
                          intent: BlueprintIntent.success,
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Default bottom position (auto-positioned based on available space)'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        disabled: !_popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Auto',
                          intent: BlueprintIntent.warning,
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Right side position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.right,
                        disabled: !_popoversEnabled,
                        child: const BlueprintButton(
                          text: 'Right',
                          intent: BlueprintIntent.danger,
                          size: BlueprintButtonSize.small,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BlueprintTheme.gridSize * 3),
                  // Bottom row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Bottom Left aligned'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.bottomLeft,
                        disabled: !_popoversEnabled,
                        child: BlueprintTags.minimal(text: 'Bottom Left'),
                      ),
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Bottom Center position'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.bottom,
                        disabled: !_popoversEnabled,
                        child: BlueprintTags.minimal(text: 'Bottom'),
                      ),
                      BlueprintPopover(
                        content: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Bottom Right aligned'),
                        ),
                        interaction: BlueprintPopoverInteraction.click,
                        position: BlueprintPopoverPosition.bottomRight,
                        disabled: !_popoversEnabled,
                        child: BlueprintTags.minimal(text: 'Bottom Right'),
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

  Widget _buildMenuPopovers() {
    return Wrap(
      spacing: BlueprintTheme.gridSize * 2,
      runSpacing: BlueprintTheme.gridSize,
      children: [
        BlueprintPopovers.menu(
          items: [
            BlueprintMenuItem(
              text: 'Edit',
              icon: Icons.edit,
              onTap: () => _showSnackBar('Edit clicked'),
            ),
            BlueprintMenuItem(
              text: 'Copy',
              icon: Icons.copy,
              onTap: () => _showSnackBar('Copy clicked'),
            ),
            BlueprintMenuItem(
              text: 'Share',
              icon: Icons.share,
              onTap: () => _showSnackBar('Share clicked'),
            ),
            BlueprintMenuDivider(),
            BlueprintMenuItem(
              text: 'Delete',
              icon: Icons.delete,
              intent: BlueprintIntent.danger,
              onTap: () => _showSnackBar('Delete clicked'),
            ),
          ],
          child: const BlueprintButton(
            text: 'Actions',
            icon: Icons.more_vert,
            variant: BlueprintButtonVariant.outlined,
          ),
        ),
        BlueprintPopovers.menu(
          items: [
            BlueprintMenuItem(
              text: 'Inbox (3)',
              icon: Icons.inbox,
              onTap: () => _showSnackBar('Inbox opened'),
            ),
            BlueprintMenuItem(
              text: 'Sent',
              icon: Icons.send,
              onTap: () => _showSnackBar('Sent opened'),
            ),
            BlueprintMenuItem(
              text: 'Drafts (1)',
              icon: Icons.drafts,
              onTap: () => _showSnackBar('Drafts opened'),
            ),
            BlueprintMenuDivider(),
            BlueprintMenuItem(
              text: 'Archive',
              icon: Icons.archive,
              onTap: () => _showSnackBar('Archive opened'),
            ),
            BlueprintMenuItem(
              text: 'Folders',
              icon: Icons.folder,
              onTap: () => _showSnackBar('Folders opened'),
            ),
          ],
          position: BlueprintPopoverPosition.bottomRight,
          child: const BlueprintButton(
            text: 'Mail Menu',
            icon: Icons.mail,
            intent: BlueprintIntent.primary,
          ),
        ),
      ],
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
          child: const BlueprintButton(
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
          child: const BlueprintButton(
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
          child: const BlueprintButton(
            text: 'Send Message',
            intent: BlueprintIntent.success,
            icon: Icons.send,
          ),
        ),
      ],
    );
  }

  Widget _buildIntentPopovers() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popovers with different intent colors for visual context:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w500,
              color: BlueprintColors.textColorMuted,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Wrap(
            spacing: BlueprintTheme.gridSize * 2,
            runSpacing: BlueprintTheme.gridSize * 2,
            children: [
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info, color: BlueprintColors.intentPrimary),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text(
                      'Primary Information',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                    const Text('Important information for user attention'),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !_popoversEnabled,
                child: const BlueprintButton(
                  text: 'Primary Info',
                  intent: BlueprintIntent.primary,
                  icon: Icons.info,
                ),
              ),
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: BlueprintColors.intentSuccess),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text(
                      'Success Message',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                    const Text('Operation completed successfully'),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !_popoversEnabled,
                child: const BlueprintButton(
                  text: 'Success',
                  intent: BlueprintIntent.success,
                  icon: Icons.check_circle,
                ),
              ),
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber, color: BlueprintColors.intentWarning),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text(
                      'Warning Alert',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                    const Text('Please review before proceeding'),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !_popoversEnabled,
                child: const BlueprintButton(
                  text: 'Warning',
                  intent: BlueprintIntent.warning,
                  icon: Icons.warning_amber,
                ),
              ),
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error, color: BlueprintColors.intentDanger),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text(
                      'Error Alert',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                    const Text('Action failed or requires immediate attention'),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !_popoversEnabled,
                child: const BlueprintButton(
                  text: 'Error',
                  intent: BlueprintIntent.danger,
                  icon: Icons.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveContentDemo() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popovers with interactive content and stateful widgets:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w500,
              color: BlueprintColors.textColorMuted,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Wrap(
            spacing: BlueprintTheme.gridSize * 2,
            runSpacing: BlueprintTheme.gridSize * 2,
            children: [
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: BlueprintColors.intentPrimary),
                        const SizedBox(width: BlueprintTheme.gridSize),
                        const Text(
                          'John Doe',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: BlueprintTheme.fontSizeLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text(
                      'Senior Flutter Developer',
                      style: TextStyle(
                        color: BlueprintColors.textColorMuted,
                        fontSize: BlueprintTheme.fontSize,
                      ),
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text('📍 San Francisco, CA'),
                    const Text('📧 john.doe@example.com'),
                    const SizedBox(height: BlueprintTheme.gridSize * 1.5),
                    const Text(
                      'Skills:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                    Wrap(
                      spacing: BlueprintTheme.gridSize * 0.5,
                      runSpacing: BlueprintTheme.gridSize * 0.5,
                      children: [
                        BlueprintTags.simple(text: 'Flutter', size: BlueprintTagSize.small, intent: BlueprintIntent.primary),
                        BlueprintTags.simple(text: 'Dart', size: BlueprintTagSize.small, intent: BlueprintIntent.success),
                        BlueprintTags.simple(text: 'Firebase', size: BlueprintTagSize.small),
                      ],
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize * 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BlueprintButton(
                          text: 'View Profile',
                          variant: BlueprintButtonVariant.minimal,
                          icon: Icons.open_in_new,
                          onPressed: () => _showSnackBar('Profile opened'),
                        ),
                      ],
                    ),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.click,
                maxWidth: 300,
                disabled: !_popoversEnabled,
                child: const BlueprintButton(
                  text: 'User Profile Card',
                  icon: Icons.person,
                  variant: BlueprintButtonVariant.outlined,
                ),
              ),
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interactive Counter',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: BlueprintTheme.fontSizeLarge,
                      ),
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    Text('Current count: $_clickCount'),
                    const SizedBox(height: BlueprintTheme.gridSize * 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlueprintButton(
                          text: '-',
                          variant: BlueprintButtonVariant.minimal,
                          intent: BlueprintIntent.danger,
                          onPressed: () => setState(() => _clickCount = _clickCount > 0 ? _clickCount - 1 : 0),
                        ),
                        BlueprintButton(
                          text: 'Reset',
                          variant: BlueprintButtonVariant.minimal,
                          onPressed: () => setState(() => _clickCount = 0),
                        ),
                        BlueprintButton(
                          text: '+',
                          variant: BlueprintButtonVariant.minimal,
                          intent: BlueprintIntent.success,
                          onPressed: () => setState(() => _clickCount++),
                        ),
                      ],
                    ),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.click,
                disabled: !_popoversEnabled,
                child: BlueprintButton(
                  text: 'Counter: $_clickCount',
                  icon: Icons.add_circle_outline,
                  intent: BlueprintIntent.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRealWorldExamples() {
    return Column(
      children: [
        _buildToolbarExample(),
        const SizedBox(height: BlueprintTheme.gridSize * 2),
        _buildNotificationExample(),
      ],
    );
  }

  Widget _buildToolbarExample() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Toolbar with Action Popovers:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          const Text(
            'Common pattern for displaying contextual actions and help information.',
            style: TextStyle(
              color: BlueprintColors.textColorMuted,
              fontSize: BlueprintTheme.fontSizeSmall,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Row(
            children: [
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Save the current document'),
                ),
                interaction: BlueprintPopoverInteraction.hover,
                disabled: !_popoversEnabled,
                child: IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () => _showSnackBar('Document saved'),
                ),
              ),
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Open an existing document'),
                ),
                interaction: BlueprintPopoverInteraction.hover,
                disabled: !_popoversEnabled,
                child: IconButton(
                  icon: const Icon(Icons.folder_open),
                  onPressed: () => _showSnackBar('File browser opened'),
                ),
              ),
              BlueprintPopover(
                content: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Print the current document'),
                ),
                interaction: BlueprintPopoverInteraction.hover,
                disabled: !_popoversEnabled,
                child: IconButton(
                  icon: const Icon(Icons.print),
                  onPressed: () => _showSnackBar('Print dialog opened'),
                ),
              ),
              const VerticalDivider(),
              BlueprintPopovers.menu(
                items: [
                  BlueprintMenuItem(
                    text: 'Undo',
                    icon: Icons.undo,
                    onTap: () => _showSnackBar('Undo'),
                  ),
                  BlueprintMenuItem(
                    text: 'Redo',
                    icon: Icons.redo,
                    onTap: () => _showSnackBar('Redo'),
                  ),
                  BlueprintMenuDivider(),
                  BlueprintMenuItem(
                    text: 'Cut',
                    icon: Icons.content_cut,
                    onTap: () => _showSnackBar('Cut'),
                  ),
                  BlueprintMenuItem(
                    text: 'Copy',
                    icon: Icons.content_copy,
                    onTap: () => _showSnackBar('Copy'),
                  ),
                  BlueprintMenuItem(
                    text: 'Paste',
                    icon: Icons.content_paste,
                    onTap: () => _showSnackBar('Paste'),
                  ),
                ],
                child: IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationExample() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status and Notification Popovers:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          const Text(
            'Display status information and notifications in a non-intrusive way.',
            style: TextStyle(
              color: BlueprintColors.textColorMuted,
              fontSize: BlueprintTheme.fontSizeSmall,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Row(
            children: [
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.wifi, color: BlueprintColors.intentSuccess, size: 20),
                        const SizedBox(width: BlueprintTheme.gridSize),
                        const Text('Network Status', style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text('Connected to: Office WiFi'),
                    const Text('Signal strength: Strong'),
                    const Text('Speed: 100 Mbps'),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.hover,
                disabled: !_popoversEnabled,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wifi, color: BlueprintColors.intentSuccess),
                    const SizedBox(width: BlueprintTheme.gridSize * 0.5),
                    const Text('Connected'),
                  ],
                ),
              ),
              const SizedBox(width: BlueprintTheme.gridSize * 2),
              BlueprintPopover(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.notifications, color: BlueprintColors.intentPrimary),
                        const SizedBox(width: BlueprintTheme.gridSize),
                        const Text('Notifications (3)', style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    const Text('• New message from John'),
                    const Text('• Server maintenance at 2 PM'),
                    const Text('• Update available'),
                    const SizedBox(height: BlueprintTheme.gridSize),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BlueprintButton(
                          text: 'Mark All Read',
                          variant: BlueprintButtonVariant.minimal,
                          onPressed: () => _showSnackBar('All notifications marked as read'),
                        ),
                      ],
                    ),
                  ],
                ),
                interaction: BlueprintPopoverInteraction.click,
                maxWidth: 250,
                disabled: !_popoversEnabled,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        const Icon(Icons.notifications),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: BlueprintColors.intentDanger,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: BlueprintTheme.gridSize * 0.5),
                    const Text('Notifications'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Demo Controls:',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintSwitches.withLabel(
            value: _popoversEnabled,
            label: _popoversEnabled ? 'Popovers Enabled' : 'Popovers Disabled',
            onChanged: (value) => setState(() => _popoversEnabled = value),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          Text(
            'Use the toggle above to enable/disable all popovers on this page. This demonstrates how popovers can be controlled programmatically.',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSizeSmall,
              color: BlueprintColors.textColorMuted,
            ),
          ),
        ],
      ),
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