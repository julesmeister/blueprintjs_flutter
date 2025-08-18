import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

// Tree Node Data Structure
class BlueprintTreeNode<T> {
  final String id;
  final String label;
  final IconData? icon;
  final String? secondaryLabel;
  final List<BlueprintTreeNode<T>>? children;
  final T? nodeData;
  final bool isExpanded;
  final bool isSelected;
  final bool isDisabled;
  final bool hasCaret;

  const BlueprintTreeNode({
    required this.id,
    required this.label,
    this.icon,
    this.secondaryLabel,
    this.children,
    this.nodeData,
    this.isExpanded = false,
    this.isSelected = false,
    this.isDisabled = false,
    bool? hasCaret,
  }) : hasCaret = hasCaret ?? (children != null && children.length > 0);

  BlueprintTreeNode<T> copyWith({
    String? id,
    String? label,
    IconData? icon,
    String? secondaryLabel,
    List<BlueprintTreeNode<T>>? children,
    T? nodeData,
    bool? isExpanded,
    bool? isSelected,
    bool? isDisabled,
    bool? hasCaret,
  }) {
    return BlueprintTreeNode<T>(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      secondaryLabel: secondaryLabel ?? this.secondaryLabel,
      children: children ?? this.children,
      nodeData: nodeData ?? this.nodeData,
      isExpanded: isExpanded ?? this.isExpanded,
      isSelected: isSelected ?? this.isSelected,
      isDisabled: isDisabled ?? this.isDisabled,
      hasCaret: hasCaret ?? this.hasCaret,
    );
  }
}

// Tree Event Handlers
typedef BlueprintTreeEventHandler<T> = void Function(
  BlueprintTreeNode<T> node,
  List<int> nodePath,
);

typedef BlueprintTreeToggleHandler<T> = void Function(
  BlueprintTreeNode<T> node,
  List<int> nodePath,
);

// Main Tree Component
class BlueprintTree<T> extends StatelessWidget {
  final List<BlueprintTreeNode<T>> contents;
  final BlueprintTreeEventHandler<T>? onNodeClick;
  final BlueprintTreeEventHandler<T>? onNodeDoubleClick;
  final BlueprintTreeToggleHandler<T>? onNodeExpand;
  final BlueprintTreeToggleHandler<T>? onNodeCollapse;
  final bool compact;

  const BlueprintTree({
    Key? key,
    required this.contents,
    this.onNodeClick,
    this.onNodeDoubleClick,
    this.onNodeExpand,
    this.onNodeCollapse,
    this.compact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: _TreeNodeList<T>(
        nodes: contents,
        onNodeClick: onNodeClick,
        onNodeDoubleClick: onNodeDoubleClick,
        onNodeExpand: onNodeExpand,
        onNodeCollapse: onNodeCollapse,
        compact: compact,
        depth: 0,
        parentPath: [],
      ),
    );
  }
}

// Internal Tree Node List Widget
class _TreeNodeList<T> extends StatelessWidget {
  final List<BlueprintTreeNode<T>> nodes;
  final BlueprintTreeEventHandler<T>? onNodeClick;
  final BlueprintTreeEventHandler<T>? onNodeDoubleClick;
  final BlueprintTreeToggleHandler<T>? onNodeExpand;
  final BlueprintTreeToggleHandler<T>? onNodeCollapse;
  final bool compact;
  final int depth;
  final List<int> parentPath;

  const _TreeNodeList({
    required this.nodes,
    this.onNodeClick,
    this.onNodeDoubleClick,
    this.onNodeExpand,
    this.onNodeCollapse,
    required this.compact,
    required this.depth,
    required this.parentPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < nodes.length; i++)
          _TreeNodeWidget<T>(
            node: nodes[i],
            onNodeClick: onNodeClick,
            onNodeDoubleClick: onNodeDoubleClick,
            onNodeExpand: onNodeExpand,
            onNodeCollapse: onNodeCollapse,
            compact: compact,
            depth: depth,
            nodePath: [...parentPath, i],
          ),
      ],
    );
  }
}

// Individual Tree Node Widget
class _TreeNodeWidget<T> extends StatelessWidget {
  final BlueprintTreeNode<T> node;
  final BlueprintTreeEventHandler<T>? onNodeClick;
  final BlueprintTreeEventHandler<T>? onNodeDoubleClick;
  final BlueprintTreeToggleHandler<T>? onNodeExpand;
  final BlueprintTreeToggleHandler<T>? onNodeCollapse;
  final bool compact;
  final int depth;
  final List<int> nodePath;

  const _TreeNodeWidget({
    required this.node,
    this.onNodeClick,
    this.onNodeDoubleClick,
    this.onNodeExpand,
    this.onNodeCollapse,
    required this.compact,
    required this.depth,
    required this.nodePath,
  });

