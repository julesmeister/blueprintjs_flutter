import 'package:flutter/material.dart';

/// Global singleton that manages dropdown state to ensure only one dropdown is open at a time
class BlueprintDropdownManager {
  static final BlueprintDropdownManager _instance = BlueprintDropdownManager._internal();
  factory BlueprintDropdownManager() => _instance;
  BlueprintDropdownManager._internal();

  VoidCallback? _currentDropdownCloser;

  /// Register a dropdown as open. This will close any previously open dropdown.
  void registerDropdown(VoidCallback closeCallback) {
    // Close any currently open dropdown
    closeAll();
    // Register the new dropdown
    _currentDropdownCloser = closeCallback;
  }

  /// Unregister a dropdown when it closes
  void unregisterDropdown(VoidCallback closeCallback) {
    if (_currentDropdownCloser == closeCallback) {
      _currentDropdownCloser = null;
    }
  }

  /// Close all open dropdowns
  void closeAll() {
    if (_currentDropdownCloser != null) {
      _currentDropdownCloser!();
      _currentDropdownCloser = null;
    }
  }
}