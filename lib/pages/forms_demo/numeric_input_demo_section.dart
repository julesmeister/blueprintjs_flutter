import 'package:flutter/material.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_input.dart';
import '../../components/blueprint_numeric_input.dart';
import '../../components/blueprint_common.dart';

class NumericInputDemoSection extends StatefulWidget {
  const NumericInputDemoSection({super.key});

  @override
  State<NumericInputDemoSection> createState() => _NumericInputDemoSectionState();
}

class _NumericInputDemoSectionState extends State<NumericInputDemoSection> {
  double _basicNumeric = 50.0;
  double _stepNumeric = 10.0;
  int _integerNumeric = 25;

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
              'Basic Numeric Input: ${_basicNumeric.toStringAsFixed(1)}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintNumericInput(
              value: _basicNumeric,
              onValueChange: (value) {
                setState(() => _basicNumeric = value ?? 0.0);
              },
              placeholder: 'Enter number...',
              leftIcon: Icons.numbers,
              fill: true,
            ),
            const SizedBox(height: 16),
            
            Text(
              'Step Numeric Input: ${_stepNumeric.toStringAsFixed(1)}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintNumericInput(
              value: _stepNumeric,
              onValueChange: (value) {
                setState(() => _stepNumeric = value ?? 0.0);
              },
              stepSize: 2.5,
              intent: BlueprintIntent.primary,
              placeholder: 'Step by 2.5...',
              leftIcon: Icons.calculate,
              fill: true,
            ),
            const SizedBox(height: 16),
            
            Text(
              'Integer Only: $_integerNumeric',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintNumericInput(
              value: _integerNumeric.toDouble(),
              onValueChange: (value) {
                setState(() => _integerNumeric = value?.round() ?? 0);
              },
              stepSize: 1,
              intent: BlueprintIntent.success,
              placeholder: 'Integer only...',
              leftIcon: Icons.filter_1,
              fill: true,
            ),
          ],
        ),
      ),
    );
  }
}