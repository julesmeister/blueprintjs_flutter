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
    
    if (widget.selectedTabId != null && widget.selectedTabId != _selectedTabId) {
      _selectedTabId = widget.selectedTabId!;
      final newIndex = _getTabIndex(_selectedTabId);
      if (newIndex != _tabController.index) {
        _tabController.animateTo(newIndex);
      }
    }
    
    if (widget.tabs.length != oldWidget.tabs.length) {
      _tabController.dispose();
      _tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: _getTabIndex(_selectedTabId),
      );
      _tabController.addListener(_handleTabControllerChange);
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
    if (!_tabController.indexIsChanging && _tabController.index >= 0 && _tabController.index < widget.tabs.length) {
      final newTabId = widget.tabs[_tabController.index].id;
      if (newTabId != _selectedTabId) {
        setState(() {
          _selectedTabId = newTabId;
        });
        widget.onTabChanged?.call(newTabId);
      }
    }
  }

  double get _tabHeight {
    switch (widget.size) {
      case BlueprintTabSize.medium:
        return BlueprintTheme.buttonHeight;
      case BlueprintTabSize.large:
        return BlueprintTheme.buttonHeightLarge;
    }
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
      children.add(const SizedBox(width: BlueprintTheme.gridSize * 0.6));
    }

    children.add(
      Text(
        tab.title,
        style: TextStyle(
          fontSize: _fontSize,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: tab.disabled
              ? BlueprintColors.textColorDisabled
              : (isSelected
                  ? BlueprintColors.textColor
                  : BlueprintColors.textColorMuted),
        ),
      ),
    );

    if (tab.badge != null) {
      children.add(const SizedBox(width: BlueprintTheme.gridSize * 0.6));
      children.add(
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: BlueprintTheme.gridSize * 0.6,
            vertical: BlueprintTheme.gridSize * 0.2,
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
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
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
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return BlueprintColors.lightGray2;
                  }
                  if (states.contains(MaterialState.pressed)) {
                    return BlueprintColors.lightGray1;
                  }
                  return null;
                },
              ),
              tabs: widget.tabs.map((tab) {
                final isSelected = tab.id == _selectedTabId;
                return Container(
                  height: _tabHeight,
                  padding: EdgeInsets.symmetric(
                    horizontal: BlueprintTheme.gridSize,
                    vertical: BlueprintTheme.gridSize * 0.6,
                  ),
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
    if (widget.renderActiveTabPanelOnly) {
      final selectedTab = widget.tabs.firstWhere((tab) => tab.id == _selectedTabId);
      return selectedTab.content;
    }

    return TabBarView(
      controller: _tabController,
      children: widget.tabs.map((tab) => tab.content).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
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
                        vertical: BlueprintTheme.gridSize * 0.6,
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
      children: [
        _buildTabBar(),
        if (widget.fill)
          Expanded(child: _buildTabBarView())
        else
          Flexible(child: _buildTabBarView()),
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