import 'package:flutter/material.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_checkbox.dart';
import '../../components/blueprint_common.dart';
import '../../components/blueprint_card.dart';

class CheckboxDemoSection extends StatefulWidget {
  const CheckboxDemoSection({super.key});

  @override
  State<CheckboxDemoSection> createState() => _CheckboxDemoSectionState();
}

class _CheckboxDemoSectionState extends State<CheckboxDemoSection> {
  bool _basicCheckbox = false;
  bool _checkbox1 = true;
  bool _checkbox2 = false;
  bool _checkbox3 = false;

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      padding: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlueprintCheckboxes.simple(
              label: 'Basic checkbox',
              checked: _basicCheckbox,
              onChanged: (value) => setState(() => _basicCheckbox = value ?? false),
            ),
            const SizedBox(height: 16),
            
            Text(
              'Checkbox Group',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintCheckboxes.simple(
              label: 'Enable notifications',
              checked: _checkbox1,
              onChanged: (value) => setState(() => _checkbox1 = value ?? false),
            ),
            const SizedBox(height: 8),
            BlueprintCheckboxes.simple(
              label: 'Enable analytics',
              checked: _checkbox2,
              onChanged: (value) => setState(() => _checkbox2 = value ?? false),
            ),
            const SizedBox(height: 8),
            BlueprintCheckboxes.simple(
              label: 'Enable marketing emails',
              checked: _checkbox3,
              onChanged: (value) => setState(() => _checkbox3 = value ?? false),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: BlueprintCheckboxes.withIntent(
                    label: 'Success checkbox',
                    intent: BlueprintIntent.success,
                    checked: true,
                    onChanged: null,
                  ),
                ),
                Expanded(
                  child: BlueprintCheckboxes.withIntent(
                    label: 'Warning checkbox',
                    intent: BlueprintIntent.warning,
                    checked: true,
                    onChanged: null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: BlueprintCheckboxes.indeterminate(
                    label: 'Indeterminate',
                    onChanged: (value) => {},
                  ),
                ),
                Expanded(
                  child: BlueprintCheckboxes.simple(
                    label: 'Disabled',
                    checked: false,
                    disabled: true,
                    onChanged: null,
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}