  @override
  Widget build(BuildContext context) {
    final rowHeight = compact ? 24.0 : 30.0; // Blueprint values
    final iconSpacing = compact ? 4.0 : 5.0;
    final paddingLeft = (rowHeight - iconSpacing) * depth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Node Content
        GestureDetector(
          onTap: node.isDisabled
              ? null
              : () => onNodeClick?.call(node, nodePath),
          onDoubleTap: node.isDisabled
              ? null
              : () => onNodeDoubleClick?.call(node, nodePath),
          child: Container(
            height: rowHeight,
            padding: EdgeInsets.only(
              left: paddingLeft,
              right: BlueprintTheme.gridSize * 0.5,
            ),
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
            ),
            child: Row(
              children: [
                // Caret
                _buildCaret(rowHeight, iconSpacing),
                // Icon
                if (node.icon != null) _buildIcon(iconSpacing),
                // Label
                Expanded(
                  child: _buildLabel(),
                ),
                // Secondary Label
                if (node.secondaryLabel != null) _buildSecondaryLabel(),
              ],
            ),
          ),
        ),
        // Children (if expanded)
        if (node.isExpanded && node.children != null && node.children!.isNotEmpty)
          _TreeNodeList<T>(
            nodes: node.children!,
            onNodeClick: onNodeClick,
            onNodeDoubleClick: onNodeDoubleClick,
            onNodeExpand: onNodeExpand,
            onNodeCollapse: onNodeCollapse,
            compact: compact,
            depth: depth + 1,
            parentPath: nodePath,
          ),
      ],
    );
  }

  Widget _buildCaret(double rowHeight, double iconSpacing) {
    return SizedBox(
      width: rowHeight,
      height: rowHeight,
      child: node.hasCaret
          ? IconButton(
              onPressed: node.isDisabled
                  ? null
                  : () {
                      if (node.isExpanded) {
                        onNodeCollapse?.call(node, nodePath);
                      } else {
                        onNodeExpand?.call(node, nodePath);
                      }
                    },
              padding: EdgeInsets.all(iconSpacing),
              iconSize: 16,
              icon: AnimatedRotation(
                turns: node.isExpanded ? 0.25 : 0.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: Icon(
                  Icons.chevron_right,
                  color: node.isDisabled
                      ? BlueprintColors.textColorDisabled
                      : BlueprintColors.gray3,
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildIcon(double iconSpacing) {
    return Container(
      margin: EdgeInsets.only(right: iconSpacing),
      child: Icon(
        node.icon,
        size: 16,
        color: node.isDisabled
            ? BlueprintColors.textColorDisabled
            : node.isSelected
                ? Colors.white
                : BlueprintColors.gray3,
      ),
    );
  }

  Widget _buildLabel() {
    return Text(
      node.label,
      style: TextStyle(
        fontSize: BlueprintTheme.fontSize,
        color: node.isDisabled
            ? BlueprintColors.textColorDisabled
            : node.isSelected
                ? Colors.white
                : BlueprintColors.textColor,
        fontWeight: FontWeight.normal,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSecondaryLabel() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: BlueprintTheme.gridSize * 0.5),
      child: Text(
        node.secondaryLabel!,
        style: TextStyle(
          fontSize: BlueprintTheme.fontSizeSmall,
          color: node.isDisabled
              ? BlueprintColors.textColorDisabled
              : node.isSelected
                  ? Colors.white.withOpacity(0.8)
                  : BlueprintColors.textColorMuted,
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (node.isSelected) {
      return BlueprintColors.intentPrimary;
    }
    return Colors.transparent;
  }
}

// Convenience Factory Methods
class BlueprintTrees {
  static Widget simple<T>({
    required List<BlueprintTreeNode<T>> contents,
    BlueprintTreeEventHandler<T>? onNodeClick,
    BlueprintTreeToggleHandler<T>? onNodeExpand,
    BlueprintTreeToggleHandler<T>? onNodeCollapse,
  }) {
    return BlueprintTree<T>(
      contents: contents,
      onNodeClick: onNodeClick,
      onNodeExpand: onNodeExpand,
      onNodeCollapse: onNodeCollapse,
    );
  }

  static Widget compact<T>({
    required List<BlueprintTreeNode<T>> contents,
    BlueprintTreeEventHandler<T>? onNodeClick,
    BlueprintTreeToggleHandler<T>? onNodeExpand,
    BlueprintTreeToggleHandler<T>? onNodeCollapse,
  }) {
    return BlueprintTree<T>(
      contents: contents,
      onNodeClick: onNodeClick,
      onNodeExpand: onNodeExpand,
      onNodeCollapse: onNodeCollapse,
      compact: true,
    );
  }

  static Widget interactive<T>({
    required List<BlueprintTreeNode<T>> contents,
    required BlueprintTreeEventHandler<T> onNodeClick,
    BlueprintTreeEventHandler<T>? onNodeDoubleClick,
    BlueprintTreeToggleHandler<T>? onNodeExpand,
    BlueprintTreeToggleHandler<T>? onNodeCollapse,
  }) {
    return BlueprintTree<T>(
      contents: contents,
      onNodeClick: onNodeClick,
      onNodeDoubleClick: onNodeDoubleClick,
      onNodeExpand: onNodeExpand,
      onNodeCollapse: onNodeCollapse,
    );
  }
}