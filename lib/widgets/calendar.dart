// lib/screens/calendar.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wanigo_part/essentials/app_colors.dart';
import 'package:wanigo_part/screens/planoption.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime currentMonth;
  late DateTime selectedDate;
  late List<DateTime> datesGrid;
  final GlobalKey _calendarKey = GlobalKey();
  CalendarView _currentView = CalendarView.monthly;

  // Background color for the entire app
  static const Color _backgroundColor = Color(0xFFE8ECFC);

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    currentMonth = DateTime(selectedDate.year, selectedDate.month);
    _updateDatesGrid();
  }

  void _updateDatesGrid() {
    setState(() {
      if (_currentView == CalendarView.monthly) {
        datesGrid = _generateDatesGrid(currentMonth);
      } else {
        datesGrid = _generateDatesGrid(null, weekOnly: true);
      }
    });
  }

  List<DateTime> _generateDatesGrid(DateTime? month, {bool weekOnly = false}) {
    if (weekOnly) {
      int weekdayAdjustment = selectedDate.weekday % 7;
      DateTime startOfWeek = selectedDate.subtract(Duration(days: weekdayAdjustment));
      return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
    }

    final DateTime effectiveMonth = month ?? currentMonth;
    
    int numDays = DateTime(effectiveMonth.year, effectiveMonth.month + 1, 0).day;
    int firstWeekday = DateTime(effectiveMonth.year, effectiveMonth.month, 1).weekday % 7;
    List<DateTime> dates = [];

    DateTime previousMonth = DateTime(effectiveMonth.year, effectiveMonth.month - 1);
    int previousMonthLastDay =
        DateTime(previousMonth.year, previousMonth.month + 1, 0).day;
    for (int i = firstWeekday; i > 0; i--) {
      dates.add(DateTime(previousMonth.year, previousMonth.month,
          previousMonthLastDay - i + 1));
    }

    for (int day = 1; day <= numDays; day++) {
      dates.add(DateTime(effectiveMonth.year, effectiveMonth.month, day));
    }

    int remainingBoxes = 42 - dates.length;
    for (int day = 1; day <= remainingBoxes; day++) {
      dates.add(DateTime(effectiveMonth.year, effectiveMonth.month + 1, day));
    }

    return dates;
  }

  void _changeSelectedDate(int offset) {
    setState(() {
      if (_currentView == CalendarView.monthly) {
        currentMonth = DateTime(currentMonth.year, currentMonth.month + offset);
        datesGrid = _generateDatesGrid(currentMonth);
      } else {
        // In weekly view, move forward or backward by 7 days (one week)
        selectedDate = selectedDate.add(Duration(days: 7 * offset));
        datesGrid = _generateDatesGrid(null, weekOnly: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: TColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: null,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/WANIGO_logo.png',
                  width: 24,
                  height: 24,
                  color: TColors.appPrimaryColor,
                ),
                Text(
                  "WANIGO!",
                  style: TextStyle(
                    color: TColors.appPrimaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Calendar header
          Container(
            color: _backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => _changeSelectedDate(-1),
                      child: Transform.scale(
                        scaleX: -1,
                        child: Image.asset(
                          'assets/icons/month_arrow.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                    Container(
                      width: 160,
                      child: Center(
                        child: Text(
                          _currentView == CalendarView.monthly
                            ? '${_monthName(currentMonth.month)} ${currentMonth.year}'
                            : '${_monthName(selectedDate.month)} ${selectedDate.year}',
                          style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF084BC4),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _changeSelectedDate(1),
                      child: Image.asset(
                        'assets/icons/month_arrow.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_currentView == CalendarView.monthly) {
                            _currentView = CalendarView.weekly;
                            selectedDate = DateTime.now();
                          } else {
                            _currentView = CalendarView.monthly;
                            currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
                          }
                          _updateDatesGrid();
                        });
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/calendar_icon.png',
                            width: 24,
                            height: 24
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            _currentView == CalendarView.monthly 
                              ? Icons.keyboard_arrow_up 
                              : Icons.keyboard_arrow_down,
                            color: TColors.textPrimary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Combined calendar section with day names and grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    
                    // Day names row
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(7, (index) {
                          final days = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
                          return Expanded(
                            child: Center(
                              child: Text(
                                days[index],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    
                    const SizedBox(height: 2),
                    
                    // Calendar Grid
                    Expanded(
                      child: _currentView == CalendarView.monthly 
                        ? _buildMonthlyView() 
                        : _buildWeeklyView(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Section for Plan Management
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: _buildBottomSection(),
          ),
        ],
      ),
    );
  }

  // Placeholder for bottom section to be implemented in calendar_planlist.dart
  Widget _buildBottomSection() {
    return Column(
      children: [
        Image.asset(
          'assets/icons/add_calendar1.png',
          width: 90,
          height: 90,
        ),
        const Gap(12),
        const Text(
          "Jadwal Belum Dibuat",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Gap(12),
        const Text(
          "Buat jadwal pemilahan atau setoran sampah untuk memulai proses pengelolaan sampah yang lebih teratur dan efisien",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            height: 1.5,
          ),
        ),
        const Gap(24),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlanTypeScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2196F3),
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Buat Jadwal",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // Monthly View Implementation
  Widget _buildMonthlyView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: datesGrid.length,
      itemBuilder: (context, index) {
        DateTime date = datesGrid[index];
        bool isCurrentMonth = date.month == currentMonth.month;
        
        return Center(
          child: Text(
            date.day.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isCurrentMonth 
                ? Color(0xFF084BC4) 
                : Color(0xFF212729).withOpacity(0.5),
            ),
          ),
        );
      },
    );
  }

  // Weekly View Implementation
  Widget _buildWeeklyView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: datesGrid.length,
      itemBuilder: (context, index) {
        DateTime date = datesGrid[index];
        bool isCurrentMonth = date.month == selectedDate.month;
        
        return Center(
          child: Text(
            date.day.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isCurrentMonth 
                ? Color(0xFF084BC4) 
                : Color(0xFF212729).withOpacity(0.5),
            ),
          ),
        );
      },
    );
  }

  // Month name helper
  String _monthName(int monthNumber) {
    return [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ][monthNumber - 1];
  }
}

// Calendar view enum
enum CalendarView {
  monthly,
  weekly
}