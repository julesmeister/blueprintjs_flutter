import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

class ColorsDemoPage extends StatelessWidget {
  const ColorsDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Colors'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Intent Colors', _buildIntentColors(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Blue Scale', _buildBlueScale(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Green Scale', _buildGreenScale(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Orange Scale', _buildOrangeScale(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Red Scale', _buildRedScale(context)),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Gray Scale', _buildGrayScale(context)),
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

  Widget _buildIntentColors(BuildContext context) {
    return _buildColorRow(context, [
      ('Primary', BlueprintColors.intentPrimary),
      ('Success', BlueprintColors.intentSuccess),
      ('Warning', BlueprintColors.intentWarning),
      ('Danger', BlueprintColors.intentDanger),
    ]);
  }

  Widget _buildBlueScale(BuildContext context) {
    return _buildColorRow(context, [
      ('Blue1', BlueprintColors.blue1),
      ('Blue2', BlueprintColors.blue2),
      ('Blue3', BlueprintColors.blue3),
      ('Blue4', BlueprintColors.blue4),
      ('Blue5', BlueprintColors.blue5),
    ]);
  }

  Widget _buildGreenScale(BuildContext context) {
    return _buildColorRow(context, [
      ('Green1', BlueprintColors.green1),
      ('Green2', BlueprintColors.green2),
      ('Green3', BlueprintColors.green3),
      ('Green4', BlueprintColors.green4),
      ('Green5', BlueprintColors.green5),
    ]);
  }

  Widget _buildOrangeScale(BuildContext context) {
    return _buildColorRow(context, [
      ('Orange1', BlueprintColors.orange1),
      ('Orange2', BlueprintColors.orange2),
      ('Orange3', BlueprintColors.orange3),
      ('Orange4', BlueprintColors.orange4),
      ('Orange5', BlueprintColors.orange5),
    ]);
  }

  Widget _buildRedScale(BuildContext context) {
    return _buildColorRow(context, [
      ('Red1', BlueprintColors.red1),
      ('Red2', BlueprintColors.red2),
      ('Red3', BlueprintColors.red3),
      ('Red4', BlueprintColors.red4),
      ('Red5', BlueprintColors.red5),
    ]);
  }

  Widget _buildGrayScale(BuildContext context) {
    return Column(
      children: [
        _buildColorRow(context, [
          ('Black', BlueprintColors.black),
          ('Dark Gray1', BlueprintColors.darkGray1),
          ('Dark Gray2', BlueprintColors.darkGray2),
          ('Dark Gray3', BlueprintColors.darkGray3),
          ('Dark Gray4', BlueprintColors.darkGray4),
          ('Dark Gray5', BlueprintColors.darkGray5),
        ]),
        const SizedBox(height: BlueprintTheme.gridSize),
        _buildColorRow(context, [
          ('Gray1', BlueprintColors.gray1),
          ('Gray2', BlueprintColors.gray2),
          ('Gray3', BlueprintColors.gray3),
          ('Gray4', BlueprintColors.gray4),
          ('Gray5', BlueprintColors.gray5),
        ]),
        const SizedBox(height: BlueprintTheme.gridSize),
        _buildColorRow(context, [
          ('Light Gray1', BlueprintColors.lightGray1),
          ('Light Gray2', BlueprintColors.lightGray2),
          ('Light Gray3', BlueprintColors.lightGray3),
          ('Light Gray4', BlueprintColors.lightGray4),
          ('Light Gray5', BlueprintColors.lightGray5),
          ('White', BlueprintColors.white),
        ]),
      ],
    );
  }

  Widget _buildColorRow(BuildContext context, List<(String, Color)> colors) {
    return Wrap(
      spacing: BlueprintTheme.gridSize,
      runSpacing: BlueprintTheme.gridSize,
      children: colors
          .map((colorData) => _buildColorSwatch(context, colorData.$1, colorData.$2))
          .toList(),
    );
  }

  Widget _buildColorSwatch(BuildContext context, String name, Color color) {
    final hexColor = '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: hexColor));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Copied $hexColor to clipboard'),
            backgroundColor: BlueprintColors.intentSuccess,
            duration: const Duration(milliseconds: 1500),
          ),
        );
      },
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
          border: Border.all(color: BlueprintColors.dividerBlack),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(BlueprintTheme.borderRadius),
                  topRight: Radius.circular(BlueprintTheme.borderRadius),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: BlueprintColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hexColor,
                    style: const TextStyle(
                      fontSize: 10,
                      color: BlueprintColors.textColorMuted,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}