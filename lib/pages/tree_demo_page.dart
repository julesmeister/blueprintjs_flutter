import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../components/blueprint_tree.dart';
import '../components/blueprint_button.dart';
import '../components/blueprint_switch.dart';
import '../components/demo_page_scaffold.dart';
import '../components/blueprint_common.dart';

class TreeDemoPage extends StatefulWidget {
  const TreeDemoPage({Key? key}) : super(key: key);

  @override
  State<TreeDemoPage> createState() => _TreeDemoPageState();
}

class _TreeDemoPageState extends State<TreeDemoPage> {
  List<BlueprintTreeNode<String>> _basicTreeData = [];
  List<BlueprintTreeNode<Map<String, dynamic>>> _fileSystemData = [];
  bool _compactMode = false;

  @override
  void initState() {
    super.initState();
    _initializeTreeData();
  }

  void _initializeTreeData() {
    // Basic Tree Data
    _basicTreeData = [
      BlueprintTreeNode<String>(
        id: '1',
        label: 'Root Node 1',
        icon: Icons.folder,
        isExpanded: true,
        children: [
          BlueprintTreeNode<String>(
            id: '1.1',
            label: 'Child Node 1.1',
            icon: Icons.description,
            nodeData: 'File data 1.1',
          ),
          BlueprintTreeNode<String>(
            id: '1.2',
            label: 'Child Node 1.2',
            icon: Icons.folder,
            isExpanded: false,
            children: [
              BlueprintTreeNode<String>(
                id: '1.2.1',
                label: 'Nested Child 1.2.1',
                icon: Icons.description,
                nodeData: 'Nested file data',
              ),
              BlueprintTreeNode<String>(
                id: '1.2.2',
                label: 'Nested Child 1.2.2',
                icon: Icons.description,
                secondaryLabel: 'Modified',
              ),
            ],
          ),
          BlueprintTreeNode<String>(
            id: '1.3',
            label: 'Child Node 1.3',
            icon: Icons.description,
            isSelected: true,
            nodeData: 'Selected file',
          ),
        ],
      ),
      BlueprintTreeNode<String>(
        id: '2',
        label: 'Root Node 2',
        icon: Icons.folder,
        isExpanded: false,
        children: [
          BlueprintTreeNode<String>(
            id: '2.1',
            label: 'Child Node 2.1',
            icon: Icons.description,
            isDisabled: true,
          ),
          BlueprintTreeNode<String>(
            id: '2.2',
            label: 'Child Node 2.2',
            icon: Icons.description,
            secondaryLabel: 'New',
          ),
        ],
      ),
      BlueprintTreeNode<String>(
        id: '3',
        label: 'Leaf Node (No Children)',
        icon: Icons.description,
        nodeData: 'Single leaf node',
      ),
    ];

    // File System Tree Data
    _fileSystemData = [
      BlueprintTreeNode<Map<String, dynamic>>(
        id: 'root',
        label: 'Project Root',
        icon: Icons.folder_open,
        isExpanded: true,
        nodeData: {'type': 'folder', 'path': '/'},
        children: [
          BlueprintTreeNode<Map<String, dynamic>>(
            id: 'src',
            label: 'src',
            icon: Icons.folder,
            isExpanded: true,
            nodeData: {'type': 'folder', 'path': '/src'},
            children: [
              BlueprintTreeNode<Map<String, dynamic>>(
                id: 'components',
                label: 'components',
                icon: Icons.folder,
                isExpanded: false,
                nodeData: {'type': 'folder', 'path': '/src/components'},
                children: [
                  BlueprintTreeNode<Map<String, dynamic>>(
                    id: 'button.dart',
                    label: 'button.dart',
                    icon: Icons.code,
                    secondaryLabel: '2.1 KB',
                    nodeData: {'type': 'file', 'path': '/src/components/button.dart', 'size': 2100},
                  ),
                  BlueprintTreeNode<Map<String, dynamic>>(
                    id: 'tree.dart',
                    label: 'tree.dart',
                    icon: Icons.code,
                    secondaryLabel: '5.4 KB',
                    isSelected: true,
                    nodeData: {'type': 'file', 'path': '/src/components/tree.dart', 'size': 5400},
                  ),
                ],
              ),
              BlueprintTreeNode<Map<String, dynamic>>(
                id: 'pages',
                label: 'pages',
                icon: Icons.folder,
                isExpanded: false,
                nodeData: {'type': 'folder', 'path': '/src/pages'},
                children: [
                  BlueprintTreeNode<Map<String, dynamic>>(
                    id: 'home.dart',
                    label: 'home.dart',
                    icon: Icons.home,
                    secondaryLabel: '1.8 KB',
                    nodeData: {'type': 'file', 'path': '/src/pages/home.dart', 'size': 1800},
                  ),
                ],
              ),
              BlueprintTreeNode<Map<String, dynamic>>(
                id: 'main.dart',
                label: 'main.dart',
                icon: Icons.play_arrow,
                secondaryLabel: '950 B',
                nodeData: {'type': 'file', 'path': '/src/main.dart', 'size': 950},
              ),
            ],
          ),
          BlueprintTreeNode<Map<String, dynamic>>(
            id: 'test',
            label: 'test',
            icon: Icons.folder,
            isExpanded: false,
            nodeData: {'type': 'folder', 'path': '/test'},
            children: [
              BlueprintTreeNode<Map<String, dynamic>>(
                id: 'widget_test.dart',
                label: 'widget_test.dart',
                icon: Icons.bug_report,
                secondaryLabel: '1.2 KB',
                nodeData: {'type': 'file', 'path': '/test/widget_test.dart', 'size': 1200},
              ),
            ],
          ),
          BlueprintTreeNode<Map<String, dynamic>>(
            id: 'README.md',
            label: 'README.md',
            icon: Icons.description,
            secondaryLabel: '3.2 KB',
            nodeData: {'type': 'file', 'path': '/README.md', 'size': 3200},
          ),
          BlueprintTreeNode<Map<String, dynamic>>(
            id: 'pubspec.yaml',
            label: 'pubspec.yaml',
            icon: Icons.settings,
            secondaryLabel: '1.1 KB',
            nodeData: {'type': 'file', 'path': '/pubspec.yaml', 'size': 1100},
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      title: 'Tree Components',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            _buildControls(),
            const SizedBox(height: BlueprintTheme.gridSize * 2),
            _buildSection('Basic Tree', _buildBasicTree()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('File System Tree', _buildFileSystemTree()),
            const SizedBox(height: BlueprintTheme.gridSize * 3),
            _buildSection('Interactive Features', _buildInteractiveDemo()),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize),
      decoration: BoxDecoration(
        color: BlueprintColors.lightGray5,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
      ),
      child: Row(
        children: [
          const Text(
            'Tree Options:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: BlueprintColors.headingColor,
            ),
          ),
          const SizedBox(width: BlueprintTheme.gridSize),
          BlueprintSwitches.withLabel(
            label: 'Compact Mode',
            value: _compactMode,
            onChanged: (value) => setState(() => _compactMode = value),
          ),
          const SizedBox(width: BlueprintTheme.gridSize * 2),
          BlueprintButton(
            text: 'Expand All',
            variant: BlueprintButtonVariant.minimal,
            icon: Icons.unfold_more,
            onPressed: _expandAll,
          ),
          const SizedBox(width: BlueprintTheme.gridSize),
          BlueprintButton(
            text: 'Collapse All',
            variant: BlueprintButtonVariant.minimal,
            icon: Icons.unfold_less,
            onPressed: _collapseAll,
          ),
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
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: BlueprintColors.gray3),
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
          ),
          child: content,
        ),
      ],
    );
  }

