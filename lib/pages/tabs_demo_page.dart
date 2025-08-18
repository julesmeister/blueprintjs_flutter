import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import 'tabs_demo/tab_section.dart';
import 'tabs_demo/basic_tabs_demo.dart';
import 'tabs_demo/icon_tabs_demo.dart';
import 'tabs_demo/badge_tabs_demo.dart';
import 'tabs_demo/large_tabs_demo.dart';
import 'tabs_demo/vertical_tabs_demo.dart';
import 'tabs_demo/controlled_tabs_demo.dart';

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
            TabSection(
              title: 'Basic Tabs', 
              child: BasicTabsDemo(),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            TabSection(
              title: 'Tabs with Icons', 
              child: IconTabsDemo(),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            TabSection(
              title: 'Tabs with Badges', 
              child: BadgeTabsDemo(),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            TabSection(
              title: 'Large Tabs', 
              child: LargeTabsDemo(),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            TabSection(
              title: 'Vertical Tabs', 
              child: VerticalTabsDemo(),
            ),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            TabSection(
              title: 'Controlled Tabs',
              child: ControlledTabsDemo(
                selectedTab: _selectedTab,
                onTabChanged: (tabId) => setState(() => _selectedTab = tabId),
              ),
            ),
          ],
        ),
      ),
    );
  }
}