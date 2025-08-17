import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_navbar.dart';
import '../components/blueprint_button.dart';

class NavbarDemoPage extends StatefulWidget {
  const NavbarDemoPage({Key? key}) : super(key: key);

  @override
  State<NavbarDemoPage> createState() => _NavbarDemoPageState();
}

class _NavbarDemoPageState extends State<NavbarDemoPage> {
  String selectedTab = 'Home';
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Navbar'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
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
        TextButton(
          onPressed: () => _navigateTo('Home'),
          child: const Text('Home'),
        ),
        TextButton(
          onPressed: () => _navigateTo('About'),
          child: const Text('About'),
        ),
        TextButton(
          onPressed: () => _navigateTo('Contact'),
          child: const Text('Contact'),
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
          TextButton(
            onPressed: () => _navigateTo('Dashboard'),
            child: const Text('Dashboard'),
          ),
          TextButton(
            onPressed: () => _navigateTo('Projects'),
            child: const Text('Projects'),
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
        ...tabs.map((tab) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ElevatedButton(
            onPressed: () => _selectTab(tab),
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedTab == tab 
                  ? BlueprintColors.intentPrimary 
                  : Colors.transparent,
              foregroundColor: selectedTab == tab 
                  ? Colors.white 
                  : BlueprintColors.gray1,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
              ),
            ),
            child: Text(tab),
          ),
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
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search, size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          onSubmitted: (value) => _showNotification('Searching for: $value'),
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
        TextButton(
          onPressed: () => _navigateTo('Link 1'),
          child: const Text('Link 1'),
        ),
        TextButton(
          onPressed: () => _navigateTo('Link 2'),
          child: const Text('Link 2'),
        ),
        const Spacer(),
        Switch(
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