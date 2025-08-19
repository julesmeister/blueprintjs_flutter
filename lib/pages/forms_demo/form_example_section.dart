import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_input.dart';
import '../../components/blueprint_select.dart';
import '../../components/blueprint_checkbox.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_common.dart';
import '../../components/blueprint_card.dart';

class FormExampleSection extends StatelessWidget {
  const FormExampleSection({super.key});

  final List<BlueprintSelectOption<String>> _countries = const [
    BlueprintSelectOption(value: 'us', label: 'United States', icon: Icons.flag),
    BlueprintSelectOption(value: 'ca', label: 'Canada', icon: Icons.flag),
    BlueprintSelectOption(value: 'uk', label: 'United Kingdom', icon: Icons.flag),
    BlueprintSelectOption(value: 'fr', label: 'France', icon: Icons.flag),
    BlueprintSelectOption(value: 'de', label: 'Germany', icon: Icons.flag),
    BlueprintSelectOption(value: 'jp', label: 'Japan', icon: Icons.flag),
    BlueprintSelectOption(value: 'au', label: 'Australia', icon: Icons.flag),
    BlueprintSelectOption(value: 'br', label: 'Brazil', icon: Icons.flag),
  ];

  void _showFormSubmitted(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form submitted successfully!'),
        backgroundColor: BlueprintColors.intentSuccess,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Registration Form',
              style: const TextStyle(
                fontSize: BlueprintTheme.fontSizeLarge,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: BlueprintInputGroup(
                    placeholder: 'First Name',
                    leftIcon: Icons.person,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BlueprintInputGroup(
                    placeholder: 'Last Name',
                    leftIcon: Icons.person,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            BlueprintInputGroup(
              placeholder: 'Email Address',
              leftIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            
            BlueprintInputs.password(
              placeholder: 'Password',
            ),
            const SizedBox(height: 16),
            
            BlueprintSelect<String>(
              options: _countries,
              placeholder: 'Select your country',
              leftIcon: Icons.language,
              filterable: true,
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            
            BlueprintCheckbox(
              label: 'I agree to the Terms of Service and Privacy Policy',
              checked: false,
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            
            BlueprintCheckbox(
              label: 'Subscribe to our newsletter',
              checked: true,
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              child: BlueprintButton(
                text: 'Create Account',
                intent: BlueprintIntent.primary,
                onPressed: () => _showFormSubmitted(context),
              ),
            ),
          ],
        ),
    );
  }
}