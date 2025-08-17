import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_spinner.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_card.dart';

class SpinnerDemoPage extends StatefulWidget {
  const SpinnerDemoPage({Key? key}) : super(key: key);

  @override
  State<SpinnerDemoPage> createState() => _SpinnerDemoPageState();
}

class _SpinnerDemoPageState extends State<SpinnerDemoPage>
    with TickerProviderStateMixin {
  double _progressValue = 0.0;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _progressController.addListener(() {
      setState(() {
        _progressValue = _progressController.value;
      });
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _startProgress() {
    _progressController.reset();
    _progressController.forward();
  }

  void _stopProgress() {
    _progressController.stop();
  }

  void _resetProgress() {
    _progressController.reset();
    setState(() {
      _progressValue = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blueprint Spinners'),
        backgroundColor: BlueprintColors.intentPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Spinner Sizes', _buildSpinnerSizes()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Intent Colors', _buildIntentSpinners()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Progress Spinners', _buildProgressSpinners()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Inline Usage', _buildInlineSpinners()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Loading States', _buildLoadingStates()),
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

  Widget _buildSpinnerSizes() {
    return BlueprintCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              BlueprintSpinners.small(),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('Small (20px)', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              BlueprintSpinners.standard(),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('Standard (50px)', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              BlueprintSpinners.large(),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('Large (100px)', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              const BlueprintSpinner(size: 30),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('Custom (30px)', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntentSpinners() {
    return BlueprintCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              BlueprintSpinners.standard(intent: BlueprintIntent.none),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('None', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              BlueprintSpinners.standard(intent: BlueprintIntent.primary),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('Primary', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              BlueprintSpinners.standard(intent: BlueprintIntent.success),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('Success', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              BlueprintSpinners.standard(intent: BlueprintIntent.warning),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('Warning', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              BlueprintSpinners.standard(intent: BlueprintIntent.danger),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text('Danger', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSpinners() {
    return BlueprintCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  BlueprintSpinners.progress(value: 0.25),
                  const SizedBox(height: BlueprintTheme.gridSize),
                  const Text('25%', style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                children: [
                  BlueprintSpinners.progress(value: 0.5),
                  const SizedBox(height: BlueprintTheme.gridSize),
                  const Text('50%', style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                children: [
                  BlueprintSpinners.progress(value: 0.75),
                  const SizedBox(height: BlueprintTheme.gridSize),
                  const Text('75%', style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                children: [
                  BlueprintSpinners.progress(value: 1.0),
                  const SizedBox(height: BlueprintTheme.gridSize),
                  const Text('100%', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          const Divider(),
          const SizedBox(height: BlueprintTheme.gridSize * 2),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlueprintSpinners.progress(
                    value: _progressValue,
                    size: 60,
                    intent: BlueprintIntent.primary,
                  ),
                  const SizedBox(width: BlueprintTheme.gridSize * 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Animated Progress: ${(_progressValue * 100).round()}%',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: BlueprintTheme.gridSize),
                      Row(
                        children: [
                          BlueprintButton(
                            text: 'Start',
                            intent: BlueprintIntent.primary,
                            size: BlueprintButtonSize.small,
                            onPressed: _startProgress,
                          ),
                          const SizedBox(width: BlueprintTheme.gridSize * 0.5),
                          BlueprintButton(
                            text: 'Stop',
                            size: BlueprintButtonSize.small,
                            onPressed: _stopProgress,
                          ),
                          const SizedBox(width: BlueprintTheme.gridSize * 0.5),
                          BlueprintButton(
                            text: 'Reset',
                            size: BlueprintButtonSize.small,
                            onPressed: _resetProgress,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInlineSpinners() {
    return BlueprintCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BlueprintSpinners.inline(),
              const SizedBox(width: BlueprintTheme.gridSize),
              const Text('Loading data...'),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          Row(
            children: [
              BlueprintSpinners.inline(intent: BlueprintIntent.success),
              const SizedBox(width: BlueprintTheme.gridSize),
              const Text('Processing request...'),
            ],
          ),
          const SizedBox(height: BlueprintTheme.gridSize),
          Row(
            children: [
              BlueprintSpinners.inline(intent: BlueprintIntent.warning),
              const SizedBox(width: BlueprintTheme.gridSize),
              const Text('Validating form...'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingStates() {
    return Column(
      children: [
        BlueprintCard(
          child: Column(
            children: [
              const Text(
                'Loading Card Content',
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: BlueprintTheme.gridSize * 2),
              BlueprintSpinners.standard(intent: BlueprintIntent.primary),
              const SizedBox(height: BlueprintTheme.gridSize),
              const Text(
                'Please wait while we load your data...',
                style: TextStyle(color: BlueprintColors.textColorMuted),
              ),
            ],
          ),
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 2),
        BlueprintCard(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'File Upload Progress',
                    style: TextStyle(
                      fontSize: BlueprintTheme.fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: BlueprintTheme.gridSize * 0.5),
                  const Text(
                    'Uploading document.pdf...',
                    style: TextStyle(color: BlueprintColors.textColorMuted),
                  ),
                ],
              ),
              const Spacer(),
              BlueprintSpinners.progress(
                value: 0.67,
                size: 40,
                intent: BlueprintIntent.success,
              ),
              const SizedBox(width: BlueprintTheme.gridSize),
              const Text('67%'),
            ],
          ),
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 2),
        Row(
          children: [
            Expanded(
              child: BlueprintButton(
                text: 'Button with Spinner',
                loading: true,
                intent: BlueprintIntent.primary,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: BlueprintTheme.gridSize),
            Expanded(
              child: BlueprintButton(
                text: 'Save Changes',
                icon: Icons.save,
                intent: BlueprintIntent.success,
                onPressed: () => _showSnackBar('Changes saved!'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentSuccess,
      ),
    );
  }
}