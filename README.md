# Blueprint Flutter Demo

A comprehensive Flutter implementation of the [Blueprint.js](https://blueprintjs.com/) design system. This project recreates Blueprint's core components and design language for Flutter applications.

## 🚀 Features

### ✅ Completed Components

- **🎨 Theme System** - Complete Blueprint color palette, typography, and design tokens
- **🔘 Buttons** - All variants (filled, outlined, minimal), sizes, intents, and loading states
- **⚠️ Alerts** - Dialog-based alerts with all intent types and customizable actions
- **📋 Cards** - Interactive cards with elevation, hover effects, and card lists
- **📑 Tabs** - Horizontal and vertical tabs with controlled/uncontrolled modes
- **⏳ Spinners** - Loading indicators with determinate/indeterminate progress
- **📊 Progress Bars** - Linear progress indicators with animations and stripes
- **💬 Tooltips** - Contextual hover information with positioning options
- **📢 Callouts** - Highlighted content blocks with intent colors and rich content

### 🎯 Key Features

- **Faithful Design Recreation** - Matches Blueprint.js visual design and interactions
- **Flutter Best Practices** - Proper state management, animations, and widget composition
- **Comprehensive Demos** - Interactive examples for each component
- **Dark/Light Theme Support** - Built-in theme switching
- **Intent-based Colors** - Primary, Success, Warning, Danger color schemes
- **Accessibility** - Semantic labels and proper focus management
- **Factory Methods** - Convenient component creation patterns

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
│   ├── 📄 main.dart                        # App entry point and navigation
│   │
│   ├── 📂 components/                      # Blueprint component library
│   │   ├── 📄 blueprint_alert.dart         # Alert dialogs and confirmations
│   │   ├── 📄 blueprint_button.dart        # Button variants and states
│   │   ├── 📄 blueprint_callout.dart       # Callout notification blocks
│   │   ├── 📄 blueprint_card.dart          # Card containers and layouts
│   │   ├── 📄 blueprint_progress_bar.dart  # Linear progress indicators
│   │   ├── 📄 blueprint_spinner.dart       # Loading spinners and progress
│   │   ├── 📄 blueprint_tabs.dart          # Tab navigation components
│   │   └── 📄 blueprint_tooltip.dart       # Hover tooltip overlays
│   │
│   ├── 📂 pages/                           # Demo and example pages
│   │   ├── 📄 alert_demo_page.dart         # Alert component examples
│   │   ├── 📄 button_demo_page.dart        # Button component examples
│   │   ├── 📄 callout_demo_page.dart       # Callout component examples
│   │   ├── 📄 card_demo_page.dart          # Card component examples
│   │   ├── 📄 colors_demo_page.dart        # Color palette showcase
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
| `lib/components/` | 8 files | Core Blueprint component implementations |
| `lib/pages/` | 9 files | Interactive demo pages and examples |
| `lib/theme/` | 2 files | Design system and color palette |
| `lib/` (root) | 1 file | Main application entry point |
| **Total** | **20 files** | **Complete Flutter application** |

### Component Files Details

#### Core Components (`lib/components/`)
1. **blueprint_alert.dart** - Dialog-based alerts with customizable actions
2. **blueprint_button.dart** - Complete button system with all variants
3. **blueprint_callout.dart** - Highlighted information blocks
4. **blueprint_card.dart** - Container components with interactions
5. **blueprint_progress_bar.dart** - Linear progress with animations
6. **blueprint_spinner.dart** - Circular loading indicators
7. **blueprint_tabs.dart** - Tab navigation system
8. **blueprint_tooltip.dart** - Contextual hover information

#### Demo Pages (`lib/pages/`)
1. **alert_demo_page.dart** - Alert dialog examples and interactions
2. **button_demo_page.dart** - Button variants, sizes, and states
3. **callout_demo_page.dart** - Callout styles and use cases
4. **card_demo_page.dart** - Card layouts and interactions
5. **colors_demo_page.dart** - Complete color palette showcase
6. **progress_bar_demo_page.dart** - Progress indicator examples
7. **spinner_demo_page.dart** - Loading spinner variations
8. **tabs_demo_page.dart** - Tab navigation examples
9. **tooltip_demo_page.dart** - Tooltip positioning and styles

#### Theme System (`lib/theme/`)
1. **blueprint_colors.dart** - Complete Blueprint.js color palette
2. **blueprint_theme.dart** - Flutter theme configuration

## 🎨 Component Gallery

### Buttons
- **Variants**: Filled, Outlined, Minimal
- **Sizes**: Small, Medium, Large
- **Intents**: Primary, Success, Warning, Danger
- **States**: Loading, Disabled, Active
- **Features**: Icons, text, factory methods

### Cards
- **Types**: Basic, Interactive, Elevated
- **Features**: Hover effects, click handling, custom padding
- **Layouts**: Individual cards, card lists, grid layouts

### Tabs
- **Orientations**: Horizontal, Vertical
- **Modes**: Controlled, Uncontrolled
- **Features**: Icons, badges, disabled states, large size variant

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
- Windows development environment (for Windows builds)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd blueprint_flutter_demo
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run -d windows
   ```
   
   Or use the Windows launcher:
   ```bash
   run-windows.bat
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

### Planned Components
- **Navigation**: Breadcrumbs, Menu, Navbar
- **Forms**: Input fields, Select, Checkbox, Radio
- **Layout**: Divider, Section, Panel Stack
- **Overlays**: Dialog, Drawer, Popover, Toast
- **Data Display**: Table, Tree, Tag, Text
- **Utilities**: Collapse, Icon, Hotkeys

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

## 🙏 Acknowledgments

- [Blueprint.js](https://blueprintjs.com/) - Original design system by Palantir Technologies
- [Flutter](https://flutter.dev/) - Google's UI toolkit
- [Material Design](https://material.io/) - Design system foundation

---

**Note**: This is a community implementation and is not officially affiliated with Blueprint.js or Palantir Technologies.

**Project Statistics**: ~3,500+ lines of code | 9 components | 9 demo pages | 20 Dart files