# Blueprint.js Tooltips: Comprehensive Implementation Analysis

## Overview
This document provides a complete pixel-perfect analysis of Blueprint.js tooltip implementation based on examination of the source code in `C:\Users\User\Documents\blueprint_flutter_demo\blueprint\packages\core\src`.

## Files Examined
- `components/tooltip/tooltip.tsx` - Main tooltip component
- `components/tooltip/_tooltip.scss` - Tooltip-specific styles
- `components/tooltip/_common.scss` - Tooltip color variables
- `components/popover/popoverArrow.tsx` - Arrow/caret implementation
- `components/popover/_popover.scss` - Base popover styles
- `components/popover/_common.scss` - Popover mixins and shared styles
- `common/_variables.scss` - Global variables (grid size, shadows, transitions)
- `common/_color-aliases.scss` - Color definitions
- `colors/src/_colors.scss` - Color palette values
- `common/_mixins.scss` - Intent color mappings
- `common/_react-transition.scss` - Animation framework

## Core Implementation Details

### 1. Tooltip Structure
Tooltips are built on top of the Popover component with specific styling overrides:

```typescript
// Default tooltip properties
static defaultProps: Partial<TooltipProps> = {
    compact: false,
    hoverCloseDelay: 0,          // ms - no delay on close
    hoverOpenDelay: 100,         // ms - 100ms delay on open  
    interactionKind: "hover-target",
    minimal: false,
    transitionDuration: 100,     // ms - animation duration
};
```

### 2. Color Specifications

#### Light Theme (Default)
```scss
$tooltip-background-color: $dark-gray5; // #404854
$tooltip-text-color: $light-gray5;      // #f6f7f9
```

#### Dark Theme
```scss
$dark-tooltip-background-color: $light-gray3; // #e5e8eb
$dark-tooltip-text-color: $dark-gray5;        // #404854
```

#### Intent Colors (Primary, Success, Warning, Danger)
```scss
$pt-intent-colors: (
  "primary": $blue3,   // #2d72d2
  "success": $green3,  // #238551  
  "warning": $orange3, // #c87619
  "danger": $red3,     // #cd4246
);
```

