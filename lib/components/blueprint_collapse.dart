import 'blueprint_common.dart';
import 'blueprint_button.dart';

class BlueprintCollapse extends StatefulWidget {
  final Widget child;
  final bool isOpen;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onToggle;

  const BlueprintCollapse({
    Key? key,
    required this.child,
    this.isOpen = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.onToggle,
  }) : super(key: key);

  @override
  State<BlueprintCollapse> createState() => _BlueprintCollapseState();
}

class _BlueprintCollapseState extends State<BlueprintCollapse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    if (widget.isOpen) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(BlueprintCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isOpen != widget.isOpen) {
      if (widget.isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: widget.child,
    );
  }
}

// Blueprint.js Collapse is just the animation wrapper - no built-in trigger
// Use separate Button components to control collapse state

// Helper widget that combines Button + Collapse for common use case
class BlueprintCollapseExample extends StatefulWidget {
  final String buttonText;
  final Widget child;
  final bool initiallyOpen;

  const BlueprintCollapseExample({
    Key? key,
    required this.buttonText,
    required this.child,
    this.initiallyOpen = false,
  }) : super(key: key);

  @override
  State<BlueprintCollapseExample> createState() => _BlueprintCollapseExampleState();
}

class _BlueprintCollapseExampleState extends State<BlueprintCollapseExample> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.initiallyOpen;
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BlueprintButton(
              text: widget.buttonText,
              onPressed: _toggle,
              intent: BlueprintIntent.primary,
            ),
          ],
        ),
        BlueprintCollapse(
          isOpen: _isOpen,
          child: widget.child,
        ),
      ],
    );
  }
}