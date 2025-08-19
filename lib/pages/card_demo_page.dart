import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_card.dart';
import '../components/blueprint_button.dart';
import '../components/demo_page_scaffold.dart';
import '../components/control_card/blueprint_control_card_base.dart';
import '../components/control_card/blueprint_switch_card.dart';
import '../components/control_card/blueprint_checkbox_card.dart';
import '../components/control_card/blueprint_radio_card.dart';
import '../components/blueprint_common.dart';

class CardDemoPage extends StatelessWidget {
  const CardDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Cards',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Basic Cards', _buildBasicCards()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Interactive Cards', _buildInteractiveCards(context)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Card Elevations', _buildElevationCards()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Card List', _buildCardList(context)),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Control Cards', _buildControlCards()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Complex Cards', _buildComplexCards(context)),
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

  Widget _buildBasicCards() {
    return Row(
      children: [
        Expanded(
          child: BlueprintCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Simple Card',
                  style: TextStyle(
                    fontSize: BlueprintTheme.fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: BlueprintTheme.gridSize),
                const Text(
                  'This is a basic card with some content inside.',
                  style: TextStyle(color: BlueprintColors.textColorMuted),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: BlueprintTheme.gridSize),
        Expanded(
          child: BlueprintCard(
            compact: true,
            child: const Text(
              'Compact Card',
              style: TextStyle(
                fontSize: BlueprintTheme.fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlueprintCard(
            interactive: true,
            onTap: () => _showSnackBar(context, 'Interactive card tapped'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.touch_app, color: BlueprintColors.intentPrimary),
                    SizedBox(width: BlueprintTheme.gridSize),
                    Text(
                      'Interactive Card',
                      style: TextStyle(
                        fontSize: BlueprintTheme.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BlueprintTheme.gridSize),
                const Text(
                  'Hover and click to see interactive effects.',
                  style: TextStyle(color: BlueprintColors.textColorMuted),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: BlueprintTheme.gridSize),
        Expanded(
          child: BlueprintCard(
            selected: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: BlueprintColors.intentPrimary),
                    SizedBox(width: BlueprintTheme.gridSize),
                    Text(
                      'Selected Card',
                      style: TextStyle(
                        fontSize: BlueprintTheme.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BlueprintTheme.gridSize),
                const Text(
                  'This card appears selected with a border.',
                  style: TextStyle(color: BlueprintColors.textColorMuted),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildElevationCards() {
    return Row(
      children: [
        Expanded(
          child: BlueprintCard(
            elevation: BlueprintElevation.zero,
            child: Column(
              children: [
                const Text('Elevation 0', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                const Text('No shadow', style: TextStyle(color: BlueprintColors.textColorMuted)),
              ],
            ),
          ),
        ),
        const SizedBox(width: BlueprintTheme.gridSize),
        Expanded(
          child: BlueprintCard(
            elevation: BlueprintElevation.one,
            child: Column(
              children: [
                const Text('Elevation 1', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                const Text('Light shadow', style: TextStyle(color: BlueprintColors.textColorMuted)),
              ],
            ),
          ),
        ),
        const SizedBox(width: BlueprintTheme.gridSize),
        Expanded(
          child: BlueprintCard(
            elevation: BlueprintElevation.two,
            child: Column(
              children: [
                const Text('Elevation 2', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                const Text('Medium shadow', style: TextStyle(color: BlueprintColors.textColorMuted)),
              ],
            ),
          ),
        ),
        const SizedBox(width: BlueprintTheme.gridSize),
        Expanded(
          child: BlueprintCard(
            elevation: BlueprintElevation.three,
            child: Column(
              children: [
                const Text('Elevation 3', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                const Text('High shadow', style: TextStyle(color: BlueprintColors.textColorMuted)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardList(BuildContext context) {
    return BlueprintCardList(
      children: [
        BlueprintCard(
          child: BlueprintCardHeader(
            title: 'Card List Item 1',
            subtitle: 'This is the first item in a card list',
            leading: const BlueprintCircleAvatar(
              text: '1',
              backgroundColor: BlueprintColors.intentPrimary,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showSnackBar(context, 'Card 1 tapped'),
          ),
        ),
        BlueprintCard(
          child: BlueprintCardHeader(
            title: 'Card List Item 2',
            subtitle: 'This is the second item in a card list',
            leading: const BlueprintCircleAvatar(
              text: '2',
              backgroundColor: BlueprintColors.intentSuccess,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showSnackBar(context, 'Card 2 tapped'),
          ),
        ),
        BlueprintCard(
          child: BlueprintCardHeader(
            title: 'Card List Item 3',
            subtitle: 'This is the third item in a card list',
            leading: const BlueprintCircleAvatar(
              text: '3',
              backgroundColor: BlueprintColors.intentWarning,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showSnackBar(context, 'Card 3 tapped'),
          ),
        ),
      ],
    );
  }

  Widget _buildComplexCards(BuildContext context) {
    return Column(
      children: [
        BlueprintCard(
          elevation: BlueprintElevation.two,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlueprintCardHeader(
                title: 'Project Dashboard',
                subtitle: 'Overview of current projects',
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BlueprintColors.intentPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
                  ),
                  child: const Icon(
                    Icons.dashboard,
                    color: BlueprintColors.intentPrimary,
                    size: 20,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showSnackBar(context, 'Menu tapped'),
                ),
              ),
              BlueprintCardSection(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('12', style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: BlueprintColors.intentPrimary,
                            )),
                            const Text('Active', style: TextStyle(color: BlueprintColors.textColorMuted)),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('5', style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: BlueprintColors.intentSuccess,
                            )),
                            const Text('Completed', style: TextStyle(color: BlueprintColors.textColorMuted)),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('2', style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: BlueprintColors.intentWarning,
                            )),
                            const Text('Pending', style: TextStyle(color: BlueprintColors.textColorMuted)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlueprintCardSection(
                border: null,
                child: Row(
                  children: [
                    Expanded(
                      child: BlueprintButton(
                        text: 'View All',
                        variant: BlueprintButtonVariant.minimal,
                        intent: BlueprintIntent.primary,
                        onPressed: () => _showSnackBar(context, 'View All tapped'),
                      ),
                    ),
                    const SizedBox(width: BlueprintTheme.gridSize),
                    Expanded(
                      child: BlueprintButton(
                        text: 'Add Project',
                        intent: BlueprintIntent.primary,
                        icon: Icons.add,
                        onPressed: () => _showSnackBar(context, 'Add Project tapped'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControlCards() {
    return StatefulBuilder(
      builder: (context, setState) {
        bool switchValue = false;
        bool checkboxValue = false;
        String radioValue = 'option1';

        return Column(
          children: [
            BlueprintSwitchCard(
              label: 'Enable notifications',
              description: 'Receive push notifications for important updates',
              value: switchValue,
              onChanged: (value) => setState(() => switchValue = value),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            BlueprintCheckboxCard(
              label: 'Accept terms and conditions',
              description: 'I agree to the terms of service and privacy policy',
              value: checkboxValue,
              onChanged: (value) => setState(() => checkboxValue = value),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            BlueprintRadioCard(
              label: 'Basic Plan',
              description: 'Up to 5 projects, 10GB storage',
              value: radioValue == 'basic',
              groupValue: radioValue == 'basic',
              onChanged: (value) => setState(() => radioValue = 'basic'),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            BlueprintRadioCard(
              label: 'Pro Plan',
              description: 'Unlimited projects, 100GB storage',
              value: radioValue == 'pro',
              groupValue: radioValue == 'pro',
              onChanged: (value) => setState(() => radioValue = 'pro'),
            ),
            const SizedBox(height: BlueprintTheme.gridSize),
            BlueprintControlCard(
              type: ControlCardType.switch_,
              value: false,
              onChanged: null, // disabled
              disabled: true,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Disabled Option',
                    style: TextStyle(
                      fontSize: BlueprintTheme.fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'This control is disabled',
                    style: TextStyle(
                      fontSize: BlueprintTheme.fontSizeSmall,
                      color: BlueprintColors.textColorMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentPrimary,
      ),
    );
  }
}