For intent tooltips:
- Background: Uses the intent color directly
- Text: Always white (#ffffff)
- Arrow: Filled with the intent color

### 3. Sizing and Spacing

#### Grid System
```scss
$pt-grid-size: 10px; // Base unit for all measurements
```

#### Normal Padding
```scss
$tooltip-padding-vertical: $pt-grid-size;     // 10px
$tooltip-padding-horizontal: 1.2 * $pt-grid-size; // 12px
```

#### Compact Padding
```scss
$tooltip-padding-compact-vertical: 0.5 * $pt-grid-size;   // 5px
$tooltip-padding-compact-horizontal: 0.7 * $pt-grid-size; // 7px
```

#### Border Radius
```scss
$pt-border-radius: 2px; // Applied to tooltip content
```

### 4. Arrow/Caret Implementation

#### SVG Specifications
```scss
POPOVER_ARROW_SVG_SIZE = 30px;  // For popovers
TOOLTIP_ARROW_SVG_SIZE = 22px;  // For tooltips (smaller)
ARROW_SPACING = 4px;            // Extra space from target
```

#### SVG Paths
```typescript
// Shadow path for arrow border
const SVG_SHADOW_PATH = 
    "M8.11 6.302c1.015-.936 1.887-2.922 1.887-4.297v26c0-1.378" +
    "-.868-3.357-1.888-4.297L.925 17.09c-1.237-1.14-1.233-3.034 0-4.17L8.11 6.302z";

// Fill path for arrow interior  
const SVG_ARROW_PATH =
    "M8.787 7.036c1.22-1.125 2.21-3.376 2.21-5.03V0v30-2.005" +
    "c0-1.654-.983-3.9-2.21-5.03l-7.183-6.616c-.81-.746-.802-1.96 0-2.7l7.183-6.614z";
```

#### Arrow Positioning Adjustments
Tooltips have specific arrow positioning adjustments compared to regular popovers:

```scss
&.#{$ns}-popover-placement-top .#{$ns}-popover-arrow {
  transform: translateY(-3px);
}
&.#{$ns}-popover-placement-left .#{$ns}-popover-arrow {
  transform: translateX(-3px);  
}
&.#{$ns}-popover-placement-bottom .#{$ns}-popover-arrow {
  transform: translateY(3px);
}
&.#{$ns}-popover-placement-right .#{$ns}-popover-arrow {
  transform: translateX(3px);
}
```

#### Arrow Rotation by Placement
```typescript
function getArrowAngle(placement?: Placement) {
    switch (getBasePlacement(placement)) {
        case "top": return -90;
        case "left": return 180; 
        case "bottom": return 90;
        default: return 0;  // right
    }
}
```

### 5. Shadow Specifications

#### Light Theme Shadows
```scss
$tooltip-arrow-box-shadow: 1px 1px 6px rgba($black, $pt-drop-shadow-opacity);
// Where $pt-drop-shadow-opacity: 0.2

$pt-tooltip-box-shadow: $pt-elevation-shadow-3;
// Which equals:
//   border-shadow($pt-border-shadow-opacity),           // 0 0 0 1px rgba(black, 0.1)
//   0 2px 4px rgba($black, $pt-drop-shadow-opacity),    // 0 2px 4px rgba(black, 0.2) 
//   0 8px 24px rgba($black, $pt-drop-shadow-opacity)    // 0 8px 24px rgba(black, 0.2)
```

#### Dark Theme Shadows  
```scss
$dark-tooltip-arrow-box-shadow: 1px 1px 6px rgba($black, $pt-dark-drop-shadow-opacity);
// Where $pt-dark-drop-shadow-opacity: 0.4

$pt-dark-tooltip-box-shadow:
  0 2px 4px rgba($black, $pt-dark-drop-shadow-opacity),    // 0 2px 4px rgba(black, 0.4)
  0 8px 24px rgba($black, $pt-dark-drop-shadow-opacity);   // 0 8px 24px rgba(black, 0.4)
```

### 6. Animation and Transitions

#### Transition Properties
```scss
$pt-transition-duration: 100ms;
$pt-transition-ease: cubic-bezier(0.4, 1, 0.75, 0.9);
```

#### Tooltip-Specific Animation
Tooltips use a scale animation (different from popovers' bounce):

```scss
@include react-transition(
  "#{$ns}-popover",
  (transform: scale(0.8) scale(1)),  // Scale from 80% to 100%
  $duration: $pt-transition-duration,  // 100ms
  $after: "> &"
);
```

#### Timing Behavior
- **Hover Open Delay**: 100ms (default) - tooltip appears after 100ms hover
- **Hover Close Delay**: 0ms (default) - tooltip disappears immediately when hover ends
- **Animation Duration**: 100ms for both enter and exit transitions

### 7. Positioning System

#### Available Positions
All standard positions are supported via the Popover system:

```typescript
const Position = {
    BOTTOM: "bottom",
    BOTTOM_LEFT: "bottom-left", 
    BOTTOM_RIGHT: "bottom-right",
    LEFT: "left",
    LEFT_BOTTOM: "left-bottom",
    LEFT_TOP: "left-top", 
    RIGHT: "right",
    RIGHT_BOTTOM: "right-bottom",
    RIGHT_TOP: "right-top",
    TOP: "top",
    TOP_LEFT: "top-left",
    TOP_RIGHT: "top-right"
};
```

Plus auto-positioning options:
- `"auto"` - Automatically choose best position
- `"auto-start"` - Auto with start alignment
- `"auto-end"` - Auto with end alignment

#### Positioning Strategy
```typescript
positioningStrategy?: "absolute" | "fixed"; // Default: "absolute"
```

### 8. Interaction Behavior

#### Supported Interaction Types
```typescript
const PopoverInteractionKind = {
    HOVER: "hover",              // Hover on tooltip or target
    HOVER_TARGET_ONLY: "hover-target",  // Hover on target only (default for tooltips)
};
```

#### Focus Behavior
- `autoFocus: false` (default for tooltips)
- `enforceFocus: false` - Tooltips don't trap focus
- `canEscapeKeyClose: false` - ESC key doesn't close tooltips
- `shouldReturnFocusOnClose` is not used for tooltips

### 9. Compact Mode

#### Usage
```typescript
<Tooltip compact={true} content="Compact tooltip">
  Target
</Tooltip>
```

#### Visual Changes
- Reduced padding: `5px 7px` instead of `10px 12px`
- Fixed line height: `1rem`
- Special vertical alignment for `<Code>` elements: `vertical-align: text-bottom`

### 10. CSS Classes Applied

#### Main Classes
- `.bp6-tooltip` - Main tooltip class
- `.bp6-compact` - When compact prop is true
- `.bp6-intent-primary|success|warning|danger` - For intent tooltips
- `.bp6-dark` - Dark theme styling
- `.bp6-minimal` - When minimal prop is true (hides arrow)

#### Structure Classes
- `.bp6-popover-content` - Content container
- `.bp6-popover-arrow` - Arrow container
- `.bp6-popover-arrow-border` - Arrow border path
- `.bp6-popover-arrow-fill` - Arrow fill path

#### Placement Classes  
- `.bp6-popover-placement-top|bottom|left|right` - Applied based on actual placement
- Additional modifiers: `-start` and `-end` for alignment

### 11. Typography Override

Tooltips override global typography colors due to their dark background:

```scss
// Dark typography colors used in light theme tooltips
@include pt-dark-typography-colors();

// Which sets:
color: $pt-dark-text-color;        // #f6f7f9
.#{$ns}-heading { color: $pt-dark-text-color; }
```

### 12. Accessibility Features

#### High Contrast Mode Support
```scss
@media (forced-colors: active) and (prefers-color-scheme: dark) {
  .#{$ns}-popover-arrow-border {
    // Windows high contrast mode border
    fill: $pt-high-contrast-mode-border-color; // buttonborder system color
  }
  
  .#{$ns}-popover-arrow-fill {
    fill: $pt-high-contrast-mode-border-color;
  }
}
```

#### ARIA Support
- Proper `aria-hidden="true"` on arrow elements
- Popover ARIA attributes are inherited from base Popover component

### 13. Implementation Notes

#### Performance Optimizations
- `lazy={true}` - Content not rendered until first open
- Uses React refs for DOM manipulation instead of queries
- Efficient event handling with proper cleanup

#### Popper.js Integration
- Uses Popper.js v2 for positioning
- Custom modifiers for arrow positioning and width matching
- Boundary detection: `"clippingParents"` (default)

#### Portal Rendering
- `usePortal: true` by default
- Renders outside normal DOM flow to avoid z-index issues
- Portal container can be customized

### 14. Common Patterns

#### Basic Tooltip
```typescript
<Tooltip content="Simple tooltip">
  <Button text="Hover me" />
</Tooltip>
```

#### Intent Tooltip
```typescript
<Tooltip content="Success message" intent="success">
  <Icon icon="tick" />
</Tooltip>
```

#### Compact Tooltip
```typescript
<Tooltip content="Brief" compact={true}>
  <span className="bp6-tooltip-indicator">Help</span>
</Tooltip>
```

#### Custom Positioning
```typescript
<Tooltip 
  content="Custom positioned" 
  placement="bottom-start"
  hoverOpenDelay={200}
>
  <Button text="Custom" />
</Tooltip>
```

## CSS Variable Equivalents

For CSS custom property implementations, these key values should be defined:

```css
:root {
  --bp-grid-size: 10px;
  --bp-border-radius: 2px;
  --bp-transition-duration: 100ms;
  --bp-transition-ease: cubic-bezier(0.4, 1, 0.75, 0.9);
  
  /* Light theme tooltip colors */
  --bp-tooltip-background: #404854;
  --bp-tooltip-color: #f6f7f9;
  
  /* Dark theme tooltip colors */  
  --bp-tooltip-dark-background: #e5e8eb;
  --bp-tooltip-dark-color: #404854;
  
  /* Intent colors */
  --bp-intent-primary: #2d72d2;
  --bp-intent-success: #238551;
  --bp-intent-warning: #c87619;  
  --bp-intent-danger: #cd4246;
  
  /* Shadows */
  --bp-tooltip-shadow: 
    0 0 0 1px rgba(17, 20, 24, 0.1),
    0 2px 4px rgba(17, 20, 24, 0.2),
    0 8px 24px rgba(17, 20, 24, 0.2);
}
```

This comprehensive analysis provides all the necessary details for implementing pixel-perfect Blueprint.js-style tooltips in any framework or custom implementation.