import 'package:flutter/material.dart';
import '../components/blueprint_drawer.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_section.dart';
import '../components/blueprint_divider.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

class DrawerDemoPage extends StatefulWidget {
  const DrawerDemoPage({Key? key}) : super(key: key);

  @override
  State<DrawerDemoPage> createState() => _DrawerDemoPageState();
}

class _DrawerDemoPageState extends State<DrawerDemoPage> {
  BlueprintDrawerSize _selectedSize = BlueprintDrawerSize.standard;
  BlueprintDrawerPosition _selectedPosition = BlueprintDrawerPosition.right;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Demo'),
        backgroundColor: BlueprintColors.lightGray5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlueprintSection(
              title: 'Basic Drawer',
              children: [
                const Text(
                  'Drawers slide out from the edge of the screen to reveal content or navigation.',
                  style: TextStyle(color: BlueprintColors.textColorMuted),
                ),
                const SizedBox(height: BlueprintTheme.gridSize * 2),
                Wrap(
                  spacing: BlueprintTheme.gridSize,
                  runSpacing: BlueprintTheme.gridSize,
                  children: [
                    BlueprintButton(
                      text: 'Open Drawer (Right)',
                      onPressed: () => _showBasicDrawer(BlueprintDrawerPosition.right),
                    ),
                    BlueprintButton(
                      text: 'Open Drawer (Left)',
                      onPressed: () => _showBasicDrawer(BlueprintDrawerPosition.left),
                    ),
                    BlueprintButton(
                      text: 'Open Drawer (Top)',
                      onPressed: () => _showBasicDrawer(BlueprintDrawerPosition.top),
                    ),
                    BlueprintButton(
                      text: 'Open Drawer (Bottom)',
                      onPressed: () => _showBasicDrawer(BlueprintDrawerPosition.bottom),
                    ),
                  ],
                ),
              ],
            ),
            
            const BlueprintDivider(),
            
            BlueprintSection(
              title: 'Drawer Sizes',
              children: [
                const Text(
                  'Drawers come in different sizes: small (240px), standard (280px), and large (360px).',
                  style: TextStyle(color: BlueprintColors.textColorMuted),
                ),
                const SizedBox(height: BlueprintTheme.gridSize * 2),
                Wrap(
                  spacing: BlueprintTheme.gridSize,
                  runSpacing: BlueprintTheme.gridSize,
                  children: [
                    BlueprintButton(
                      text: 'Small Drawer',
                      onPressed: () => _showSizedDrawer(BlueprintDrawerSize.small),
                    ),
                    BlueprintButton(
                      text: 'Standard Drawer',
                      onPressed: () => _showSizedDrawer(BlueprintDrawerSize.standard),
                    ),
                    BlueprintButton(
                      text: 'Large Drawer',
                      onPressed: () => _showSizedDrawer(BlueprintDrawerSize.large),
                    ),
                  ],
                ),
              ],
            ),
            
            const BlueprintDivider(),
            
            BlueprintSection(
              title: 'Navigation Drawer',
              children: [
                const Text(
                  'Drawers can be used for navigation with a list of menu items.',
                  style: TextStyle(color: BlueprintColors.textColorMuted),
                ),
                const SizedBox(height: BlueprintTheme.gridSize * 2),
                BlueprintButton(
                  text: 'Open Navigation Drawer',
                  icon: Icons.menu,
                  onPressed: _showNavigationDrawer,
                ),
              ],
            ),
            
            const BlueprintDivider(),
            
            BlueprintSection(
              title: 'Content Drawer',
              children: [
                const Text(
                  'Drawers can contain rich content, forms, or detailed information.',
                  style: TextStyle(color: BlueprintColors.textColorMuted),
                ),
                const SizedBox(height: BlueprintTheme.gridSize * 2),
                BlueprintButton(
                  text: 'Open Content Drawer',
                  icon: Icons.article,
                  onPressed: _showContentDrawer,
                ),
              ],
            ),
            
            const BlueprintDivider(),
            