  Widget _buildBasicTree() {
    return BlueprintTrees.interactive<String>(
      contents: _basicTreeData,
      onNodeClick: _handleNodeClick,
      onNodeDoubleClick: _handleNodeDoubleClick,
      onNodeExpand: _handleNodeExpand,
      onNodeCollapse: _handleNodeCollapse,
    );
  }

  Widget _buildFileSystemTree() {
    return _compactMode
        ? BlueprintTrees.compact<Map<String, dynamic>>(
            contents: _fileSystemData,
            onNodeClick: _handleFileNodeClick,
            onNodeExpand: _handleFileNodeExpand,
            onNodeCollapse: _handleFileNodeCollapse,
          )
        : BlueprintTrees.simple<Map<String, dynamic>>(
            contents: _fileSystemData,
            onNodeClick: _handleFileNodeClick,
            onNodeExpand: _handleFileNodeExpand,
            onNodeCollapse: _handleFileNodeCollapse,
          );
  }

  Widget _buildInteractiveDemo() {
    return Container(
      padding: const EdgeInsets.all(BlueprintTheme.gridSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tree Features:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: BlueprintTheme.gridSize * 0.5),
          const Text('• Click nodes to select them'),
          const Text('• Double-click for additional actions'),
          const Text('• Use caret icons to expand/collapse folders'),
          const Text('• Disabled nodes cannot be interacted with'),
          const Text('• Secondary labels show additional information'),
          const Text('• Hierarchical indentation shows nesting levels'),
          const Text('• Smooth animations for expand/collapse'),
        ],
      ),
    );
  }

  void _handleNodeClick(BlueprintTreeNode<String> node, List<int> nodePath) {
    setState(() {
      _basicTreeData = _updateNodeSelection(_basicTreeData, nodePath, node.id);
    });
    _showSnackBar('Selected: ${node.label}');
  }

  void _handleNodeDoubleClick(BlueprintTreeNode<String> node, List<int> nodePath) {
    _showSnackBar('Double-clicked: ${node.label}');
  }

  void _handleNodeExpand(BlueprintTreeNode<String> node, List<int> nodePath) {
    setState(() {
      _basicTreeData = _updateNodeExpansion(_basicTreeData, nodePath, true);
    });
  }

  void _handleNodeCollapse(BlueprintTreeNode<String> node, List<int> nodePath) {
    setState(() {
      _basicTreeData = _updateNodeExpansion(_basicTreeData, nodePath, false);
    });
  }

  void _handleFileNodeClick(BlueprintTreeNode<Map<String, dynamic>> node, List<int> nodePath) {
    setState(() {
      _fileSystemData = _updateFileNodeSelection(_fileSystemData, nodePath, node.id);
    });
    
    final data = node.nodeData;
    if (data != null) {
      final type = data['type'] ?? 'unknown';
      final path = data['path'] ?? 'unknown';
      _showSnackBar('Selected $type: $path');
    }
  }

  void _handleFileNodeExpand(BlueprintTreeNode<Map<String, dynamic>> node, List<int> nodePath) {
    setState(() {
      _fileSystemData = _updateFileNodeExpansion(_fileSystemData, nodePath, true);
    });
  }

  void _handleFileNodeCollapse(BlueprintTreeNode<Map<String, dynamic>> node, List<int> nodePath) {
    setState(() {
      _fileSystemData = _updateFileNodeExpansion(_fileSystemData, nodePath, false);
    });
  }

  void _expandAll() {
    setState(() {
      _basicTreeData = _setAllExpanded(_basicTreeData, true);
      _fileSystemData = _setAllFileExpanded(_fileSystemData, true);
    });
    _showSnackBar('Expanded all nodes');
  }

  void _collapseAll() {
    setState(() {
      _basicTreeData = _setAllExpanded(_basicTreeData, false);
      _fileSystemData = _setAllFileExpanded(_fileSystemData, false);
    });
    _showSnackBar('Collapsed all nodes');
  }

  List<BlueprintTreeNode<String>> _updateNodeSelection(
    List<BlueprintTreeNode<String>> nodes,
    List<int> nodePath,
    String selectedId,
  ) {
    return nodes.map((node) {
      if (nodePath.isEmpty) {
        return node.copyWith(isSelected: node.id == selectedId);
      }
      
      final currentIndex = nodePath.first;
      final remainingPath = nodePath.skip(1).toList();
      
      if (nodes.indexOf(node) == currentIndex) {
        return node.copyWith(
          children: node.children != null
              ? _updateNodeSelection(node.children!, remainingPath, selectedId)
              : null,
          isSelected: remainingPath.isEmpty ? node.id == selectedId : false,
        );
      }
      
      return node.copyWith(isSelected: false);
    }).toList();
  }

  List<BlueprintTreeNode<String>> _updateNodeExpansion(
    List<BlueprintTreeNode<String>> nodes,
    List<int> nodePath,
    bool isExpanded,
  ) {
    if (nodePath.isEmpty) return nodes;
    
    return nodes.asMap().entries.map((entry) {
      final index = entry.key;
      final node = entry.value;
      
      if (index == nodePath.first) {
        if (nodePath.length == 1) {
          return node.copyWith(isExpanded: isExpanded);
        } else {
          return node.copyWith(
            children: node.children != null
                ? _updateNodeExpansion(node.children!, nodePath.skip(1).toList(), isExpanded)
                : null,
          );
        }
      }
      
      return node;
    }).toList();
  }

  List<BlueprintTreeNode<Map<String, dynamic>>> _updateFileNodeSelection(
    List<BlueprintTreeNode<Map<String, dynamic>>> nodes,
    List<int> nodePath,
    String selectedId,
  ) {
    return nodes.map((node) {
      if (nodePath.isEmpty) {
        return node.copyWith(isSelected: node.id == selectedId);
      }
      
      final currentIndex = nodePath.first;
      final remainingPath = nodePath.skip(1).toList();
      
      if (nodes.indexOf(node) == currentIndex) {
        return node.copyWith(
          children: node.children != null
              ? _updateFileNodeSelection(node.children!, remainingPath, selectedId)
              : null,
          isSelected: remainingPath.isEmpty ? node.id == selectedId : false,
        );
      }
      
      return node.copyWith(isSelected: false);
    }).toList();
  }

  List<BlueprintTreeNode<Map<String, dynamic>>> _updateFileNodeExpansion(
    List<BlueprintTreeNode<Map<String, dynamic>>> nodes,
    List<int> nodePath,
    bool isExpanded,
  ) {
    if (nodePath.isEmpty) return nodes;
    
    return nodes.asMap().entries.map((entry) {
      final index = entry.key;
      final node = entry.value;
      
      if (index == nodePath.first) {
        if (nodePath.length == 1) {
          return node.copyWith(isExpanded: isExpanded);
        } else {
          return node.copyWith(
            children: node.children != null
                ? _updateFileNodeExpansion(node.children!, nodePath.skip(1).toList(), isExpanded)
                : null,
          );
        }
      }
      
      return node;
    }).toList();
  }

  List<BlueprintTreeNode<String>> _setAllExpanded(
    List<BlueprintTreeNode<String>> nodes,
    bool isExpanded,
  ) {
    return nodes.map((node) {
      return node.copyWith(
        isExpanded: node.children != null ? isExpanded : node.isExpanded,
        children: node.children != null
            ? _setAllExpanded(node.children!, isExpanded)
            : null,
      );
    }).toList();
  }

  List<BlueprintTreeNode<Map<String, dynamic>>> _setAllFileExpanded(
    List<BlueprintTreeNode<Map<String, dynamic>>> nodes,
    bool isExpanded,
  ) {
    return nodes.map((node) {
      return node.copyWith(
        isExpanded: node.children != null ? isExpanded : node.isExpanded,
        children: node.children != null
            ? _setAllFileExpanded(node.children!, isExpanded)
            : null,
      );
    }).toList();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentPrimary,
      ),
    );
  }
}