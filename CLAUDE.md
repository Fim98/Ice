# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Ice is a macOS menu bar management tool written in Swift using SwiftUI and AppKit. It allows users to hide/show menu bar items, organize them into sections, and customize the menu bar appearance.

- **Platform**: macOS 14+ (Sonoma and later)
- **License**: GPL-3.0
- **Distribution**: GitHub Releases, Homebrew (`brew install --cask jordanbaird-ice`)

## Build Commands

This is an Xcode project. Use the following commands:

```bash
# Build the project
xcodebuild -project Ice.xcodeproj -scheme Ice build

# Open in Xcode
open Ice.xcodeproj
```

## Linting

SwiftLint is used for code style enforcement:

```bash
# Run SwiftLint locally (requires installation)
swiftlint

# Run with strict mode (CI behavior)
swiftlint --strict
```

SwiftLint is configured in `.swiftlint.yml` and runs automatically as a build phase in Xcode. Key configuration:
- 4 spaces for indentation (no tabs)
- Trailing commas are mandatory
- File header required: `//  FILENAME\n//  Ice\n//`

## Architecture

### Central State Management

`AppState` (`Ice/Main/AppState.swift`) is the central `@MainActor` ObservableObject that coordinates all managers. It owns:

- `MenuBarManager` - Menu bar section state and visibility
- `MenuBarItemManager` - Item caching and movement operations
- `MenuBarAppearanceManager` - Visual styling (tints, shadows, shapes)
- `EventManager` - Mouse/keyboard event monitoring
- `PermissionsManager` - Accessibility and screen recording permissions
- `SettingsManager` - User preferences persistence
- `HotkeyRegistry` - Global hotkey registration (Carbon HIToolbox)
- `MenuBarItemImageCache` - Caching of menu bar item images

### Menu Bar Sections

The app organizes items into three sections (`MenuBarSection`):

1. **Visible** - Always shown items (rightmost)
2. **Hidden** - Items behind the Ice icon (toggleable)
3. **Always-Hidden** - Secondary hidden section (leftmost)

Control items (`ControlItem`) are status items that act as dividers between sections.

### Key UI Components

- **IceBarPanel** (`Ice/UI/IceBar/`) - Floating panel displaying hidden items below the menu bar (for MacBooks with notches)
- **LayoutBar** (`Ice/UI/LayoutBar/`) - Drag-and-drop interface for arranging items
- **SettingsWindow** (`Ice/Settings/`) - SwiftUI-based settings interface

### System Integration

- **Bridging** (`Ice/Bridging/Bridging.swift`) - Interfaces with Core Graphics Services (CGS) private APIs for window server operations
- **Method Swizzling** (`Ice/Swizzling/`) - `NSSplitViewItem` swizzling to prevent sidebar collapse in settings
- **Permissions Required**: Accessibility (for item manipulation), Screen Recording (for appearance capture)

### Data Flow

1. **App Launch** (`IceApp.swift`): Swizzle NSSplitViewItem → Run migrations → Check permissions
2. **Setup** (`AppState.performSetup()`): Initialize managers → Configure Combine publishers → Start event monitors
3. **Runtime**: Event monitors detect interactions → MenuBarManager updates visibility → ItemManager handles movement

### Dependencies (Swift Package Manager)

- **Sparkle** - Automatic updates
- **AXSwift** - Accessibility APIs
- **LaunchAtLogin** - Launch at login functionality
- **CompactSlider** - Custom slider UI
- **IfritStatic** - Fuzzy search for menu bar item search

## Important Files

- `Ice/Main/IceApp.swift` - App entry point
- `Ice/Main/AppState.swift` - Central state management
- `Ice/MenuBar/MenuBarManager.swift` - Core menu bar functionality
- `Ice/MenuBar/MenuBarSection.swift` - Section definitions
- `Ice/Bridging/Bridging.swift` - Low-level macOS API bridging

## Documentation

- `README.md` - Features, install instructions, roadmap
- `FREQUENT_ISSUES.md` - FAQ for common user issues
