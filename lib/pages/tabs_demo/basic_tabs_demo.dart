import 'package:flutter/material.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_card.dart';
import '../../components/blueprint_tabs.dart';
import '../../components/blueprint_common.dart';
import 'tab_content.dart';

class BasicTabsDemo extends StatelessWidget {
  const BasicTabsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      elevation: BlueprintElevation.one,
      padding: EdgeInsets.zero,
      child: BlueprintTabs(
        tabs: [
          BlueprintTab(
            id: 'angular',
            title: 'Angular',
            content: TabContent(
              title: 'Angular',
              description: 'Angular is a platform for building mobile and desktop web applications.',
              icon: Icons.web,
              color: BlueprintColors.red3,
            ),
          ),
          BlueprintTab(
            id: 'react',
            title: 'React',
            content: TabContent(
              title: 'React',
              description: 'A JavaScript library for building user interfaces.',
              icon: Icons.code,
              color: BlueprintColors.blue3,
            ),
          ),
          BlueprintTab(
            id: 'vue',
            title: 'Vue',
            content: TabContent(
              title: 'Vue',
              description: 'The Progressive JavaScript Framework.',
              icon: Icons.view_compact,
              color: BlueprintColors.green3,
            ),
          ),
        ],
      ),
    );
  }
}