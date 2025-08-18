import 'package:flutter/material.dart';
import '../../theme/blueprint_theme.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_slider.dart';

class SliderDemoSection extends StatefulWidget {
  const SliderDemoSection({Key? key}) : super(key: key);

  @override
  State<SliderDemoSection> createState() => _SliderDemoSectionState();
}

class _SliderDemoSectionState extends State<SliderDemoSection> {
  double _basicSlider = 50.0;
  double _intentSlider = 25.0;
  RangeValues _rangeSlider = const RangeValues(20.0, 80.0);
  double _verticalSlider = 60.0;

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
              'Basic Slider: ${_basicSlider.round()}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintSliders.simple(
              value: _basicSlider,
              onChanged: (value) => setState(() => _basicSlider = value),
              min: 0.0,
              max: 100.0,
              divisions: 10,
            ),
            const SizedBox(height: 16),
            
            Text(
              'Range Slider: ${_rangeSlider.start.round()} - ${_rangeSlider.end.round()}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintSliders.range(
              values: _rangeSlider,
              onChanged: (values) => setState(() => _rangeSlider = values),
              min: 0.0,
              max: 100.0,
              divisions: 10,
            ),
            const SizedBox(height: 16),
            
            Text(
              'Success Intent Slider: ${_intentSlider.round()}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintSliders.withIntent(
              value: _intentSlider,
              intent: BlueprintIntent.success,
              onChanged: (value) => setState(() => _intentSlider = value),
              min: 0.0,
              max: 100.0,
              divisions: 20,
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Text(
                  'Vertical Slider: ${_verticalSlider.round()}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: BlueprintColors.gray1,
                  ),
                ),
                const SizedBox(width: 32),
                BlueprintSliders.vertical(
                  value: _verticalSlider,
                  onChanged: (value) => setState(() => _verticalSlider = value),
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  intent: BlueprintIntent.warning,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}