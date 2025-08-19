import 'package:flutter/material.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_card.dart';
import '../../components/blueprint_tabs.dart';
import '../../components/blueprint_common.dart';
import 'tab_content.dart';

class IconTabsDemo extends StatelessWidget {
  const IconTabsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      elevation: BlueprintElevation.one,
      padding: EdgeInsets.zero,
      child: BlueprintTabs(
        tabs: [
          BlueprintTab(
            id: 'home',
            title: 'Home',
            icon: Icons.home,
            content: TabContent(
              title: 'Home',
              description: 'Welcome to the home page. This is where you can find an overview of everything.',
              icon: Icons.home,
              color: BlueprintColors.intentPrimary,
            ),
          ),
          BlueprintTab(
            id: 'profile',
            title: 'Profile',
            icon: Icons.person,
            content: TabContent(
              title: 'Profile',
              description: 'Manage your personal information and account settings here.',
              icon: Icons.person,
              color: BlueprintColors.intentSuccess,
            ),
          ),
          BlueprintTab(
            id: 'settings',
            title: 'Settings',
            icon: Icons.settings,
            content: TabContent(
              title: 'Settings',
              description: 'Configure your application preferences and system settings.',
              icon: Icons.settings,
              color: BlueprintColors.intentWarning,
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
    );
  }
}