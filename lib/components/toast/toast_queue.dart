import 'package:flutter/material.dart';
import 'toast_models.dart';
import 'toast_widget.dart';

/// Manages the queue of toasts and their positioning
class BlueprintToaster extends StatefulWidget {
  final BlueprintToastPosition position;
  final List<BlueprintToastOptions> children;

  const BlueprintToaster({
    Key? key,
    this.position = BlueprintToastPosition.topRight,
    this.children = const [],
  }) : super(key: key);

  @override
  State<BlueprintToaster> createState() => BlueprintToasterState();
}

class BlueprintToasterState extends State<BlueprintToaster> {
  final List<BlueprintToastOptions> _toasts = [];

  @override
  void initState() {
    super.initState();
    _toasts.addAll(widget.children);
  }

  void show(BlueprintToastOptions options) {
    if (mounted) {
      setState(() {
        _toasts.add(options);
      });
    }
  }

  void clear() {
    if (mounted) {
      setState(() {
        _toasts.clear();
      });
    }
  }

  void _removeToast(int index) {
    if (mounted && index >= 0 && index < _toasts.length) {
      setState(() {
        _toasts.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_toasts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: _isTopPosition() ? 20 : null,
      bottom: _isBottomPosition() ? 20 : null,
      left: _isLeftPosition() ? 20 : (_isCenterPosition() ? 0 : null),
      right: _isRightPosition() ? 20 : (_isCenterPosition() ? 0 : null),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: _getCrossAxisAlignment(),
        children: [
          for (int i = 0; i < _toasts.length; i++)
            BlueprintToast(
              key: ValueKey(_toasts[i].key ?? i),
              options: _toasts[i],
              onRemove: () => _removeToast(i),
            ),
        ],
      ),
    );
  }

  bool _isTopPosition() {
    return widget.position == BlueprintToastPosition.top ||
           widget.position == BlueprintToastPosition.topLeft ||
           widget.position == BlueprintToastPosition.topRight;
  }

  bool _isBottomPosition() {
    return widget.position == BlueprintToastPosition.bottom ||
           widget.position == BlueprintToastPosition.bottomLeft ||
           widget.position == BlueprintToastPosition.bottomRight;
  }

  bool _isLeftPosition() {
    return widget.position == BlueprintToastPosition.topLeft ||
           widget.position == BlueprintToastPosition.bottomLeft;
  }

  bool _isRightPosition() {
    return widget.position == BlueprintToastPosition.topRight ||
           widget.position == BlueprintToastPosition.bottomRight;
  }

  bool _isCenterPosition() {
    return widget.position == BlueprintToastPosition.top ||
           widget.position == BlueprintToastPosition.bottom;
  }

  CrossAxisAlignment _getCrossAxisAlignment() {
    if (_isLeftPosition()) {
      return CrossAxisAlignment.start;
    } else if (_isRightPosition()) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.center;
    }
  }
}

/// Global toaster singleton for easy access
class ToastManager {
  static BlueprintToasterState? _globalToaster;

  /// Initialize global toaster (call this in your main widget)
  static void initialize(BlueprintToasterState toaster) {
    _globalToaster = toaster;
  }

  /// Show toast using global toaster
  static void show(BlueprintToastOptions options) {
    _globalToaster?.show(options);
  }

  /// Clear all toasts
  static void clear() {
    _globalToaster?.clear();
  }

  /// Get the global toaster instance
  static BlueprintToasterState? get instance => _globalToaster;
}