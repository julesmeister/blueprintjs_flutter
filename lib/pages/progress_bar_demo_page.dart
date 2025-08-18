import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_progress_bar.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_card.dart';
import '../components/demo_page_scaffold.dart';

class ProgressBarDemoPage extends StatefulWidget {
  const ProgressBarDemoPage({Key? key}) : super(key: key);

  @override
  State<ProgressBarDemoPage> createState() => _ProgressBarDemoPageState();
}

class _ProgressBarDemoPageState extends State<ProgressBarDemoPage>
    with TickerProviderStateMixin {
  double _progressValue = 0.0;
  late AnimationController _progressController;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _progressController.addListener(() {
      setState(() {
        _progressValue = _progressController.value;
      });
    });
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAnimating = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _startProgress() {
    setState(() {
      _isAnimating = true;
    });
    _progressController.reset();
    _progressController.forward();
  }

  void _stopProgress() {
    _progressController.stop();
    setState(() {
      _isAnimating = false;
    });
  }

  void _resetProgress() {
    _progressController.reset();
    setState(() {
      _progressValue = 0.0;
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Blueprint Progress Bars',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildSection('Basic Progress Bars', _buildBasicProgressBars()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Intent Colors', _buildIntentProgressBars()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Sizes', _buildSizeProgressBars()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Animation Options', _buildAnimationOptions()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Interactive Progress', _buildInteractiveProgress()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Use Cases', _buildUseCases()),
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

  Widget _buildBasicProgressBars() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProgressExample('25% Complete', 0.25),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          _buildProgressExample('50% Complete', 0.5),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          _buildProgressExample('75% Complete', 0.75),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          _buildProgressExample('100% Complete', 1.0),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          const Divider(),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          const Text(
            'Indeterminate Progress:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBars.indeterminate(),
        ],
      ),
    );
  }

  Widget _buildIntentProgressBars() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntentExample('None (Default)', BlueprintIntent.none, 0.6),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          _buildIntentExample('Primary', BlueprintIntent.primary, 0.6),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          _buildIntentExample('Success', BlueprintIntent.success, 0.6),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          _buildIntentExample('Warning', BlueprintIntent.warning, 0.6),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          _buildIntentExample('Danger', BlueprintIntent.danger, 0.6),
        ],
      ),
    );
  }

  Widget _buildSizeProgressBars() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Small (4px height):',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBars.small(value: 0.7, intent: BlueprintIntent.primary),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          const Text(
            'Standard (8px height):',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBars.determinate(value: 0.7, intent: BlueprintIntent.success),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          const Text(
            'Large (12px height):',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBars.large(value: 0.7, intent: BlueprintIntent.warning),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          const Text(
            'Custom (16px height):',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBar(
            value: 0.7,
            intent: BlueprintIntent.danger,
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationOptions() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'With Animation & Stripes (Default):',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBar(
            value: 0.8,
            intent: BlueprintIntent.primary,
            animate: true,
            stripes: true,
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          const Text(
            'No Animation:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBar(
            value: 0.8,
            intent: BlueprintIntent.success,
            animate: false,
            stripes: true,
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          const Text(
            'No Stripes:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBar(
            value: 0.8,
            intent: BlueprintIntent.warning,
            animate: true,
            stripes: false,
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          const Text(
            'No Animation & No Stripes:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBar(
            value: 0.8,
            intent: BlueprintIntent.danger,
            animate: false,
            stripes: false,
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveProgress() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Animated Progress: ${(_progressValue * 100).round()}%',
            style: const TextStyle(
              fontSize: BlueprintTheme.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBar(
            value: _progressValue,
            intent: BlueprintIntent.primary,
            height: 10,
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Row(
            children: [
              BlueprintButton(
                text: 'Start',
                intent: BlueprintIntent.success,
                size: BlueprintButtonSize.small,
                disabled: _isAnimating,
                onPressed: _startProgress,
              ),
              const SizedBox(width: BlueprintTheme.gridSize),
              BlueprintButton(
                text: 'Stop',
                intent: BlueprintIntent.warning,
                size: BlueprintButtonSize.small,
                disabled: !_isAnimating,
                onPressed: _stopProgress,
              ),
              const SizedBox(width: BlueprintTheme.gridSize),
              BlueprintButton(
                text: 'Reset',
                size: BlueprintButtonSize.small,
                onPressed: _resetProgress,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUseCases() {
    return Column(
      children: [
        _buildFileUploadExample(),
        const SizedBox(height: BlueprintTheme.gridSize * 2),
        _buildSystemLoadExample(),
        const SizedBox(height: BlueprintTheme.gridSize * 2),
        _buildMultiStepExample(),
      ],
    );
  }

  Widget _buildFileUploadExample() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.cloud_upload, color: BlueprintColors.intentPrimary),
              const SizedBox(width: BlueprintTheme.gridSize),
              const Text(
                'File Upload Progress',
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          const Text(
            'document.pdf (2.4 MB)',
            style: TextStyle(color: BlueprintColors.textColorMuted),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBar(
            value: 0.67,
            intent: BlueprintIntent.success,
            height: 6,
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 0.5),
          const Text(
            '67% complete • 1.2 MB remaining',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSizeSmall,
              color: BlueprintColors.textColorMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemLoadExample() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.memory, color: BlueprintColors.intentWarning),
              const SizedBox(width: BlueprintTheme.gridSize),
              const Text(
                'System Resources',
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 1.5),
          _buildResourceBar('CPU Usage', 0.45, BlueprintIntent.success),
          const SizedBox(height: BlueprintTheme.gridSize),
          _buildResourceBar('Memory', 0.72, BlueprintIntent.warning),
          const SizedBox(height: BlueprintTheme.gridSize),
          _buildResourceBar('Disk I/O', 0.23, BlueprintIntent.primary),
        ],
      ),
    );
  }

  Widget _buildMultiStepExample() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.list_alt, color: BlueprintColors.intentPrimary),
              const SizedBox(width: BlueprintTheme.gridSize),
              const Text(
                'Multi-Step Process',
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          const Text(
            'Step 3 of 5: Processing data...',
            style: TextStyle(color: BlueprintColors.textColorMuted),
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          BlueprintProgressBar(
            value: 0.6,
            intent: BlueprintIntent.primary,
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressExample(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        BlueprintProgressBar(value: value),
      ],
    );
  }

  Widget _buildIntentExample(String label, BlueprintIntent intent, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: BlueprintTheme.gridSize),
        BlueprintProgressBar(value: value, intent: intent),
      ],
    );
  }

  Widget _buildResourceBar(String label, double value, BlueprintIntent intent) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(fontSize: BlueprintTheme.fontSizeSmall),
          ),
        ),
        Expanded(
          child: BlueprintProgressBar(
            value: value,
            intent: intent,
            height: 6,
            stripes: false,
          ),
        ),
        const SizedBox(width: BlueprintTheme.gridSize),
        SizedBox(
          width: 40,
          child: Text(
            '${(value * 100).round()}%',
            style: const TextStyle(
              fontSize: BlueprintTheme.fontSizeSmall,
              color: BlueprintColors.textColorMuted,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}