            BlueprintSection(
              title: 'Drawer Options',
              children: [
                const Text(
                  'Drawers support various configuration options.',
                  style: TextStyle(color: BlueprintColors.textColorMuted),
                ),
                const SizedBox(height: BlueprintTheme.gridSize * 2),
                Wrap(
                  spacing: BlueprintTheme.gridSize,
                  runSpacing: BlueprintTheme.gridSize,
                  children: [
                    BlueprintButton(
                      text: 'No Backdrop',
                      onPressed: () => _showDrawerWithOptions(hasBackdrop: false),
                    ),
                    BlueprintButton(
                      text: 'No Outside Click Close',
                      onPressed: () => _showDrawerWithOptions(canOutsideClickClose: false),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBasicDrawer(BlueprintDrawerPosition position) {
    BlueprintDrawer.show(
      context: context,
      position: position,
      title: Text('${position.name.toUpperCase()} Drawer'),
      icon: const Icon(Icons.info_outline, size: 16),
      child: BlueprintDrawers.withContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This is a ${position.name} drawer.',
              style: const TextStyle(
                fontSize: BlueprintTheme.fontSizeLarge,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            const Text(
              'Drawers slide out from the edge of the screen to reveal additional content or navigation options.',
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
            BlueprintButton(
              text: 'Close Drawer',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _showSizedDrawer(BlueprintDrawerSize size) {
    String sizeLabel = '';
    String sizeInfo = '';
    
    switch (size) {
      case BlueprintDrawerSize.small:
        sizeLabel = 'Small';
        sizeInfo = '240px wide';
        break;
      case BlueprintDrawerSize.standard:
        sizeLabel = 'Standard';
        sizeInfo = '280px wide';
        break;
      case BlueprintDrawerSize.large:
        sizeLabel = 'Large';
        sizeInfo = '360px wide';
        break;
    }
    
    BlueprintDrawer.show(
      context: context,
      size: size,
      title: Text('$sizeLabel Drawer'),
      child: BlueprintDrawers.withContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$sizeLabel Drawer',
              style: const TextStyle(
                fontSize: BlueprintTheme.fontSizeLarge,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            Text('This drawer is $sizeInfo.'),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
            const Text(
              'Use different sizes based on your content needs:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            const Text('• Small: Quick actions or simple navigation'),
            const Text('• Standard: General purpose content'),
            const Text('• Large: Detailed forms or complex content'),
          ],
        ),
      ),
    );
  }

  void _showNavigationDrawer() {
    final navigationItems = [
      const DrawerNavigationItem(
        label: 'Dashboard',
        icon: Icons.dashboard,
        isActive: true,
      ),
      const DrawerNavigationItem(
        label: 'Analytics',
        icon: Icons.analytics,
      ),
      const DrawerNavigationItem(
        label: 'Reports',
        icon: Icons.report,
      ),
      const DrawerNavigationItem(
        label: 'Settings',
        icon: Icons.settings,
      ),
      const DrawerNavigationItem(
        label: 'Help & Support',
        icon: Icons.help,
      ),
      const DrawerNavigationItem(
        label: 'Disabled Item',
        icon: Icons.block,
        disabled: true,
      ),
    ];
    
    BlueprintDrawers.showNavigation(
      context: context,
      title: 'Navigation',
      icon: const Icon(Icons.menu, size: 16),
      items: navigationItems,
    );
  }

  void _showContentDrawer() {
    BlueprintDrawer.show(
      context: context,
      title: const Text('Article Details'),
      icon: const Icon(Icons.article, size: 16),
      size: BlueprintDrawerSize.large,
      child: BlueprintDrawers.withContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Blueprint.js Design System',
              style: TextStyle(
                fontSize: BlueprintTheme.fontSizeLarge,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            const Text(
              'Published on March 15, 2024',
              style: TextStyle(
                color: BlueprintColors.textColorMuted,
                fontSize: BlueprintTheme.fontSizeSmall,
              ),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
            const Text(
              'Blueprint is a React-based UI toolkit for the web. It is optimized for building complex, data-dense interfaces for desktop applications.',
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
            const Text(
              'Key Features:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            const Text('• 30+ React components'),
            const Text('• TypeScript support'),
            const Text('• Comprehensive icon library'),
            const Text('• Dark theme support'),
            const Text('• Accessible by default'),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            Row(
              children: [
                BlueprintButton(
                  text: 'Edit Article',
                  intent: BlueprintIntent.primary,
                  onPressed: () {},
                ),
                const SizedBox(width: BlueprintTheme.gridSize),
                BlueprintButton(
                  text: 'Share',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDrawerWithOptions({bool? hasBackdrop, bool? canOutsideClickClose}) {
    BlueprintDrawer.show(
      context: context,
      title: const Text('Drawer Options'),
      hasBackdrop: hasBackdrop ?? true,
      canOutsideClickClose: canOutsideClickClose ?? true,
      child: BlueprintDrawers.withContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Drawer Configuration',
              style: TextStyle(
                fontSize: BlueprintTheme.fontSizeLarge,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
            if (hasBackdrop == false)
              const Text('• No backdrop - drawer appears without darkening the background'),
            if (canOutsideClickClose == false)
              const Text('• Cannot close by clicking outside - must use close button'),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            BlueprintButton(
              text: 'Close Drawer',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}