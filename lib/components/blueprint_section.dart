import 'blueprint_common.dart';

class BlueprintSection extends StatefulWidget {
  final String? title;
  final Widget? titleElement;
  final List<Widget> children;
  final bool collapsible;
  final bool initiallyCollapsed;
  final BlueprintElevation elevation;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  final List<Widget>? rightElement;
  final bool compact;

  const BlueprintSection({
    super.key,
    this.title,
    this.titleElement,
    required this.children,
    this.collapsible = false,
    this.initiallyCollapsed = false,
    this.elevation = BlueprintElevation.zero,
    this.padding,
    this.icon,
    this.rightElement,
    this.compact = false,
  });

  @override
  State<BlueprintSection> createState() => _BlueprintSectionState();
}

class _BlueprintSectionState extends State<BlueprintSection> 
    with SingleTickerProviderStateMixin {
  bool _isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _isCollapsed = widget.initiallyCollapsed;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    if (!_isCollapsed) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
    
    if (_isCollapsed) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? BlueprintColors.dark3 : BlueprintColors.light5,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
        border: Border.all(
          color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
          width: 1,
        ),
        boxShadow: _getElevationShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null || widget.titleElement != null) 
            _buildHeader(isDark),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: widget.collapsible ? _animation.value : 1.0,
                  child: child,
                ),
              );
            },
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    final headerPadding = widget.compact 
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
        : const EdgeInsets.all(16);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.collapsible ? _toggleCollapse : null,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(BlueprintTheme.borderRadius),
          topRight: Radius.circular(BlueprintTheme.borderRadius),
        ),
        child: Container(
          width: double.infinity,
          padding: headerPadding,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              if (widget.collapsible) ...[
                Icon(
                  _isCollapsed ? Icons.chevron_right : Icons.expand_more,
                  size: 20,
                  color: isDark ? BlueprintColors.gray1 : BlueprintColors.gray2,
                ),
                const SizedBox(width: 8),
              ],
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 18,
                  color: isDark ? BlueprintColors.light1 : BlueprintColors.dark1,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: widget.titleElement ?? Text(
                  widget.title!,
                  style: TextStyle(
                    fontSize: BlueprintTheme.fontSize,
                    fontWeight: FontWeight.w600,
                    color: isDark ? BlueprintColors.light1 : BlueprintColors.dark1,
                  ),
                ),
              ),
              if (widget.rightElement != null) ...[
                const SizedBox(width: 8),
                ...widget.rightElement!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final contentPadding = widget.compact 
        ? const EdgeInsets.all(12)
        : const EdgeInsets.all(16);

    return Padding(
      padding: contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.children,
      ),
    );
  }

  List<BoxShadow> _getElevationShadow() {
    return widget.elevation.shadows;
  }
}

class BlueprintSectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool compact;

  const BlueprintSectionCard({
    super.key,
    required this.child,
    this.padding,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardPadding = padding ?? (compact 
        ? const EdgeInsets.all(12)
        : const EdgeInsets.all(16));

    return Container(
      width: double.infinity,
      padding: cardPadding,
      decoration: BoxDecoration(
        color: isDark ? BlueprintColors.dark2 : BlueprintColors.light4,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
        border: Border.all(
          color: isDark ? BlueprintColors.dark1 : BlueprintColors.gray5,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

class BlueprintSections {
  static BlueprintSection simple({
    required String title,
    required List<Widget> children,
    IconData? icon,
  }) {
    return BlueprintSection(
      title: title,
      children: children,
      icon: icon,
    );
  }

  static BlueprintSection collapsible({
    required String title,
    required List<Widget> children,
    bool initiallyCollapsed = false,
    IconData? icon,
  }) {
    return BlueprintSection(
      title: title,
      children: children,
      collapsible: true,
      initiallyCollapsed: initiallyCollapsed,
      icon: icon,
    );
  }

  static BlueprintSection elevated({
    required String title,
    required List<Widget> children,
    BlueprintElevation elevation = BlueprintElevation.two,
    IconData? icon,
  }) {
    return BlueprintSection(
      title: title,
      children: children,
      elevation: elevation,
      icon: icon,
    );
  }

  static BlueprintSection compact({
    required String title,
    required List<Widget> children,
    IconData? icon,
  }) {
    return BlueprintSection(
      title: title,
      children: children,
      compact: true,
      icon: icon,
    );
  }

  static BlueprintSection withCards({
    required String title,
    required List<BlueprintSectionCard> cards,
    IconData? icon,
  }) {
    return BlueprintSection(
      title: title,
      icon: icon,
      children: cards
          .map((card) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: card,
              ))
          .toList(),
    );
  }
}