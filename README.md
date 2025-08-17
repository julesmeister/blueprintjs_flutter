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
├── lib/
│   ├── main.dart                           # App entry point and navigation
│   ├── components/                         # Blueprint components
│   │   ├── blueprint_alert.dart            # Alert dialogs
│   │   ├── blueprint_button.dart           # Button variants
│   │   ├── blueprint_callout.dart          # Callout blocks
│   │   ├── blueprint_card.dart             # Card components
│   │   ├── blueprint_progress_bar.dart     # Progress indicators
│   │   ├── blueprint_spinner.dart          # Loading spinners
│   │   ├── blueprint_tabs.dart             # Tab navigation
│   │   └── blueprint_tooltip.dart          # Hover tooltips
│   ├── pages/                              # Demo pages
│   │   ├── alert_demo_page.dart            # Alert examples
│   │   ├── button_demo_page.dart           # Button examples
│   │   ├── callout_demo_page.dart          # Callout examples
│   │   ├── card_demo_page.dart             # Card examples
│   │   ├── colors_demo_page.dart           # Color palette
│   │   ├── progress_bar_demo_page.dart     # Progress examples
│   │   ├── spinner_demo_page.dart          # Spinner examples
│   │   ├── tabs_demo_page.dart             # Tab examples
│   │   └── tooltip_demo_page.dart          # Tooltip examples
│   └── theme/                              # Design system
│       ├── blueprint_colors.dart           # Color palette
│       └── blueprint_theme.dart            # Theme configuration
├── pubspec.yaml                            # Dependencies
├── run-windows.bat                         # Windows launcher
└── README.md                               # This file
```

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