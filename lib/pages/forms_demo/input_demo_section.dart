import 'package:flutter/material.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_input.dart';
import '../../components/blueprint_common.dart';

class InputDemoSection extends StatefulWidget {
  const InputDemoSection({super.key});

  @override
  State<InputDemoSection> createState() => _InputDemoSectionState();
}

class _InputDemoSectionState extends State<InputDemoSection> {
  String _basicInput = '';
  String _passwordInput = '';
  String _searchInput = '';

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
              'Basic Input',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintInputs.standard(
              placeholder: 'Enter your name...',
              value: _basicInput,
              onChanged: (value) => setState(() => _basicInput = value),
            ),
            const SizedBox(height: 16),
            
            Text(
              'Search Input',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintInputs.search(
              value: _searchInput,
              onChanged: (value) => setState(() => _searchInput = value),
            ),
            const SizedBox(height: 16),
            
            Text(
              'Password Input',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintInputs.password(
              value: _passwordInput,
              onChanged: (value) => setState(() => _passwordInput = value),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'With Intent - Success',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: BlueprintColors.gray1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlueprintInputs.withIntent(
                        intent: BlueprintIntent.success,
                        placeholder: 'Valid input',
                        leftIcon: Icons.check_circle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'With Intent - Danger',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: BlueprintColors.gray1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlueprintInputs.withIntent(
                        intent: BlueprintIntent.danger,
                        placeholder: 'Error input',
                        leftIcon: Icons.error,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}