import 'package:flutter/material.dart';
import 'theme/blueprint_theme.dart';
import 'theme/blueprint_colors.dart';
import 'pages/button_demo_page.dart';
import 'pages/alert_demo_page.dart';
import 'pages/colors_demo_page.dart';
import 'pages/card_demo_page.dart';
import 'pages/tabs_demo_page.dart';
import 'pages/spinner_demo_page.dart';
import 'pages/progress_bar_demo_page.dart';
import 'pages/tooltip_demo_page.dart';
import 'pages/callout_demo_page.dart';
import 'pages/breadcrumbs_demo_page.dart';
import 'pages/menu_demo_page.dart';
import 'pages/navbar_demo_page.dart';

void main() {
  runApp(const BlueprintDemoApp());
}

class BlueprintDemoApp extends StatelessWidget {
  const BlueprintDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blueprint Flutter Demo',
      theme: BlueprintTheme.lightTheme,
      darkTheme: BlueprintTheme.darkTheme,
      home: const DemoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({Key? key}) : super(key: key);

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  bool _isDarkMode = false;

  final List<DemoItem> _demoItems = [
    DemoItem(
      title: 'Buttons',
      subtitle: 'Various button styles, sizes, and intents',
      icon: Icons.smart_button,
      color: BlueprintColors.intentPrimary,
      page: const ButtonDemoPage(),
    ),
    DemoItem(
      title: 'Alerts',
      subtitle: 'Dialog boxes and confirmation alerts',
      icon: Icons.warning_amber_outlined,
      color: BlueprintColors.intentWarning,
      page: const AlertDemoPage(),
    ),
    DemoItem(
      title: 'Colors',
      subtitle: 'Blueprint color palette and design tokens',
      icon: Icons.palette_outlined,
      color: BlueprintColors.intentSuccess,
      page: const ColorsDemoPage(),
    ),
    DemoItem(
      title: 'Cards',
      subtitle: 'Card components and layouts',
      icon: Icons.credit_card,
      color: BlueprintColors.blue3,
      page: const CardDemoPage(),
    ),
    DemoItem(
      title: 'Forms',
      subtitle: 'Input fields and form controls (Coming Soon)',
      icon: Icons.input,
      color: BlueprintColors.gray3,
      page: null,
    ),
    DemoItem(
      title: 'Tabs',
      subtitle: 'Horizontal and vertical tab navigation',
      icon: Icons.tab,
      color: BlueprintColors.orange3,
      page: const TabsDemoPage(),
    ),
    DemoItem(
      title: 'Spinners',
      subtitle: 'Loading indicators and progress spinners',
      icon: Icons.refresh,
      color: BlueprintColors.blue4,
      page: const SpinnerDemoPage(),
    ),
    DemoItem(
      title: 'Progress Bars',
      subtitle: 'Linear progress indicators with animations',
      icon: Icons.linear_scale,
      color: BlueprintColors.green3,
      page: const ProgressBarDemoPage(),
    ),
    DemoItem(
      title: 'Tooltips',
      subtitle: 'Contextual hover information and help text',
      icon: Icons.help_outline,
      color: BlueprintColors.orange4,
      page: const TooltipDemoPage(),
    ),
    DemoItem(
      title: 'Callouts',
      subtitle: 'Highlighted content blocks with intent colors',
      icon: Icons.campaign,
      color: BlueprintColors.red4,
      page: const CalloutDemoPage(),
    ),
    DemoItem(
      title: 'Breadcrumbs',
      subtitle: 'Navigation breadcrumb trails',
      icon: Icons.navigation,
      color: BlueprintColors.blue4,
      page: const BreadcrumbsDemoPage(),
    ),
    DemoItem(
      title: 'Menu',
      subtitle: 'Interactive menu components',
      icon: Icons.menu,
      color: BlueprintColors.green4,
      page: const MenuDemoPage(),
    ),
    DemoItem(
      title: 'Navbar',
      subtitle: 'Navigation bars and headers',
      icon: Icons.web_asset,
      color: BlueprintColors.orange4,
      page: const NavbarDemoPage(),
    ),
  ];

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
              Container(
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
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
                  itemCount: _demoItems.length,
                  itemBuilder: (context, index) {
                    final item = _demoItems[index];
                    return _buildDemoCard(context, item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoCard(BuildContext context, DemoItem item) {
    final isEnabled = item.page != null;
    
    return Container(
      margin: const EdgeInsets.only(bottom: BlueprintTheme.gridSize),
      child: Material(
        color: _isDarkMode ? BlueprintColors.darkAppSecondaryBackgroundColor : BlueprintColors.appSecondaryBackgroundColor,
        borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius * 2),
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(BlueprintTheme.borderRadius * 2),
          onTap: isEnabled ? () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => item.page!),
            );
          } : null,
          child: Padding(
            padding: const EdgeInsets.all(BlueprintTheme.gridSize * 2),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isEnabled ? item.color.withOpacity(0.1) : BlueprintColors.lightGray2,
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
            ),
          ),
        ),
      ),
    );
  }
}

class DemoItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget? page;

  DemoItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.page,
  });
}
