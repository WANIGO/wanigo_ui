import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_ui/src/texts/global_text.dart';

/// A global tab menu component that provides consistent tab styling across the app.
class GlobalTabMenu extends StatefulWidget {
  /// List of tab items to display
  final List<String> tabs;
  
  /// Initial active tab index (default 0)
  final int initialIndex;
  
  /// Callback when a tab is selected, returns the index
  final Function(int) onTabSelected;
  
  /// Background color for the tab bar
  final Color backgroundColor;
  
  /// Active tab indicator color
  final Color activeIndicatorColor;
  
  /// Active tab text color
  final Color activeTextColor;
  
  /// Inactive tab text color
  final Color inactiveTextColor;

  /// Tab height (default 40)
  final double tabHeight;

  const GlobalTabMenu({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    required this.onTabSelected,
    this.backgroundColor = Colors.white,
    this.activeIndicatorColor = const Color(0xFF084BC4), // Blue-600
    this.activeTextColor = const Color(0xFF084BC4), // Blue-600
    this.inactiveTextColor = const Color(0xFF6B6F70), // Grey-300
    this.tabHeight = 40,
  }) : assert(tabs.length >= 2, 'At least 2 tabs are required');

  @override
  State<GlobalTabMenu> createState() => _GlobalTabMenuState();
}

class _GlobalTabMenuState extends State<GlobalTabMenu> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.tabHeight.h,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFDFE1E7), // Greyscale-100
            width: 1.h,
          ),
        ),
      ),
      child: Row(
        children: List.generate(
          widget.tabs.length,
          (index) => Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onTabSelected(index);
              },
              child: Container(
                height: widget.tabHeight.h,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedIndex == index
                          ? widget.activeIndicatorColor
                          : Colors.transparent,
                      width: 2.h,
                    ),
                  ),
                ),
                child: Center(
                  child: GlobalText(
                    text: widget.tabs[index],
                    variant: TextVariant.largeSemiBold,
                    color: _selectedIndex == index
                        ? widget.activeTextColor
                        : widget.inactiveTextColor,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tab variant with equal width tabs
class GlobalTabMenuEqualWidth extends GlobalTabMenu {
  const GlobalTabMenuEqualWidth({
    super.key,
    required super.tabs,
    super.initialIndex = 0,
    required super.onTabSelected,
    super.backgroundColor = Colors.white,
    super.activeIndicatorColor = const Color(0xFF084BC4),
    super.activeTextColor = const Color(0xFF084BC4),
    super.inactiveTextColor = const Color(0xFF6B6F70),
    super.tabHeight = 40,
  });
}

/// Tab variant with content-based width tabs
class GlobalTabMenuFlexibleWidth extends StatefulWidget {
  /// List of tab items to display
  final List<String> tabs;
  
  /// Initial active tab index (default 0)
  final int initialIndex;
  
  /// Callback when a tab is selected, returns the index
  final Function(int) onTabSelected;
  
  /// Background color for the tab bar
  final Color backgroundColor;
  
  /// Active tab indicator color
  final Color activeIndicatorColor;
  
  /// Active tab text color
  final Color activeTextColor;
  
  /// Inactive tab text color
  final Color inactiveTextColor;

  /// Tab height (default 40)
  final double tabHeight;

  /// Tab padding
  final EdgeInsetsGeometry tabPadding;

  const GlobalTabMenuFlexibleWidth({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    required this.onTabSelected,
    this.backgroundColor = Colors.white,
    this.activeIndicatorColor = const Color(0xFF084BC4), // Blue-600
    this.activeTextColor = const Color(0xFF084BC4), // Blue-600
    this.inactiveTextColor = const Color(0xFF6B6F70), // Grey-300
    this.tabHeight = 40,
    this.tabPadding = const EdgeInsets.symmetric(horizontal: 16),
  }) : assert(tabs.length >= 2, 'At least 2 tabs are required');

  @override
  State<GlobalTabMenuFlexibleWidth> createState() => _GlobalTabMenuFlexibleWidthState();
}

class _GlobalTabMenuFlexibleWidthState extends State<GlobalTabMenuFlexibleWidth> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.tabHeight.h,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFDFE1E7), // Greyscale-100
            width: 1.h,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            widget.tabs.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onTabSelected(index);
              },
              child: Container(
                height: widget.tabHeight.h,
                padding: widget.tabPadding,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedIndex == index
                          ? widget.activeIndicatorColor
                          : Colors.transparent,
                      width: 2.h,
                    ),
                  ),
                ),
                child: Center(
                  child: GlobalText(
                    text: widget.tabs[index],
                    variant: TextVariant.largeSemiBold,
                    color: _selectedIndex == index
                        ? widget.activeTextColor
                        : widget.inactiveTextColor,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}