import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/demo_page_scaffold.dart';
import 'forms_demo/input_demo_section.dart';
import 'forms_demo/checkbox_demo_section.dart';
import 'forms_demo/radio_demo_section.dart';
import 'forms_demo/select_demo_section.dart';
import 'forms_demo/slider_demo_section.dart';
import 'forms_demo/file_input_demo_section.dart';
import 'forms_demo/numeric_input_demo_section.dart';
import 'forms_demo/textarea_demo_section.dart';
import 'forms_demo/form_example_section.dart';

class FormsDemoPage extends StatefulWidget {
  const FormsDemoPage({Key? key}) : super(key: key);

  @override
  State<FormsDemoPage> createState() => _FormsDemoPageState();
}

class _FormsDemoPageState extends State<FormsDemoPage> {
  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Forms',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Input Fields', const InputDemoSection()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Checkboxes', const CheckboxDemoSection()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Radio Buttons', const RadioDemoSection()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Select Dropdowns', const SelectDemoSection()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Sliders & Ranges', const SliderDemoSection()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('File Inputs', const FileInputDemoSection()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Numeric Inputs', const NumericInputDemoSection()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Text Areas', const TextAreaDemoSection()),
          const SizedBox(height: BlueprintTheme.gridSize * 3),
          _buildSection('Form Example', const FormExampleSection()),
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
}