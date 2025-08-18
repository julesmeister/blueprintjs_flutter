import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_button.dart'; // Import for BlueprintIntent
import '../components/blueprint_input.dart';
import '../components/blueprint_checkbox.dart';
import '../components/blueprint_radio.dart';
import '../components/blueprint_select.dart';

class FormsDemoPage extends StatefulWidget {
  const FormsDemoPage({Key? key}) : super(key: key);

  @override
  State<FormsDemoPage> createState() => _FormsDemoPageState();
}

class _FormsDemoPageState extends State<FormsDemoPage> {
  // Input states
  String _basicInput = '';
  String _passwordInput = '';
  String _searchInput = '';
  
  // Checkbox states
  bool _basicCheckbox = false;
  bool _checkbox1 = true;
  bool _checkbox2 = false;
  bool _checkbox3 = false;
  bool? _indeterminateCheckbox;
  
  // Radio states
  String? _basicRadio = 'option1';
  String? _intentRadio = 'primary';
  String? _sizeRadio = 'medium';
  
  // Select states
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Forms'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Input Fields', _buildInputSection()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Checkboxes', _buildCheckboxSection()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Radio Buttons', _buildRadioSection()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Select Dropdowns', _buildSelectSection()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Form Example', _buildFormExample()),
          ],
        ),
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

  Widget _buildInputSection() {
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

  Widget _buildCheckboxSection() {
    return Card(
      elevation: 1,
      child: Padding(
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
                    onChanged: (value) => setState(() => _indeterminateCheckbox = value),
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
      ),
    );
  }

  Widget _buildRadioSection() {
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

  Widget _buildSelectSection() {
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

  Widget _buildFormExample() {
    return Card(
      elevation: 1,
      child: Padding(
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
              child: ElevatedButton(
                onPressed: () => _showFormSubmitted(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BlueprintColors.intentPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
                  ),
                ),
                child: const Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFormSubmitted() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form submitted successfully!'),
        backgroundColor: BlueprintColors.intentSuccess,
      ),
    );
  }
}