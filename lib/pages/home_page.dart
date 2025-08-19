import 'package:flutter/material.dart';
import '../theme/blueprint_theme.dart';
import '../theme/blueprint_colors.dart';
import '../models/demo_item.dart';
import '../data/demo_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? BlueprintTheme.darkTheme : BlueprintTheme.lightTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blueprint Flutter Components'),
          backgroundColor: BlueprintColors.intentPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
              tooltip: _isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            ),
          ],
        ),
        body: Container(
          color: _isDarkMode ? BlueprintColors.darkAppBackgroundColor : BlueprintColors.appBackgroundColor,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildResponsiveLayout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
      decoration: BoxDecoration(
        color: BlueprintColors.intentPrimary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(BlueprintTheme.gridSize),
          bottomRight: Radius.circular(BlueprintTheme.gridSize),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Blueprint Design System',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSizeLarge,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Flutter implementation of Blueprint.js components',
            style: TextStyle(
              fontSize: BlueprintTheme.fontSize,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Define breakpoints
    const mobileBreakpoint = 600;
    const tabletBreakpoint = 1024;
    
    if (screenWidth < mobileBreakpoint) {
      // Mobile: Use ListView
      return ListView.builder(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        itemCount: DemoItems.all.length,
        itemBuilder: (context, index) {
          final item = DemoItems.all[index];
          return _buildDemoCard(context, item, isGrid: false);
        },
      );
    } else {
      // Tablet and Desktop: Use GridView with compact boxes
      final crossAxisCount = screenWidth < tabletBreakpoint ? 2 : 3;
      
      return GridView.builder(
        padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 2.4, // Reduced height by 1/3 (from 1.8 to 2.4)
          crossAxisSpacing: BlueprintTheme.gridSize,
          mainAxisSpacing: BlueprintTheme.gridSize,
        ),
        itemCount: DemoItems.all.length,
        itemBuilder: (context, index) {
          final item = DemoItems.all[index];
          return _buildDemoCard(context, item, isGrid: true);
        },
      );
    }
  }

  Widget _buildDemoCard(BuildContext context, DemoItem item, {required bool isGrid}) {
    final isEnabled = item.page != null;
    
    return Container(
      margin: isGrid ? EdgeInsets.zero : const EdgeInsets.only(bottom: BlueprintTheme.gridSize),
      child: Material(
        color: _isDarkMode ? BlueprintColors.darkAppSecondaryBackgroundColor : BlueprintColors.appSecondaryBackgroundColor,
        borderRadius: BorderRadius.circular(isGrid ? 4 : BlueprintTheme.borderRadius * 2), // Square corners for grid
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(isGrid ? 4 : BlueprintTheme.borderRadius * 2),
          onTap: isEnabled ? () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => item.page!),
            );
          } : null,
          child: Padding(
            padding: isGrid 
                ? const EdgeInsets.all(BlueprintTheme.gridSize * 1.5) // Less compact padding
                : const EdgeInsets.all(BlueprintTheme.gridSize * 2),
            child: isGrid ? _buildGridLayout(item, isEnabled) : _buildListLayout(item, isEnabled),
          ),
        ),
      ),
    );
  }

  Widget _buildListLayout(DemoItem item, bool isEnabled) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isEnabled ? item.color.withValues(alpha: 0.1) : BlueprintColors.lightGray2,
            borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
          ),
          child: Icon(
            item.icon,
            color: isEnabled ? item.color : BlueprintColors.textColorDisabled,
            size: 24,
          ),
        ),
        const SizedBox(width: BlueprintTheme.gridSize * 1.5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSize,
                  fontWeight: FontWeight.w600,
                  color: isEnabled 
                      ? (_isDarkMode ? BlueprintColors.darkTextColor : BlueprintColors.textColor)
                      : BlueprintColors.textColorDisabled,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.subtitle,
                style: TextStyle(
                  fontSize: BlueprintTheme.fontSizeSmall,
                  color: isEnabled
                      ? (_isDarkMode ? BlueprintColors.darkTextColorMuted : BlueprintColors.textColorMuted)
                      : BlueprintColors.textColorDisabled,
                ),
              ),
            ],
          ),
        ),
        Icon(
          isEnabled ? Icons.chevron_right : Icons.lock_outline,
          color: isEnabled 
              ? (_isDarkMode ? BlueprintColors.darkTextColorMuted : BlueprintColors.textColorMuted)
              : BlueprintColors.textColorDisabled,
        ),
      ],
    );
  }

  Widget _buildGridLayout(DemoItem item, bool isEnabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isEnabled ? item.color.withValues(alpha: 0.1) : BlueprintColors.lightGray2,
                borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius),
              ),
              child: Icon(
                item.icon,
                color: isEnabled ? item.color : BlueprintColors.textColorDisabled,
                size: 16,
              ),
            ),
            const Spacer(),
            Icon(
              isEnabled ? Icons.arrow_forward : Icons.lock_outline,
              color: isEnabled 
                  ? (_isDarkMode ? BlueprintColors.darkTextColorMuted : BlueprintColors.textColorMuted)
                  : BlueprintColors.textColorDisabled,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: BlueprintTheme.gridSize * 0.75),
        Text(
          item.title,
          style: TextStyle(
            fontSize: BlueprintTheme.fontSize,
            fontWeight: FontWeight.w600,
            color: isEnabled 
                ? (_isDarkMode ? BlueprintColors.darkTextColor : BlueprintColors.textColor)
                : BlueprintColors.textColorDisabled,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          item.subtitle,
          style: TextStyle(
            fontSize: BlueprintTheme.fontSizeSmall,
            color: isEnabled
                ? (_isDarkMode ? BlueprintColors.darkTextColorMuted : BlueprintColors.textColorMuted)
                : BlueprintColors.textColorDisabled,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}