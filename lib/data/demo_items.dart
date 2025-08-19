import 'package:flutter/material.dart';
import '../theme/blueprint_colors.dart';
import '../models/demo_item.dart';
import '../pages/alert_demo_page.dart';
import '../pages/breadcrumbs_demo_page.dart';
import '../pages/button_demo_page.dart';
import '../pages/callout_demo_page.dart';
import '../pages/card_demo_page.dart';
import '../pages/collapse_demo_page.dart';
import '../pages/colors_demo_page.dart';
import '../pages/dialog_demo_page.dart';
import '../pages/drawer_demo_page.dart';
import '../pages/forms_demo_page.dart';
import '../pages/icon_demo_page.dart';
import '../pages/layout_demo_page.dart';
import '../pages/menu_demo_page.dart';
import '../pages/navbar_demo_page.dart';
import '../pages/components_demo_page.dart';
import '../pages/popover_demo_page.dart';
import '../pages/progress_bar_demo_page.dart';
import '../pages/spinner_demo_page.dart';
import '../pages/table_demo_page.dart';
import '../pages/tabs_demo_page.dart';
import '../pages/tag_demo_page.dart';
import '../pages/toast_demo_page.dart';
import '../pages/tooltip_demo_page.dart';
import '../pages/tree_demo_page.dart';

/// Contains all demo items for the Blueprint component showcase
class DemoItems {
  static final List<DemoItem> all = [
    DemoItem(
      title: 'Alerts',
      subtitle: 'Dialog boxes and confirmation alerts',
      icon: Icons.warning_amber_outlined,
      color: BlueprintColors.intentWarning,
      page: const AlertDemoPage(),
    ),
    DemoItem(
      title: 'Breadcrumbs',
      subtitle: 'Navigation breadcrumb trails',
      icon: Icons.navigation,
      color: BlueprintColors.blue4,
      page: const BreadcrumbsDemoPage(),
    ),
    DemoItem(
      title: 'Buttons',
      subtitle: 'Various button styles, sizes, and intents',
      icon: Icons.smart_button,
      color: BlueprintColors.intentPrimary,
      page: const ButtonDemoPage(),
    ),
    DemoItem(
      title: 'Callouts',
      subtitle: 'Highlighted content blocks with intent colors',
      icon: Icons.campaign,
      color: BlueprintColors.red4,
      page: const CalloutDemoPage(),
    ),
    DemoItem(
      title: 'Cards',
      subtitle: 'Card components and layouts',
      icon: Icons.credit_card,
      color: BlueprintColors.blue3,
      page: const CardDemoPage(),
    ),
    DemoItem(
      title: 'Collapse',
      subtitle: 'Expandable content areas with smooth animations and nesting',
      icon: Icons.expand_more,
      color: BlueprintColors.indigo3,
      page: const CollapseDemoPage(),
    ),
    DemoItem(
      title: 'Colors',
      subtitle: 'Blueprint color palette and design tokens',
      icon: Icons.palette_outlined,
      color: BlueprintColors.intentSuccess,
      page: const ColorsDemoPage(),
    ),
    DemoItem(
      title: 'Dialogs',
      subtitle: 'Modal dialogs, alerts, confirmations, and overlays',
      icon: Icons.chat_bubble_outline,
      color: BlueprintColors.blue4,
      page: const DialogDemoPage(),
    ),
    DemoItem(
      title: 'Drawers',
      subtitle: 'Slide-out navigation and content panels',
      icon: Icons.menu_open,
      color: BlueprintColors.indigo3,
      page: const DrawerDemoPage(),
    ),
    DemoItem(
      title: 'Forms',
      subtitle: 'Input fields, checkboxes, radio buttons, and selects',
      icon: Icons.input,
      color: BlueprintColors.purple3,
      page: const FormsDemoPage(),
    ),
    DemoItem(
      title: 'Icons',
      subtitle: 'Consistent iconography with sizes, intents, and semantic meanings',
      icon: Icons.star_outline,
      color: BlueprintColors.blue3,
      page: const IconDemoPage(),
    ),
    DemoItem(
      title: 'Layout',
      subtitle: 'Dividers and sections for organizing content',
      icon: Icons.view_quilt,
      color: BlueprintColors.indigo3,
      page: const LayoutDemoPage(),
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
    DemoItem(
      title: 'New Components',
      subtitle: 'Icons, tags, collapse panels, and combined examples',
      icon: Icons.auto_awesome,
      color: BlueprintColors.purple3,
      page: const ComponentsDemoPage(),
    ),
    DemoItem(
      title: 'Popovers',
      subtitle: 'Interactive overlays with rich content and positioning',
      icon: Icons.chat_bubble_outline,
      color: BlueprintColors.purple3,
      page: const PopoverDemoPage(),
    ),
    DemoItem(
      title: 'Progress Bars',
      subtitle: 'Linear progress indicators with animations',
      icon: Icons.linear_scale,
      color: BlueprintColors.green3,
      page: const ProgressBarDemoPage(),
    ),
    DemoItem(
      title: 'Spinners',
      subtitle: 'Loading indicators and progress spinners',
      icon: Icons.refresh,
      color: BlueprintColors.blue4,
      page: const SpinnerDemoPage(),
    ),
    DemoItem(
      title: 'Tables',
      subtitle: 'Data tables with sorting, selection, and custom cells',
      icon: Icons.table_chart,
      color: BlueprintColors.indigo3,
      page: const TableDemoPage(),
    ),
    DemoItem(
      title: 'Tabs',
      subtitle: 'Horizontal and vertical tab navigation',
      icon: Icons.tab,
      color: BlueprintColors.orange3,
      page: const TabsDemoPage(),
    ),
    DemoItem(
      title: 'Tags',
      subtitle: 'Labels and removable tags with intents and sizes',
      icon: Icons.label_outline,
      color: BlueprintColors.green4,
      page: const TagDemoPage(),
    ),
    DemoItem(
      title: 'Toast',
      subtitle: 'Notification system with automatic dismissal and positioning',
      icon: Icons.notifications,
      color: BlueprintColors.orange4,
      page: const ToastDemoPage(),
    ),
    DemoItem(
      title: 'Tooltips',
      subtitle: 'Contextual hover information and help text',
      icon: Icons.help_outline,
      color: BlueprintColors.orange4,
      page: const TooltipDemoPage(),
    ),
    DemoItem(
      title: 'Tree',
      subtitle: 'Hierarchical data display with expand/collapse functionality',
      icon: Icons.account_tree,
      color: BlueprintColors.green4,
      page: const TreeDemoPage(),
    ),
  ];
}