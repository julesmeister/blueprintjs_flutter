import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_input.dart';

class NumericInputDemoSection extends StatefulWidget {
  const NumericInputDemoSection({Key? key}) : super(key: key);

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
            Row(
              children: [
                Expanded(
                  child: BlueprintInputGroup(
                    placeholder: 'Enter number...',
                    value: _basicNumeric.toString(),
                    keyboardType: TextInputType.number,
                    leftIcon: Icons.numbers,
                    onChanged: (value) {
                      final parsed = double.tryParse(value);
                      if (parsed != null) {
                        setState(() => _basicNumeric = parsed);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => setState(() => _basicNumeric = _basicNumeric - 1),
                  icon: const Icon(Icons.remove),
                  style: IconButton.styleFrom(
                    backgroundColor: BlueprintColors.lightGray4,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () => setState(() => _basicNumeric = _basicNumeric + 1),
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(
                    backgroundColor: BlueprintColors.lightGray4,
                  ),
                ),
              ],
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
            Row(
              children: [
                Expanded(
                  child: BlueprintInputs.withIntent(
                    intent: BlueprintIntent.primary,
                    placeholder: 'Step by 2.5...',
                    value: _stepNumeric.toString(),
                    leftIcon: Icons.calculate,
                    onChanged: (value) {
                      final parsed = double.tryParse(value);
                      if (parsed != null) {
                        setState(() => _stepNumeric = parsed);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => setState(() => _stepNumeric = _stepNumeric - 2.5),
                  icon: const Icon(Icons.remove),
                  style: IconButton.styleFrom(
                    backgroundColor: BlueprintColors.blue5,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () => setState(() => _stepNumeric = _stepNumeric + 2.5),
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(
                    backgroundColor: BlueprintColors.blue5,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
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
            Row(
              children: [
                Expanded(
                  child: BlueprintInputs.withIntent(
                    intent: BlueprintIntent.success,
                    placeholder: 'Integer only...',
                    value: _integerNumeric.toString(),
                    leftIcon: Icons.filter_1,
                    onChanged: (value) {
                      final parsed = int.tryParse(value);
                      if (parsed != null) {
                        setState(() => _integerNumeric = parsed);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => setState(() => _integerNumeric = _integerNumeric - 1),
                  icon: const Icon(Icons.remove),
                  style: IconButton.styleFrom(
                    backgroundColor: BlueprintColors.green5,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () => setState(() => _integerNumeric = _integerNumeric + 1),
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(
                    backgroundColor: BlueprintColors.green5,
                    foregroundColor: Colors.white,
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