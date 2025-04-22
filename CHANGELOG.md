# Changelog

All notable changes to the Wanigo UI package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2025-04-23

### Added
- Initial release of Wanigo UI package
- Core components:
  - `GlobalText` with multiple variants for typography system (headings, body text with various weights)
  - `GlobalButton` with primary, secondary, and tertiary styles in multiple sizes
  - `GlobalTextField` for consistent input styling
  - `GlobalDropdown` for dropdown selection components
  - `GlobalAppBar` for consistent app navigation headers
  - `GlobalModal` for displaying dialogs and alerts
  - `GlobalIcon` for consistent icon usage
  - `GlobalTabMenu` with equal width and flexible width variants
  - `BaseWidgetContainer` for wrapping screens
- Styling system:
  - `AppColors` color palette with semantic naming
  - `GlobalShadow` elevation system with consistent shadows
  - `AppTheme` for theme configuration

### Features
- Typography system with multiple text variants (heading, body) and weights (regular, medium, semiBold, bold, extraBold)
- Button system with multiple styles (primary, secondary, tertiary) and sizes (xsmall, small, medium, large)
- Input fields with proper styling for regular, focused, disabled, and error states
- Dropdown component with intuitive item selection and states
- Modal system for creating consistent dialogs and messages
- Tab menu system with flexible configuration options
- Comprehensive color system with shades for blue, orange, gray, red, and green

## How to upgrade
For the initial release, no upgrade steps are required. Just add the dependency to your pubspec.yaml:

```yaml
dependencies:
  wanigo_ui: ^0.0.1
```

## Coming Soon
- Enhanced theming capabilities
- More specialized input fields (date pickers, etc.)
- Form validation helpers
- Enhanced animation system
- More complex UI patterns
