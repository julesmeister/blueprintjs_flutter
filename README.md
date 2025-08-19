# Blueprint Flutter Components

A comprehensive Flutter implementation of the [Blueprint.js](https://blueprintjs.com/) design system. This open source library recreates Blueprint's core components and design language for Flutter applications.

> **Inspired by Blueprint.js** - This is an independent Flutter implementation created by the community, not officially affiliated with Blueprint.js or Palantir Technologies.

## 🚀 Features

### ✅ Completed Components

- **🎨 Theme System** - Complete Blueprint color palette, typography, and design tokens
- **🔘 Buttons** - All variants (filled, outlined, minimal), sizes, intents, loading states, and pixel-perfect Blueprint.js styling
- **⚠️ Alerts** - Dialog-based alerts with all intent types and customizable actions
- **📋 Cards** - Interactive cards with elevation, hover effects, card lists, and centered circle avatars
- **📑 Tabs** - Horizontal and vertical tabs with controlled/uncontrolled modes
- **⏳ Spinners** - Loading indicators with determinate/indeterminate progress
- **📊 Progress Bars** - Linear progress indicators with animations and stripes
- **💬 Tooltips** - Contextual hover information with positioning options
- **📢 Callouts** - Highlighted content blocks with intent colors and rich content
- **🧭 Breadcrumbs** - Navigation breadcrumb trails showing hierarchical paths
- **📋 Menu** - Interactive menu components with items, dividers, and intents
- **🎯 Navbar** - Navigation bars and headers with groups and alignments
- **📝 Forms** - Input fields, checkboxes, radio buttons, and select dropdowns
- **📐 Layout** - Dividers and sections for organizing and structuring content
- **💬 Dialogs** - Modal dialogs, alerts, confirmations, and custom overlays
- **🏷️ Tags** - Labels, removable tags, intent colors, interactive variants, and **perfect text centering** (matching Blueprint.js compound tag rendering)
- **🎨 Icons** - Consistent iconography with sizes, intents, and semantic meanings
- **📂 Collapse** - Expandable content areas with Blueprint.js-style button triggers and smooth animations
- **💬 Popovers** - Rich contextual overlays with positioning and interactive content
- **📊 Tables** - Complex data display with sorting, selection, Blueprint styling, **perfectly aligned headers and data cells**, and **perfect text centering**
- **🌳 Trees** - Hierarchical data display with expand/collapse and selection
- **🔔 Toasts** - Global notification system with positioning and animations
- **🗂️ Drawers** - Slide-out navigation and content panels with multiple positions

### 🎯 Key Features

- **Faithful Design Recreation** - Matches Blueprint.js visual design and interactions
- **Flutter Best Practices** - Proper state management, animations, and widget composition
- **Comprehensive Demos** - Interactive examples for each component
- **Dark/Light Theme Support** - Built-in theme switching
- **Intent-based Colors** - Primary, Success, Warning, Danger color schemes
- **Accessibility** - Semantic labels and proper focus management
- **Factory Methods** - Convenient component creation patterns

## 🎯 Recent Major Improvements

### ✨ Perfect Tag Text Centering (Fixed!)
After extensive investigation, **simple tags now have perfect vertical text centering** that matches Blueprint.js compound tags exactly:

- **Root Cause Identified**: Simple tags used different widget structure than compound tags
- **Critical Fixes Applied**:
  1. **Nested Container Structure**: Added outer container wrapper to match compound tags
  2. **DefaultTextStyle Usage**: Switched from direct Text styling to DefaultTextStyle (key difference!)
  3. **Exact Line Height**: Using `height: 1.0` exactly like compound tags (not 1.2)
  4. **Natural Row Alignment**: Removed explicit `crossAxisAlignment.center` to let Row handle it naturally
  5. **Consistent Rendering**: Both simple and compound tags now use identical Flutter widget patterns

- **Result**: ✅ Upper and lower halves of tags demo page now look identical with perfect text centering!

### 📊 Perfect Table Alignment (Fixed!)
Fixed table header-to-data alignment issues for pixel-perfect column alignment:

- **Root Cause**: Headers and data cells used different alignment strategies
- **Critical Fixes Applied**:
  1. **Consistent Header Alignment**: Headers now respect column alignment instead of forcing center
  2. **Data Cell Alignment**: Removed Center() wrappers that overrode column alignment
  3. **Custom Cell Handling**: Status tags use Align() to stay compact while respecting alignment
  4. **Helper Methods**: Added MainAxisAlignment mapping for proper header alignment

- **Result**: ✅ All table columns now have perfect header-to-data alignment (left, center, right)

### 🎯 Perfect Table Text Centering (Fixed!)
Extended the tag centering breakthrough to **table text rendering** for perfect vertical centering:

- **Root Cause**: Table text used direct Text styling instead of the DefaultTextStyle pattern that made tags perfect
- **Critical Fixes Applied**:
  1. **DefaultTextStyle Pattern**: Applied same widget structure that solved tag centering
  2. **height: 1.0 Line Height**: Consistent with tags (changed from 1.2)
  3. **Unified Text Rendering**: Both headers and data cells now use identical centering approach
  4. **Complete Coverage**: Applied to sortable headers, non-sortable headers, and data cells

- **Result**: ✅ All table text now has the same perfect vertical centering as tags!

### 🗂️ Clean File Structure (Refactored!)
Split the massive 487-line `main.dart` into focused, maintainable files:

- **Before**: 1 monolithic file (487 lines)
- **After**: 5 focused files with clear responsibilities
  - `main.dart` (6 lines) - Entry point only
  - `app.dart` (19 lines) - App configuration  
  - `models/demo_item.dart` (17 lines) - Data model
  - `data/demo_items.dart` (145 lines) - Demo data
  - `pages/home_page.dart` (243 lines) - Home UI

- **Benefits**: ✅ Single responsibility principle, easier maintenance, better scalability

## 📁 Project Structure

```
blueprint_flutter_demo/
├── 📄 README.md                            # Project documentation (this file)
├── 📄 pubspec.yaml                         # Flutter dependencies and configuration
├── 📄 analysis_options.yaml                # Dart analysis configuration
├── 🔧 run-windows.bat                      # Windows launcher script
├── 🔧 run-android.bat                      # Android launcher script (legacy)
│
├── 📂 lib/                                 # Main application source code
│   ├── 📄 main.dart                        # Clean app entry point (6 lines)
│   ├── 📄 app.dart                         # App configuration and theming (19 lines)
│   │
│   ├── 📂 data/                            # Application data
│   │   └── 📄 demo_items.dart              # Demo item definitions (145 lines)  
│   │
│   ├── 📂 models/                          # Data models
│   │   └── 📄 demo_item.dart               # Demo item model class (17 lines)
│   │
│   ├── 📂 components/                      # Blueprint component library
│   │   ├── 📄 blueprint_alert.dart         # Alert dialogs and confirmations
│   │   ├── 📄 blueprint_breadcrumbs.dart   # Navigation breadcrumb trails
│   │   ├── 📄 blueprint_button.dart        # Button variants and states
│   │   ├── 📄 blueprint_callout.dart       # Callout notification blocks
│   │   ├── 📄 blueprint_card.dart          # Card containers and layouts
│   │   ├── 📄 blueprint_checkbox.dart      # Checkbox form controls
│   │   ├── 📄 blueprint_divider.dart       # Visual content separators
│   │   ├── 📄 blueprint_input.dart         # Text input and input groups
│   │   ├── 📄 blueprint_menu.dart          # Interactive menu components
│   │   ├── 📄 blueprint_navbar.dart        # Navigation bars and headers
│   │   ├── 📄 blueprint_progress_bar.dart  # Linear progress indicators
│   │   ├── 📄 blueprint_radio.dart         # Radio button form controls
│   │   ├── 📄 blueprint_section.dart       # Content organization sections
│   │   ├── 📄 blueprint_select.dart        # Dropdown select components
│   │   ├── 📄 blueprint_spinner.dart       # Loading spinners and progress
│   │   ├── 📄 blueprint_tabs.dart          # Tab navigation components
│   │   └── 📄 blueprint_tooltip.dart       # Hover tooltip overlays
│   │
│   ├── 📂 pages/                           # Demo and example pages
│   │   ├── 📄 home_page.dart               # Main home page UI (243 lines)
│   │   ├── 📄 alert_demo_page.dart         # Alert component examples
│   │   ├── 📄 breadcrumbs_demo_page.dart   # Breadcrumb navigation examples
│   │   ├── 📄 button_demo_page.dart        # Button component examples
│   │   ├── 📄 callout_demo_page.dart       # Callout component examples
│   │   ├── 📄 card_demo_page.dart          # Card component examples
│   │   ├── 📄 colors_demo_page.dart        # Color palette showcase
│   │   ├── 📄 forms_demo_page.dart         # Forms component examples
│   │   ├── 📄 layout_demo_page.dart        # Layout component examples
│   │   ├── 📄 menu_demo_page.dart          # Menu component examples
│   │   ├── 📄 navbar_demo_page.dart        # Navbar component examples
│   │   ├── 📄 progress_bar_demo_page.dart  # Progress bar examples
│   │   ├── 📄 spinner_demo_page.dart       # Spinner component examples
│   │   ├── 📄 tabs_demo_page.dart          # Tab component examples
│   │   └── 📄 tooltip_demo_page.dart       # Tooltip component examples
│   │
│   └── 📂 theme/                           # Design system and theming
│       ├── 📄 blueprint_colors.dart        # Complete Blueprint color palette
│       └── 📄 blueprint_theme.dart         # Theme configuration and tokens
│
├── 📂 test/                                # Test files
│   └── 📄 widget_test.dart                 # Widget tests (default)
│
├── 📂 android/                             # Android platform configuration
│   ├── 📂 app/
│   ├── 📂 gradle/
│   └── 🔧 gradlew.bat                      # Gradle wrapper (Windows)
│
├── 📂 ios/                                 # iOS platform configuration
│   ├── 📂 Runner/
│   └── 📂 Runner.xcworkspace/
│
├── 📂 windows/                             # Windows platform configuration
│   ├── 📂 runner/
│   └── 📂 CMakeFiles/
│
├── 📂 build/                               # Build output directory
│   ├── 📂 windows/
│   └── 📂 [platform-specific builds]
│
└── 📂 .dart_tool/                          # Dart tooling cache
    └── 📂 [generated files and cache]
```

## 📊 Project Statistics

### Source Code Distribution

| Directory | Dart Files | Purpose |
|-----------|------------|---------|
| `lib/components/` | 30+ files | Core Blueprint component implementations |
| `lib/pages/` | 20+ files | Interactive demo pages and examples |
| `lib/theme/` | 2 files | Design system and color palette |
| `lib/` (root) | 1 file | Main application entry point |
| **Total** | **50+ files** | **Complete Flutter application** |

### Component Files Details

#### Core Components (`lib/components/`)
1. **blueprint_alert.dart** - Dialog-based alerts with customizable actions
2. **blueprint_breadcrumbs.dart** - Navigation breadcrumb trails
3. **blueprint_button.dart** - Complete button system with all variants
4. **blueprint_callout.dart** - Highlighted information blocks
5. **blueprint_card.dart** - Container components with interactions
6. **blueprint_checkbox.dart** - Checkbox form controls with intents
7. **blueprint_divider.dart** - Visual content separators
8. **blueprint_input.dart** - Text input fields and input groups
9. **blueprint_menu.dart** - Interactive menu components with dividers
10. **blueprint_navbar.dart** - Navigation bars and headers
11. **blueprint_progress_bar.dart** - Linear progress with animations
12. **blueprint_radio.dart** - Radio button form controls
13. **blueprint_section.dart** - Content organization sections
14. **blueprint_select.dart** - Dropdown select components
15. **blueprint_spinner.dart** - Circular loading indicators
16. **blueprint_tabs.dart** - Tab navigation system
17. **blueprint_tooltip.dart** - Contextual hover information
18. **blueprint_dialog.dart** - Modal dialogs and overlays
19. **blueprint_tag.dart** - Labels and removable tags
20. **blueprint_icon.dart** - Consistent iconography system
21. **blueprint_collapse.dart** - Expandable content areas with Blueprint.js-faithful button triggers
22. **blueprint_popover.dart** - Rich contextual overlays with positioning
23. **blueprint_table.dart** - Complex data display with sorting and selection
24. **blueprint_tree.dart** - Hierarchical data display with interactions
25. **blueprint_toast.dart** - Global notification system with animations
26. **blueprint_drawer.dart** - Slide-out navigation and content panels

#### Demo Pages (`lib/pages/`)
1. **alert_demo_page.dart** - Alert dialog examples and interactions
2. **breadcrumbs_demo_page.dart** - Breadcrumb navigation examples
3. **button_demo_page.dart** - Button variants, sizes, and states
4. **callout_demo_page.dart** - Callout styles and use cases
5. **card_demo_page.dart** - Card layouts and interactions
6. **colors_demo_page.dart** - Complete color palette showcase
7. **forms_demo_page.dart** - Comprehensive forms with all input types
8. **layout_demo_page.dart** - Layout examples with dividers and sections
9. **menu_demo_page.dart** - Menu component examples and interactions
10. **navbar_demo_page.dart** - Navbar component examples
11. **progress_bar_demo_page.dart** - Progress indicator examples
12. **spinner_demo_page.dart** - Loading spinner variations
13. **tabs_demo_page.dart** - Tab navigation examples
14. **tooltip_demo_page.dart** - Tooltip positioning and styles
15. **dialog_demo_page.dart** - Modal dialog examples and interactions
16. **tag_demo_page.dart** - Tag component examples and variants
17. **components_demo_page.dart** - Showcase of newest components combined
18. **popover_demo_page.dart** - Popover positioning and interactive content
19. **table_demo_page.dart** - Complex data tables with sorting and selection
20. **tree_demo_page.dart** - Hierarchical tree data display
21. **toast_demo_page.dart** - Global toast notification examples
22. **icon_demo_page.dart** - Icon showcase with sizes and intents
23. **collapse_demo_page.dart** - Expandable content with nested examples
24. **drawer_demo_page.dart** - Slide-out drawer navigation examples

#### Theme System (`lib/theme/`)
1. **blueprint_colors.dart** - Complete Blueprint.js color palette
2. **blueprint_theme.dart** - Flutter theme configuration

## 🎨 Component Gallery

### Buttons
- **Variants**: Filled, Outlined, Minimal
- **Sizes**: Small, Medium, Large
- **Intents**: Primary, Success, Warning, Danger
- **States**: Loading, Disabled, Active
- **Features**: Icons, text, factory methods, proper content-sizing (buttons wrap to content width, not full width)

### Cards
- **Types**: Basic, Interactive, Elevated
- **Features**: Hover effects, click handling, custom padding
- **Layouts**: Individual cards, card lists, grid layouts

### Tabs
- **Orientations**: Horizontal, Vertical
- **Modes**: Controlled, Uncontrolled  
- **Features**: Icons, badges, disabled states, large size variant
- **Pixel-Perfect Alignment**: Icon-text vertical alignment matches Blueprint.js exactly

### Progress & Loading
- **Spinners**: Small, standard, large, inline, with progress
- **Progress Bars**: Determinate, indeterminate, with animations and stripes
- **Intent Colors**: All Blueprint intent colors supported

### Interactive Elements
- **Tooltips**: Multi-position, intent colors, compact/minimal variants
- **Callouts**: Rich content, dismissible, intent-based styling

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Platform development environment (Windows/macOS/Linux/Android/iOS)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/blueprintjs_flutter
   cd blueprintjs_flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the demo application**
   ```bash
   flutter run
   ```
   
   For Windows specifically:
   ```bash
   flutter run -d windows
   # or use: run-windows.bat
   ```

### Using in Your Project

Add this to your project's `pubspec.yaml`:

```yaml
dependencies:
  blueprintjs_flutter:
    git:
      url: https://github.com/yourusername/blueprintjs_flutter
      ref: main
```

Then import and use:

```dart
import 'package:blueprintjs_flutter/blueprintjs_flutter.dart';

// Use components in your app
BlueprintButton(
  text: 'Hello Blueprint!',
  intent: BlueprintIntent.primary,
  onPressed: () => print('Clicked!'),
)
```

## 🎯 Usage Examples

### Button Usage
```dart
// Basic button
BlueprintButton(
  text: 'Click me',
  onPressed: () => print('Clicked!'),
)

// Intent button with icon
BlueprintButton(
  text: 'Save',
  icon: Icons.save,
  intent: BlueprintIntent.primary,
  onPressed: () => handleSave(),
)

// Loading button
BlueprintButton(
  text: 'Processing...',
  loading: true,
  intent: BlueprintIntent.success,
  onPressed: null,
)
```

### Card Usage
```dart
// Interactive card
BlueprintCard(
  interactive: true,
  elevation: BlueprintElevation.two,
  onTap: () => navigateToDetail(),
  child: Column(
    children: [
      Text('Card Title'),
      Text('Card content...'),
    ],
  ),
)
```

### Tabs Usage
```dart
// Horizontal tabs
BlueprintTabs(
  tabs: [
    BlueprintTab(
      id: 'tab1',
      title: 'First Tab',
      icon: Icons.home,
      content: Text('Tab 1 Content'),
    ),
    BlueprintTab(
      id: 'tab2', 
      title: 'Second Tab',
      content: Text('Tab 2 Content'),
    ),
  ],
)
```

### Progress Bar Usage
```dart
// Determinate progress
BlueprintProgressBar(
  value: 0.75,
  intent: BlueprintIntent.primary,
  animate: true,
  stripes: true,
)

// Indeterminate progress
BlueprintProgressBars.indeterminate(
  intent: BlueprintIntent.success,
)
```

### Spinner Usage
```dart
// Standard spinner
BlueprintSpinners.standard(
  intent: BlueprintIntent.primary,
)

// Progress spinner
BlueprintSpinners.progress(
  value: 0.65,
  size: 60,
  intent: BlueprintIntent.success,
)
```

### Tooltip Usage
```dart
// Simple tooltip
BlueprintTooltips.simple(
  content: 'Helpful information',
  position: BlueprintTooltipPosition.top,
  child: IconButton(
    icon: Icon(Icons.info),
    onPressed: () {},
  ),
)
```

### Callout Usage
```dart
// Intent callout
BlueprintCallouts.warning(
  title: 'Important Notice',
  content: 'Please review the following information carefully.',
  onDismiss: () => dismissCallout(),
)
```

### Breadcrumbs Usage
```dart
// Interactive breadcrumbs
BlueprintBreadcrumbsFactory.simple(
  items: [
    BlueprintBreadcrumbItem(
      text: 'Home',
      icon: Icons.home,
      onTap: () => navigateToHome(),
    ),
    BlueprintBreadcrumbItem(
      text: 'Projects',
      onTap: () => navigateToProjects(),
    ),
    BlueprintBreadcrumbItem(
      text: 'Current Project',
      isCurrent: true,
    ),
  ],
)
```

### Menu Usage
```dart
// Basic menu
BlueprintMenus.simple(
  items: [
    BlueprintMenuItem(
      text: 'New File',
      icon: Icons.add,
      onTap: () => createNewFile(),
    ),
    BlueprintMenuItem(
      text: 'Save',
      icon: Icons.save,
      intent: BlueprintIntent.primary,
      onTap: () => saveFile(),
    ),
  ],
)
```

### Navbar Usage
```dart
// Navbar with groups
BlueprintNavbars.withGroups(
  start: Row(
    children: [
      BlueprintNavbarHeading(text: 'MyApp'),
      BlueprintNavbarDivider(),
      TextButton(
        onPressed: () => navigateHome(),
        child: Text('Home'),
      ),
    ],
  ),
  end: IconButton(
    icon: Icon(Icons.account_circle),
    onPressed: () => showProfile(),
  ),
)
```

### Forms Usage
```dart
// Input with icon and intent
BlueprintInputs.withIntent(
  intent: BlueprintIntent.success,
  placeholder: 'Enter email',
  leftIcon: Icons.email,
  fill: true,
)

// Checkbox with intent
BlueprintCheckboxes.withIntent(
  label: 'Enable notifications',
  intent: BlueprintIntent.primary,
  checked: true,
  onChanged: (value) => setState(() => _enabled = value),
)

// Radio group
BlueprintRadios.group<String>(
  label: 'Choose size',
  options: [
    BlueprintRadios.simple(value: 'small', label: 'Small'),
    BlueprintRadios.simple(value: 'large', label: 'Large'),
  ],
  selectedValue: _selectedSize,
  onChanged: (value) => setState(() => _selectedSize = value),
)

// Filterable select
BlueprintSelects.filterable<String>(
  options: [
    BlueprintSelectOption(value: 'us', label: 'United States'),
    BlueprintSelectOption(value: 'ca', label: 'Canada'),
  ],
  placeholder: 'Select country...',
  onChanged: (value) => setState(() => _country = value),
)
```

### Layout Usage
```dart
// Section with collapsible content
BlueprintSections.collapsible(
  title: 'Advanced Settings',
  icon: Icons.settings,
  initiallyCollapsed: true,
  children: [
    Text('Settings content here...'),
    BlueprintInputs.standard(placeholder: 'API Key'),
  ],
)

// Dividers for content separation
Column(
  children: [
    Text('Section 1'),
    BlueprintDividers.horizontal(),
    Text('Section 2'),
  ],
)

// Section with cards
BlueprintSections.withCards(
  title: 'User Settings',
  cards: [
    BlueprintSectionCard(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('Profile'),
        trailing: Icon(Icons.arrow_forward),
      ),
    ),
  ],
)
```

### Collapse Usage
```dart
// BlueprintCollapse - Core animation wrapper (matches Blueprint.js)
BlueprintCollapse(
  isOpen: _isOpen,
  child: YourContent(),
)

// BlueprintCollapseExample - Button + Collapse pattern with proper button sizing
BlueprintCollapseExample(
  buttonText: 'Toggle Content',
  initiallyOpen: false,
  child: YourContent(),
)

// Manual button + collapse (for custom layouts)
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        BlueprintButton(
          text: 'Custom Trigger',
          intent: BlueprintIntent.primary,
          onPressed: () => setState(() => _isOpen = !_isOpen),
        ),
      ],
    ),
    BlueprintCollapse(
      isOpen: _isOpen,
      child: YourContent(),
    ),
  ],
)
```

### Important: Button Width Behavior
When using Blueprint buttons in Columns, wrap them in a Row to prevent them from taking full width:
```dart
// ❌ Wrong - Button takes full width
Column(
  children: [
    BlueprintButton(text: 'Button'), // Takes full width!
  ],
)

// ✅ Correct - Button sizes to content
Column(
  children: [
    Row(
      children: [
        BlueprintButton(text: 'Button'), // Sizes to content
      ],
    ),
  ],
)
```

## 🏗️ Architecture Overview

### Design Patterns Used

1. **Factory Pattern** - Convenient component creation methods
2. **State Management** - Proper Flutter state handling
3. **Composition** - Widget composition over inheritance
4. **Theme System** - Centralized design token management

### Flutter Integration

- **Material Design Foundation** - Built on Flutter's Material widgets
- **Custom Painters** - For complex UI elements (spinners, progress bars)
- **Animation Controllers** - Smooth transitions and micro-interactions
- **Responsive Layouts** - Flexible sizing and spacing

### Blueprint.js Fidelity

- **Color Accuracy** - Exact Blueprint color values
- **Typography Matching** - Consistent font sizes and weights
- **Spacing System** - 10px grid system implementation
- **Intent Colors** - Primary, Success, Warning, Danger themes
- **Pixel-Perfect Components** - Icon-text alignment and spacing matches Blueprint.js exactly

## 🎨 Design System

### Colors
The theme implements Blueprint's complete color palette:
- **Grayscale**: 10 shades from black to white
- **Core Colors**: Blue, Green, Orange, Red (5 shades each)
- **Intent Colors**: Primary (blue), Success (green), Warning (orange), Danger (red)

### Typography
- **Font Sizes**: Small (12px), Standard (14px), Large (16px)
- **Font Weights**: Regular (400), Medium (500), Semibold (600), Bold (700)

### Spacing
- **Grid Unit**: 10px base unit
- **Component Heights**: 30px (small), 40px (standard), 50px (large)
- **Border Radius**: 3px standard radius

## 🔮 Roadmap

### Potential Future Components
- **Data Display**: Text formatting utilities, complex data grids
- **Utilities**: Hotkeys, Context menus
- **Advanced Forms**: Date pickers, File uploads, Rich text editors
- **Layout**: Panel stacks, Advanced responsive grids
- **Accessibility**: Enhanced screen reader support

### Future Enhancements
- **Responsive Design**: Mobile and tablet optimizations
- **Animations**: Enhanced micro-interactions
- **Accessibility**: Screen reader support, keyboard navigation
- **Testing**: Comprehensive widget tests
- **Documentation**: Storybook-style component documentation

## 🤝 Contributing

Contributions are welcome! Please feel free to:
- Report bugs and issues
- Suggest new features
- Submit pull requests
- Improve documentation

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Open Source

This library is **open source** and available for the Flutter community to use, modify, and distribute freely under the MIT license. Contributions, bug reports, and feature suggestions are welcome!

### Why Open Source?
- **Community Value**: High-quality Blueprint.js design system for Flutter developers
- **Independent Implementation**: Original Flutter code, not a port of existing Blueprint.js code  
- **Permissive License**: MIT license allows commercial and personal use
- **Educational Resource**: Well-structured component library following Flutter best practices

## 🙏 Acknowledgments

- [Blueprint.js](https://blueprintjs.com/) - Original design system and inspiration by Palantir Technologies
- [Flutter](https://flutter.dev/) - Google's UI toolkit
- [Material Design](https://material.io/) - Design system foundation

---

**Disclaimer**: This is an independent Flutter implementation inspired by the Blueprint.js design system. It is not affiliated with, endorsed by, or officially connected to Blueprint.js or Palantir Technologies. All Blueprint.js trademarks and design patterns belong to their respective owners.

**Project Statistics**: ~12,000+ lines of code | 26 components | 24 demo pages | 55+ Dart files | **Perfect tag centering, table alignment & text centering**