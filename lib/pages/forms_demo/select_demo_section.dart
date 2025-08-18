import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_select.dart';

class SelectDemoSection extends StatefulWidget {
  const SelectDemoSection({Key? key}) : super(key: key);

  @override
  State<SelectDemoSection> createState() => _SelectDemoSectionState();
}

class _SelectDemoSectionState extends State<SelectDemoSection> {
  String? _basicSelect;
  String? _filterableSelect;
  String? _intentSelect;

  final List<BlueprintSelectOption<String>> _countries = [
    const BlueprintSelectOption(value: 'us', label: 'United States', icon: Icons.flag),
    const BlueprintSelectOption(value: 'ca', label: 'Canada', icon: Icons.flag),
    const BlueprintSelectOption(value: 'uk', label: 'United Kingdom', icon: Icons.flag),
    const BlueprintSelectOption(value: 'fr', label: 'France', icon: Icons.flag),
    const BlueprintSelectOption(value: 'de', label: 'Germany', icon: Icons.flag),
    const BlueprintSelectOption(value: 'jp', label: 'Japan', icon: Icons.flag),
    const BlueprintSelectOption(value: 'au', label: 'Australia', icon: Icons.flag),
    const BlueprintSelectOption(value: 'br', label: 'Brazil', icon: Icons.flag),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Select',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintSelects.simple<String>(
              options: const [
                BlueprintSelectOption(value: 'small', label: 'Small'),
                BlueprintSelectOption(value: 'medium', label: 'Medium'),
                BlueprintSelectOption(value: 'large', label: 'Large'),
                BlueprintSelectOption(value: 'xl', label: 'Extra Large'),
              ],
              value: _basicSelect,
              onChanged: (value) => setState(() => _basicSelect = value),
              placeholder: 'Choose size...',
            ),
            const SizedBox(height: 16),
            
            Text(
              'Filterable Select',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintSelects.filterable<String>(
              options: _countries,
              value: _filterableSelect,
              onChanged: (value) => setState(() => _filterableSelect = value),
              placeholder: 'Select country...',
            ),
            const SizedBox(height: 16),
            
            Text(
              'Select with Intent',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintSelects.withIntent<String>(
              intent: BlueprintIntent.primary,
              options: const [
                BlueprintSelectOption(value: 'low', label: 'Low Priority', icon: Icons.low_priority),
                BlueprintSelectOption(value: 'medium', label: 'Medium Priority', icon: Icons.priority_high),
                BlueprintSelectOption(value: 'high', label: 'High Priority', icon: Icons.priority_high),
                BlueprintSelectOption(value: 'critical', label: 'Critical Priority', icon: Icons.warning),
              ],
              value: _intentSelect,
              onChanged: (value) => setState(() => _intentSelect = value),
              placeholder: 'Select priority...',
            ),
          ],
        ),
      ),
    );
  }
}