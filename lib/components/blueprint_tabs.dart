import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';

class BlueprintTab {
  final String id;
  final String title;
  final Widget content;
  final IconData? icon;
  final String? badge;
  final bool disabled;

  const BlueprintTab({
    required this.id,
    required this.title,
    required this.content,
    this.icon,
    this.badge,
    this.disabled = false,
  });
}

enum BlueprintTabSize {
  medium,
  large,
}

class BlueprintTabs extends StatefulWidget {
  final List<BlueprintTab> tabs;
  final String? selectedTabId;
  final String? defaultSelectedTabId;
  final Function(String tabId)? onTabChanged;
  final bool animate;
  final bool vertical;
  final bool fill;
  final BlueprintTabSize size;
  final bool renderActiveTabPanelOnly;
  final Widget? trailing;

  const BlueprintTabs({
    Key? key,
    required this.tabs,
    this.selectedTabId,
    this.defaultSelectedTabId,
    this.onTabChanged,
    this.animate = true,
    this.vertical = false,
    this.fill = false,
    this.size = BlueprintTabSize.medium,
    this.renderActiveTabPanelOnly = false,
    this.trailing,
  }) : super(key: key);

  @override
  State<BlueprintTabs> createState() => _BlueprintTabsState();
}

class _BlueprintTabsState extends State<BlueprintTabs>
    with TickerProviderStateMixin {
  late String _selectedTabId;
  late TabController _tabController;
  bool _updatingFromParent = false;

  @override
  void initState() {
    super.initState();
    _selectedTabId = widget.selectedTabId ??
        widget.defaultSelectedTabId ??
        (widget.tabs.isNotEmpty ? widget.tabs.first.id : '');
    
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: _getTabIndex(_selectedTabId),
    );
    
    _tabController.addListener(_handleTabControllerChange);
  }

  @override
  void didUpdateWidget(BlueprintTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.tabs.length != oldWidget.tabs.length) {
      _tabController.dispose();
      _tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: _getTabIndex(_selectedTabId),
      );
      _tabController.addListener(_handleTabControllerChange);
    }
    
    if (widget.selectedTabId != null && widget.selectedTabId != _selectedTabId) {
      _updatingFromParent = true;
      _selectedTabId = widget.selectedTabId!;
      final newIndex = _getTabIndex(_selectedTabId);
      if (newIndex != _tabController.index && _tabController.length > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _tabController.length > newIndex) {
            _tabController.animateTo(newIndex);
          }
        });
      }
      _updatingFromParent = false;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _getTabIndex(String tabId) {
    final index = widget.tabs.indexWhere((tab) => tab.id == tabId);
    return index >= 0 ? index : 0;
  }

  void _handleTabControllerChange() {
    if (!mounted) return;
    
    if (!_tabController.indexIsChanging && 
        _tabController.index >= 0 && 
        _tabController.index < widget.tabs.length &&
        widget.tabs.isNotEmpty) {
      final newTabId = widget.tabs[_tabController.index].id;
      if (newTabId != _selectedTabId) {
        setState(() {
          _selectedTabId = newTabId;
        });
        // Only call onTabChanged if this change originated from user interaction,
        // not from external selectedTabId changes
        if (!_updatingFromParent) {
          widget.onTabChanged?.call(newTabId);
        }
      }
    }
  }

  double get _tabHeight {
    double baseHeight;
    switch (widget.size) {
      case BlueprintTabSize.medium:
        baseHeight = BlueprintTheme.buttonHeight;
        break;
      case BlueprintTabSize.large:
        baseHeight = BlueprintTheme.buttonHeightLarge;
        break;
    }
    
    // Add extra height if any tabs have badges to prevent cramping
    bool hasBadges = widget.tabs.any((tab) => tab.badge != null);
    if (hasBadges) {
      return baseHeight + 4; // Add 4px extra height for badge accommodation
    }
    
    return baseHeight;
  }

  double get _fontSize {
    switch (widget.size) {
      case BlueprintTabSize.medium:
        return BlueprintTheme.fontSize;
      case BlueprintTabSize.large:
        return BlueprintTheme.fontSizeLarge;
    }
  }

  Widget _buildTabContent(BlueprintTab tab, bool isSelected) {
    final List<Widget> children = [];

    if (tab.icon != null) {
      children.add(
        Icon(
          tab.icon,
          size: widget.size == BlueprintTabSize.large ? 20 : 16,
          color: tab.disabled
              ? BlueprintColors.textColorDisabled
              : (isSelected
                  ? BlueprintColors.intentPrimary
                  : BlueprintColors.textColorMuted),
        ),
      );
      children.add(const SizedBox(width: 7)); // Blueprint.js uses exactly 7px
    }

    children.add(
      Transform.translate(
        offset: const Offset(0, -1), // Move text up slightly to center with icon
        child: Text(
          tab.title,
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: tab.disabled
                ? BlueprintColors.textColorDisabled
                : (isSelected
                    ? BlueprintColors.textColor
                    : BlueprintColors.textColorMuted),
            height: 1.0, // Tight line height
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );

    if (tab.badge != null) {
      children.add(const SizedBox(width: 7)); // Blueprint.js uses exactly 7px
      children.add(
        SizedBox(
          height: _fontSize, // Match the text height
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2, // Reduced padding to fit in constrained height
              ),
              decoration: BoxDecoration(
                color: BlueprintColors.gray3,
                borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
              ),
              child: Text(
                tab.badge!,
                style: const TextStyle(
                  fontSize: BlueprintTheme.fontSizeSmall,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: _tabHeight,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: BlueprintColors.dividerBlack,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(
                horizontal: BlueprintTheme.gridSize,
                vertical: BlueprintTheme.gridSize * 0.4,
              ),
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: BlueprintColors.intentPrimary,
                  width: 2,
                ),
                insets: EdgeInsets.zero,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: widget.tabs.map((tab) {
                final isSelected = tab.id == _selectedTabId;
                return Container(
                  height: _tabHeight,
                  padding: EdgeInsets.symmetric(
                    horizontal: BlueprintTheme.gridSize,
                  ),
                  alignment: Alignment.center,
                  child: _buildTabContent(tab, isSelected),
                );
              }).toList(),
            ),
          ),
          if (widget.trailing != null) ...[
            const SizedBox(width: BlueprintTheme.gridSize),
            widget.trailing!,
            const SizedBox(width: BlueprintTheme.gridSize),
          ],
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    if (widget.tabs.isEmpty) {
      return const SizedBox.shrink();
    }
    
    if (widget.renderActiveTabPanelOnly) {
      final selectedTab = widget.tabs.where((tab) => tab.id == _selectedTabId).firstOrNull;
      return selectedTab?.content ?? const SizedBox.shrink();
    }

    return SizedBox(
      height: 250, // Fixed height to prevent layout issues
      child: TabBarView(
        controller: _tabController,
        children: widget.tabs.map((tab) => 
          SingleChildScrollView(
            key: ValueKey(tab.id),
            child: tab.content,
          )
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabs.isEmpty) {
      return const SizedBox.shrink();
    }
    
    if (widget.vertical) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: BlueprintColors.dividerBlack,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: widget.tabs.map((tab) {
                final isSelected = tab.id == _selectedTabId;
                return GestureDetector(
                  onTap: tab.disabled
                      ? null
                      : () {
                          final index = _getTabIndex(tab.id);
                          _tabController.animateTo(index);
                        },
                  child: Container(
                    width: double.infinity,
                    height: _tabHeight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: BlueprintTheme.gridSize,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? BlueprintColors.lightGray3
                          : Colors.transparent,
                      border: isSelected
                          ? const Border(
                              left: BorderSide(
                                color: BlueprintColors.intentPrimary,
                                width: 3,
                              ),
                            )
                          : null,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _buildTabContent(tab, isSelected),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _buildTabBarView(),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTabBar(),
        _buildTabBarView(),
      ],
    );
  }
}

// Helper widget for tab expander (pushes subsequent tabs to the right)
class BlueprintTabsExpander extends StatelessWidget {
  const BlueprintTabsExpander({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: SizedBox.shrink());
  }
}

// Convenience class for building tabs
class BlueprintTabsBuilder {
  final List<BlueprintTab> _tabs = [];

  BlueprintTabsBuilder addTab(BlueprintTab tab) {
    _tabs.add(tab);
    return this;
  }

  BlueprintTabsBuilder addSimpleTab({
    required String id,
    required String title,
    required Widget content,
    IconData? icon,
    String? badge,
    bool disabled = false,
  }) {
    return addTab(BlueprintTab(
      id: id,
      title: title,
      content: content,
      icon: icon,
      badge: badge,
      disabled: disabled,
    ));
  }

  List<BlueprintTab> build() => List.unmodifiable(_tabs);
}