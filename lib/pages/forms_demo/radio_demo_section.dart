import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_radio.dart';

class RadioDemoSection extends StatefulWidget {
  const RadioDemoSection({Key? key}) : super(key: key);

  @override
  State<RadioDemoSection> createState() => _RadioDemoSectionState();
}

class _RadioDemoSectionState extends State<RadioDemoSection> {
  String? _basicRadio = 'option1';
  String? _intentRadio = 'primary';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlueprintRadios.group<String>(
              label: 'Basic Radio Group',
              options: [
                BlueprintRadios.simple<String>(
                  value: 'option1',
                  label: 'Option 1',
                  groupValue: _basicRadio,
                  onChanged: (value) => setState(() => _basicRadio = value),
                ),
                BlueprintRadios.simple<String>(
                  value: 'option2',
                  label: 'Option 2',
                  groupValue: _basicRadio,
                  onChanged: (value) => setState(() => _basicRadio = value),
                ),
                BlueprintRadios.simple<String>(
                  value: 'option3',
                  label: 'Option 3',
                  groupValue: _basicRadio,
                  onChanged: (value) => setState(() => _basicRadio = value),
                ),
              ],
              selectedValue: _basicRadio,
              onChanged: (value) => setState(() => _basicRadio = value),
            ),
            const SizedBox(height: 16),
            
            BlueprintRadios.group<String>(
              label: 'Intent Colors',
              options: [
                BlueprintRadios.withIntent<String>(
                  value: 'primary',
                  label: 'Primary',
                  intent: BlueprintIntent.primary,
                  groupValue: _intentRadio,
                  onChanged: (value) => setState(() => _intentRadio = value),
                ),
                BlueprintRadios.withIntent<String>(
                  value: 'success',
                  label: 'Success',
                  intent: BlueprintIntent.success,
                  groupValue: _intentRadio,
                  onChanged: (value) => setState(() => _intentRadio = value),
                ),
                BlueprintRadios.withIntent<String>(
                  value: 'warning',
                  label: 'Warning',
                  intent: BlueprintIntent.warning,
                  groupValue: _intentRadio,
                  onChanged: (value) => setState(() => _intentRadio = value),
                ),
                BlueprintRadios.withIntent<String>(
                  value: 'danger',
                  label: 'Danger',
                  intent: BlueprintIntent.danger,
                  groupValue: _intentRadio,
                  onChanged: (value) => setState(() => _intentRadio = value),
                ),
              ],
              selectedValue: _intentRadio,
              onChanged: (value) => setState(() => _intentRadio = value),
              inline: true,
            ),
          ],
        ),
      ),
    );
  }
}