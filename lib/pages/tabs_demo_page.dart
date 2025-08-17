import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_tabs.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_card.dart';

class TabsDemoPage extends StatefulWidget {
  const TabsDemoPage({Key? key}) : super(key: key);

  @override
  State<TabsDemoPage> createState() => _TabsDemoPageState();
}

class _TabsDemoPageState extends State<TabsDemoPage> {
  String _selectedTab = 'tab1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Tabs'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Basic Tabs', _buildBasicTabs()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Tabs with Icons', _buildIconTabs()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Tabs with Badges', _buildBadgeTabs()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Large Tabs', _buildLargeTabs()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Vertical Tabs', _buildVerticalTabs()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Controlled Tabs', _buildControlledTabs()),
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

  Widget _buildBasicTabs() {
    return SizedBox(
      height: 300,
      child: BlueprintCard(
        elevation: BlueprintElevation.one,
        padding: EdgeInsets.zero,
        child: BlueprintTabs(
        tabs: [
          BlueprintTab(
            id: 'angular',
            title: 'Angular',
            content: _buildTabContent(
              'Angular',
              'Angular is a platform for building mobile and desktop web applications.',
              Icons.web,
              BlueprintColors.red3,
            ),
          ),
          BlueprintTab(
            id: 'react',
            title: 'React',
            content: _buildTabContent(
              'React',
              'A JavaScript library for building user interfaces.',
              Icons.code,
              BlueprintColors.blue3,
            ),
          ),
          BlueprintTab(
            id: 'vue',
            title: 'Vue',
            content: _buildTabContent(
              'Vue',
              'The Progressive JavaScript Framework.',
              Icons.view_compact,
              BlueprintColors.green3,
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildIconTabs() {
    return SizedBox(
      height: 300,
      child: BlueprintCard(
        elevation: BlueprintElevation.one,
        padding: EdgeInsets.zero,
        child: BlueprintTabs(
        tabs: [
          BlueprintTab(
            id: 'home',
            title: 'Home',
            icon: Icons.home,
            content: _buildTabContent(
              'Home',
              'Welcome to the home page. This is where you can find an overview of everything.',
              Icons.home,
              BlueprintColors.intentPrimary,
            ),
          ),
          BlueprintTab(
            id: 'profile',
            title: 'Profile',
            icon: Icons.person,
            content: _buildTabContent(
              'Profile',
              'Manage your personal information and account settings here.',
              Icons.person,
              BlueprintColors.intentSuccess,
            ),
          ),
          BlueprintTab(
            id: 'settings',
            title: 'Settings',
            icon: Icons.settings,
            content: _buildTabContent(
              'Settings',
              'Configure your application preferences and system settings.',
              Icons.settings,
              BlueprintColors.intentWarning,
            ),
          ),
          BlueprintTab(
            id: 'disabled',
            title: 'Disabled',
            icon: Icons.block,
            disabled: true,
            content: const Text('This tab is disabled'),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildBadgeTabs() {
    return SizedBox(
      height: 300,
      child: BlueprintCard(
        elevation: BlueprintElevation.one,
        padding: EdgeInsets.zero,
        child: BlueprintTabs(
        tabs: [
          BlueprintTab(
            id: 'inbox',
            title: 'Inbox',
            icon: Icons.inbox,
            badge: '12',
            content: _buildTabContent(
              'Inbox',
              'You have 12 new messages in your inbox.',
              Icons.mail,
              BlueprintColors.intentPrimary,
            ),
          ),
          BlueprintTab(
            id: 'notifications',
            title: 'Notifications',
            icon: Icons.notifications,
            badge: '5',
            content: _buildTabContent(
              'Notifications',
              'You have 5 unread notifications.',
              Icons.notifications,
              BlueprintColors.intentWarning,
            ),
          ),
          BlueprintTab(
            id: 'archive',
            title: 'Archive',
            icon: Icons.archive,
            content: _buildTabContent(
              'Archive',
              'View your archived items here.',
              Icons.archive,
              BlueprintColors.gray3,
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildLargeTabs() {
    return SizedBox(
      height: 300,
      child: BlueprintCard(
        elevation: BlueprintElevation.one,
        padding: EdgeInsets.zero,
        child: BlueprintTabs(
        size: BlueprintTabSize.large,
        tabs: [
          BlueprintTab(
            id: 'dashboard',
            title: 'Dashboard',
            icon: Icons.dashboard,
            content: _buildTabContent(
              'Dashboard',
              'Overview of your key metrics and performance indicators.',
              Icons.dashboard,
              BlueprintColors.intentPrimary,
            ),
          ),
          BlueprintTab(
            id: 'analytics',
            title: 'Analytics',
            icon: Icons.analytics,
            content: _buildTabContent(
              'Analytics',
              'Detailed analytics and reporting for your data.',
              Icons.analytics,
              BlueprintColors.intentSuccess,
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildVerticalTabs() {
    return SizedBox(
      height: 300,
      child: BlueprintCard(
        elevation: BlueprintElevation.one,
        padding: EdgeInsets.zero,
        child: BlueprintTabs(
          vertical: true,
          tabs: [
            BlueprintTab(
              id: 'overview',
              title: 'Overview',
              icon: Icons.visibility,
              content: _buildTabContent(
                'Overview',
                'Get a high-level view of your project status.',
                Icons.visibility,
                BlueprintColors.intentPrimary,
              ),
            ),
            BlueprintTab(
              id: 'details',
              title: 'Details',
              icon: Icons.info,
              content: _buildTabContent(
                'Details',
                'Dive deep into the specifics and detailed information.',
                Icons.info,
                BlueprintColors.intentSuccess,
              ),
            ),
            BlueprintTab(
              id: 'reports',
              title: 'Reports',
              icon: Icons.assessment,
              content: _buildTabContent(
                'Reports',
                'View comprehensive reports and analysis.',
                Icons.assessment,
                BlueprintColors.intentWarning,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlledTabs() {
    return SizedBox(
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
          children: [
            BlueprintButton(
              text: 'Select Tab 1',
              intent: _selectedTab == 'tab1' ? BlueprintIntent.primary : BlueprintIntent.none,
              onPressed: () => setState(() => _selectedTab = 'tab1'),
            ),
            const SizedBox(width: BlueprintTheme.gridSize),
            BlueprintButton(
              text: 'Select Tab 2',
              intent: _selectedTab == 'tab2' ? BlueprintIntent.primary : BlueprintIntent.none,
              onPressed: () => setState(() => _selectedTab = 'tab2'),
            ),
            const SizedBox(width: BlueprintTheme.gridSize),
            BlueprintButton(
              text: 'Select Tab 3',
              intent: _selectedTab == 'tab3' ? BlueprintIntent.primary : BlueprintIntent.none,
              onPressed: () => setState(() => _selectedTab = 'tab3'),
            ),
          ],
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        BlueprintCard(
          elevation: BlueprintElevation.one,
          padding: EdgeInsets.zero,
          child: BlueprintTabs(
            selectedTabId: _selectedTab,
            onTabChanged: (tabId) => setState(() => _selectedTab = tabId),
            tabs: [
              BlueprintTab(
                id: 'tab1',
                title: 'First Tab',
                content: _buildTabContent(
                  'First Tab',
                  'This is the content of the first tab. The selection is controlled externally.',
                  Icons.looks_one,
                  BlueprintColors.blue1,
                ),
              ),
              BlueprintTab(
                id: 'tab2',
                title: 'Second Tab',
                content: _buildTabContent(
                  'Second Tab',
                  'This is the content of the second tab. Click the buttons above to change tabs.',
                  Icons.looks_two,
                  BlueprintColors.blue2,
                ),
              ),
              BlueprintTab(
                id: 'tab3',
                title: 'Third Tab',
                content: _buildTabContent(
                  'Third Tab',
                  'This is the content of the third tab. The state is managed by the parent widget.',
                  Icons.looks_3,
                  BlueprintColors.blue3,
                ),
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildTabContent(String title, String description, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BlueprintTheme.gridSize),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: BlueprintTheme.gridSize),
              Text(
                title,
                style: const TextStyle(
                  fontSize: BlueprintTheme.fontSizeLarge,
                  fontWeight: FontWeight.w600,
                  color: BlueprintColors.headingColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          Text(
            description,
            style: const TextStyle(
              color: BlueprintColors.textColorMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          BlueprintButton(
            text: 'Action Button',
            intent: BlueprintIntent.primary,
            icon: Icons.play_arrow,
            onPressed: () => _showSnackBar('Action button pressed in $title'),
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