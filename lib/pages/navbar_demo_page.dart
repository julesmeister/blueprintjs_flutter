import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_navbar.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_switch.dart';
import '../components/demo_page_scaffold.dart';
import '../components/blueprint_common.dart';

class NavbarDemoPage extends StatefulWidget {
  const NavbarDemoPage({super.key});

  @override
  State<NavbarDemoPage> createState() => _NavbarDemoPageState();
}

class _NavbarDemoPageState extends State<NavbarDemoPage> {
  String selectedTab = 'Home';
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Navbar',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildSection('Basic Navbar', _buildBasicNavbar()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Navbar with Groups', _buildGroupedNavbar()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Navigation Tabs', _buildTabNavbar()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('App-style Navbar', _buildAppNavbar()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Minimal Navbar', _buildMinimalNavbar()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Interactive Example', _buildInteractiveExample()),
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

  Widget _buildBasicNavbar() {
    return BlueprintNavbars.simple(
      children: [
        const BlueprintNavbarHeading(text: 'Blueprint'),
        const SizedBox(width: 16),
        BlueprintButton(
          text: 'Home',
          variant: BlueprintButtonVariant.minimal,
          onPressed: () => _navigateTo('Home'),
        ),
        BlueprintButton(
          text: 'About',
          variant: BlueprintButtonVariant.minimal,
          onPressed: () => _navigateTo('About'),
        ),
        BlueprintButton(
          text: 'Contact',
          variant: BlueprintButtonVariant.minimal,
          onPressed: () => _navigateTo('Contact'),
        ),
      ],
    );
  }

  Widget _buildGroupedNavbar() {
    return BlueprintNavbars.withGroups(
      start: Row(
        children: [
          const BlueprintNavbarHeading(text: 'MyApp'),
          const SizedBox(width: 16),
          const BlueprintNavbarDivider(),
          const SizedBox(width: 16),
          BlueprintButton(
            text: 'Dashboard',
            variant: BlueprintButtonVariant.minimal,
            onPressed: () => _navigateTo('Dashboard'),
          ),
          BlueprintButton(
            text: 'Projects',
            variant: BlueprintButtonVariant.minimal,
            onPressed: () => _navigateTo('Projects'),
          ),
        ],
      ),
      end: Row(
        children: [
          IconButton(
            onPressed: () => _showNotification('Notifications clicked'),
            icon: const Icon(Icons.notifications),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _showNotification('Profile clicked'),
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavbar() {
    final tabs = ['Home', 'Products', 'Services', 'About'];
    
    return BlueprintNavbars.simple(
      children: [
        const BlueprintNavbarHeading(text: 'Company'),
        const SizedBox(width: 32),
        ...tabs.map((tab) => _NavbarTab(
          text: tab,
          isSelected: selectedTab == tab,
          onTap: () => _selectTab(tab),
        )),
      ],
    );
  }

  Widget _buildAppNavbar() {
    return BlueprintNavbars.withGroups(
      start: Row(
        children: [
          IconButton(
            onPressed: () => _showNotification('Menu opened'),
            icon: const Icon(Icons.menu),
          ),
          const SizedBox(width: 8),
          const BlueprintNavbarHeading(text: 'Blueprint App'),
        ],
      ),
      center: Container(
        width: 300,
        height: 36,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? BlueprintColors.dark1
              : BlueprintColors.light4,
          borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 8),
              child: Icon(Icons.search, size: 16, color: BlueprintColors.gray2),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: BlueprintColors.gray3,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: (36 - 14 * 1.2) / 2,
                  ),
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 14),
                onSubmitted: (value) => _showNotification('Searching for: $value'),
              ),
            ),
          ],
        ),
      ),
      end: Row(
        children: [
          IconButton(
            onPressed: () => _showNotification('Help clicked'),
            icon: const Icon(Icons.help_outline),
          ),
          const BlueprintNavbarDivider(),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 16,
            backgroundColor: BlueprintColors.intentPrimary,
            child: const Text('JD', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalNavbar() {
    return BlueprintNavbars.minimal(
      children: [
        const Text('Minimal', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 16),
        BlueprintButton(
          text: 'Link 1',
          variant: BlueprintButtonVariant.minimal,
          onPressed: () => _navigateTo('Link 1'),
        ),
        BlueprintButton(
          text: 'Link 2',
          variant: BlueprintButtonVariant.minimal,
          onPressed: () => _navigateTo('Link 2'),
        ),
        const Spacer(),
        BlueprintSwitch(
          value: isDarkMode,
          onChanged: (value) {
            setState(() {
              isDarkMode = value;
            });
            _showNotification('Dark mode: ${value ? 'On' : 'Off'}');
          },
        ),
      ],
    );
  }

  Widget _buildInteractiveExample() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interactive Navbar Example',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: BlueprintTheme.fontSize,
              ),
            ),
            const SizedBox(height: 16),
            BlueprintNavbars.withGroups(
              start: Row(
                children: [
                  const BlueprintNavbarHeading(text: 'Demo'),
                  const SizedBox(width: 16),
                  const BlueprintNavbarDivider(),
                  const SizedBox(width: 16),
                  BlueprintButton(
                    text: 'New',
                    icon: Icons.add,
                    variant: BlueprintButtonVariant.minimal,
                    onPressed: () => _showNotification('New clicked'),
                  ),
                  const SizedBox(width: 8),
                  BlueprintButton(
                    text: 'Save',
                    icon: Icons.save,
                    variant: BlueprintButtonVariant.minimal,
                    onPressed: () => _showNotification('Save clicked'),
                  ),
                ],
              ),
              end: Row(
                children: [
                  BlueprintButton(
                    text: 'Settings',
                    icon: Icons.settings,
                    variant: BlueprintButtonVariant.minimal,
                    onPressed: () => _showNotification('Settings clicked'),
                  ),
                  const SizedBox(width: 8),
                  BlueprintButton(
                    text: 'Share',
                    icon: Icons.share,
                    intent: BlueprintIntent.primary,
                    variant: BlueprintButtonVariant.minimal,
                    onPressed: () => _showNotification('Share clicked'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Current tab: $selectedTab',
              style: TextStyle(
                color: BlueprintColors.gray2,
                fontSize: BlueprintTheme.fontSizeSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(String destination) {
    _showNotification('Navigated to: $destination');
  }

  void _selectTab(String tab) {
    setState(() {
      selectedTab = tab;
    });
    _showNotification('Selected tab: $tab');
  }

  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _NavbarTab extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavbarTab({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavbarTab> createState() => _NavbarTabState();
}

class _NavbarTabState extends State<_NavbarTab> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Exact Blueprint.js minimal button colors from SCSS
    Color getBackgroundColor() {
      if (widget.isSelected) {
        return BlueprintColors.blue3; // intent-primary active
      }
      
      if (_isHovered) {
        return BlueprintColors.gray3.withValues(alpha: 0.15); // minimal-button-background-color-hover
      }
      
      return Colors.transparent; // minimal-button-background-color: none
    }

    Color getTextColor() {
      if (widget.isSelected) {
        return Colors.white; // intent text color
      }
      
      return isDark ? Colors.white : BlueprintColors.dark1; // pt-text-color
    }

    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 30, // Blueprint button height: 3 * 10px
                minWidth: 30,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10, // Blueprint button padding: 1 * 10px
                vertical: 0,    // Remove vertical padding for proper centering
              ),
              decoration: BoxDecoration(
                color: getBackgroundColor(),
                borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: BlueprintTheme.fontSize,
                    color: getTextColor(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}