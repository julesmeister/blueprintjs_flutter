import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_divider.dart';
import '../components/blueprint_section.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_input.dart';
import '../components/demo_page_scaffold.dart';
import '../components/blueprint_common.dart';
import '../components/blueprint_card.dart';

class LayoutDemoPage extends StatefulWidget {
  const LayoutDemoPage({Key? key}) : super(key: key);

  @override
  State<LayoutDemoPage> createState() => _LayoutDemoPageState();
}

class _LayoutDemoPageState extends State<LayoutDemoPage> {
  bool _section1Collapsed = false;
  bool _section2Collapsed = true;

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Layout',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildSection('Dividers', _buildDividerSection()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Sections', _buildSectionComponents()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Layout Examples', _buildLayoutExamples()),
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

  Widget _buildDividerSection() {
    return BlueprintCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Horizontal Dividers',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 16),
            
            const Text('Content above divider'),
            BlueprintDividers.horizontal(),
            const Text('Content below divider'),
            
            BlueprintDividers.horizontal(compact: true),
            const Text('Content with compact divider above'),
            
            const SizedBox(height: 20),
            Text(
              'Vertical Dividers in Row',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 16),
            
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: BlueprintColors.blue5,
                      child: const Center(child: Text('Left Section')),
                    ),
                  ),
                  BlueprintDividers.vertical(),
                  Expanded(
                    child: Container(
                      color: BlueprintColors.green5,
                      child: const Center(child: Text('Middle Section')),
                    ),
                  ),
                  BlueprintDividers.vertical(),
                  Expanded(
                    child: Container(
                      color: BlueprintColors.orange5,
                      child: const Center(child: Text('Right Section')),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            Text(
              'Colored Dividers',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 16),
            
            const Text('Primary color divider'),
            BlueprintDividers.withColor(BlueprintColors.blue3),
            const Text('Success color divider'),
            BlueprintDividers.withColor(BlueprintColors.green3),
            const Text('Warning color divider'),
            BlueprintDividers.withColor(BlueprintColors.orange3),
            const Text('Danger color divider'),
            BlueprintDividers.withColor(BlueprintColors.red3),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionComponents() {
    return Column(
      children: [
        BlueprintSections.simple(
          title: 'Basic Section',
          icon: Icons.info,
          children: [
            const Text(
              'This is a basic section with a title and icon. '
              'Sections are useful for organizing content into logical groups.',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                BlueprintButton(
                  text: 'Action 1',
                  intent: BlueprintIntent.primary,
                  size: BlueprintButtonSize.small,
                  onPressed: () => _showSnackbar('Action 1 clicked'),
                ),
                const SizedBox(width: 8),
                BlueprintButton(
                  text: 'Action 2',
                  variant: BlueprintButtonVariant.outlined,
                  size: BlueprintButtonSize.small,
                  onPressed: () => _showSnackbar('Action 2 clicked'),
                ),
              ],
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        BlueprintSections.collapsible(
          title: 'Collapsible Section',
          icon: Icons.expand_more,
          initiallyCollapsed: _section1Collapsed,
          children: [
            const Text(
              'This section can be collapsed and expanded. '
              'Click the header to toggle visibility.',
            ),
            const SizedBox(height: 12),
            BlueprintInputGroup(
              placeholder: 'Enter some text...',
              leftIcon: Icons.edit,
              
              onChanged: (value) {},
            ),
            const SizedBox(height: 8),
            const Text(
              'Content inside collapsible sections can include any widgets.',
              style: TextStyle(fontSize: BlueprintTheme.fontSizeSmall),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        BlueprintSections.elevated(
          title: 'Elevated Section',
          icon: Icons.layers,
          elevation: BlueprintSectionElevation.two,
          children: [
            const Text(
              'This section has elevation shadow to make it stand out from the background.',
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: BlueprintColors.blue5,
                borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb, color: BlueprintColors.blue3),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Pro tip: Use elevation to create visual hierarchy',
                      style: TextStyle(color: BlueprintColors.blue1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        BlueprintSections.withCards(
          title: 'Section with Cards',
          icon: Icons.dashboard,
          cards: [
            const BlueprintSectionCard(
              child: Row(
                children: [
                  Icon(Icons.person, color: BlueprintColors.blue3),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Profile',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Manage your account settings',
                          style: TextStyle(
                            fontSize: BlueprintTheme.fontSizeSmall,
                            color: BlueprintColors.gray2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: BlueprintColors.gray3),
                ],
              ),
            ),
            const BlueprintSectionCard(
              child: Row(
                children: [
                  Icon(Icons.security, color: BlueprintColors.green3),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Security Settings',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Password, 2FA, and privacy',
                          style: TextStyle(
                            fontSize: BlueprintTheme.fontSizeSmall,
                            color: BlueprintColors.gray2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: BlueprintColors.gray3),
                ],
              ),
            ),
            const BlueprintSectionCard(
              child: Row(
                children: [
                  Icon(Icons.notifications, color: BlueprintColors.orange3),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Email and push notifications',
                          style: TextStyle(
                            fontSize: BlueprintTheme.fontSizeSmall,
                            color: BlueprintColors.gray2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: BlueprintColors.gray3),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        BlueprintSections.compact(
          title: 'Compact Section',
          icon: Icons.compress,
          children: [
            const Text(
              'This section uses compact padding for a more dense layout.',
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 16, color: BlueprintColors.blue3),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Compact sections are useful when space is limited',
                    style: TextStyle(
                      fontSize: BlueprintTheme.fontSizeSmall,
                      color: BlueprintColors.gray2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLayoutExamples() {
    return Column(
      children: [
        BlueprintCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard Layout Example',
                  style: const TextStyle(
                    fontSize: BlueprintTheme.fontSizeLarge,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: BlueprintSections.simple(
                        title: 'Statistics',
                        icon: Icons.analytics,
                        children: [
                          _buildStatItem('Users', '1,234', Icons.people, BlueprintColors.blue3),
                          BlueprintDividers.compact(),
                          _buildStatItem('Revenue', '\$12,345', Icons.attach_money, BlueprintColors.green3),
                          BlueprintDividers.compact(),
                          _buildStatItem('Orders', '567', Icons.shopping_cart, BlueprintColors.orange3),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: BlueprintSections.simple(
                        title: 'Recent Activity',
                        icon: Icons.history,
                        children: [
                          _buildActivityItem('User John Doe logged in', '2 minutes ago'),
                          _buildActivityItem('Order #1234 was shipped', '5 minutes ago'),
                          _buildActivityItem('New user registered', '10 minutes ago'),
                          _buildActivityItem('Payment processed', '15 minutes ago'),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                BlueprintDividers.horizontal(),
                const SizedBox(height: 16),
                
                BlueprintSections.collapsible(
                  title: 'Advanced Settings',
                  icon: Icons.settings,
                  initiallyCollapsed: true,
                  children: [
                    const Text('These settings are for advanced users only.'),
                    const SizedBox(height: 12),
                    BlueprintInputGroup(
                      placeholder: 'API Endpoint',
                      leftIcon: Icons.api,
                      
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 8),
                    BlueprintInputGroup(
                      placeholder: 'Timeout (seconds)',
                      leftIcon: Icons.timer,
                      keyboardType: TextInputType.number,
                      
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: BlueprintTheme.fontSizeLarge,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: BlueprintTheme.fontSizeSmall,
                    color: BlueprintColors.gray2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String activity, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: BlueprintColors.blue3,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: const TextStyle(fontSize: BlueprintTheme.fontSize),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: BlueprintTheme.fontSizeSmall,
                    color: BlueprintColors.gray2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}