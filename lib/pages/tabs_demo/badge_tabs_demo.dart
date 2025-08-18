import 'package:flutter/material.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_card.dart';
import '../../components/blueprint_tabs.dart';
import 'tab_content.dart';

class BadgeTabsDemo extends StatelessWidget {
  const BadgeTabsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      elevation: BlueprintElevation.one,
      padding: EdgeInsets.zero,
      child: BlueprintTabs(
        tabs: [
          BlueprintTab(
            id: 'inbox',
            title: 'Inbox',
            icon: Icons.inbox,
            badge: '12',
            content: TabContent(
              title: 'Inbox',
              description: 'You have 12 new messages in your inbox.',
              icon: Icons.mail,
              color: BlueprintColors.intentPrimary,
            ),
          ),
          BlueprintTab(
            id: 'notifications',
            title: 'Notifications',
            icon: Icons.notifications,
            badge: '5',
            content: TabContent(
              title: 'Notifications',
              description: 'You have 5 unread notifications.',
              icon: Icons.notifications,
              color: BlueprintColors.intentWarning,
            ),
          ),
          BlueprintTab(
            id: 'archive',
            title: 'Archive',
            icon: Icons.archive,
            content: TabContent(
              title: 'Archive',
              description: 'View your archived items here.',
              icon: Icons.archive,
              color: BlueprintColors.gray3,
            ),
          ),
        ],
      ),
    );
  }
}