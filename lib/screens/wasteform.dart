import 'package:flutter/material.dart';
import 'package:wanigo_part/essentials/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';

class WasteSortingScheduleForm extends StatefulWidget {
  const WasteSortingScheduleForm({Key? key}) : super(key: key);

  @override
  _WasteSortingScheduleFormState createState() => _WasteSortingScheduleFormState();
}

class _WasteSortingScheduleFormState extends State<WasteSortingScheduleForm> {
  // Frequency selection
  String _selectedFrequency = 'Harian';
  final List<String> _frequencies = ['Harian', 'Mingguan', 'Bulanan'];

  // Time selection
  TimeOfDay _selectedTime = const TimeOfDay(hour: 7, minute: 0);
  final List<String> _predefinedTimes = ['07.00', '09.00', '11.00', '17.00'];
  
  // Calendar variables
  late DateTime currentMonth;
  late DateTime selectedDate;
  late List<DateTime> datesGrid;
  CalendarView _currentView = CalendarView.monthly;
  
  // Calendar days of week
  final List<String> _daysOfWeek = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
  
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    currentMonth = DateTime(selectedDate.year, selectedDate.month);
    _updateDatesGrid();
    _scrollController = ScrollController();
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
      backgroundColor: Colors.white,
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Form Jadwal Pemilahan",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Isi form dibawah ini untuk atur jadwal",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Frequency Selection
                        Text(
                          "Pilih Frekuensi Pemilahan Sampah",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: _frequencies.map((frequency) {
                            bool isSelected = _selectedFrequency == frequency;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedFrequency = frequency;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.blue[800] : Colors.grey[100],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      frequency,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.black87,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 30),

                        // Time Selection
                        Text(
                          "Pilih Waktu Mulai Pemilahan Sampah",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        // Custom Time Selector with side-by-side layout
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Time display card on the left - wider with less vertical padding
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45, // Almost half of screen width
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Reduced vertical padding
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${_selectedTime.hour.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontSize: 24, // Reduced font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  SizedBox(width: 8), // Added spacing
                                  Text(
                                    ".",
                                    style: TextStyle(
                                      fontSize: 24, // Reduced font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  SizedBox(width: 8), // Added spacing
                                  Text(
                                    "${_selectedTime.minute.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontSize: 24, // Reduced font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Time options in a 2x2 grid on the right - previous size
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35, // Smaller than the clock
                              child: GridView.count(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                childAspectRatio: 1.8, // Back to previous ratio
                                mainAxisSpacing: 8, // Previous spacing
                                crossAxisSpacing: 8, // Previous spacing
                                children: [
                                  _buildTimeOption("07.00", isHighlighted: _selectedTime.hour == 7 && _selectedTime.minute == 0),
                                  _buildTimeOption("09.00", isHighlighted: _selectedTime.hour == 9 && _selectedTime.minute == 0),
                                  _buildTimeOption("11.00", isHighlighted: _selectedTime.hour == 11 && _selectedTime.minute == 0),
                                  _buildTimeOption("17.00", isHighlighted: _selectedTime.hour == 17 && _selectedTime.minute == 0),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Date Selection
                        Text(
                          "Pilih tanggal mulai pemilahan sampah",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        // Calendar header with monthly/weekly toggle
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
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
                                          ? '${_getMonthName(currentMonth.month)} ${currentMonth.year}'
                                          : '${_getMonthName(selectedDate.month)} ${selectedDate.year}',
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
                        
                        // Calendar container with white background
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                              // Day names row
                              SizedBox(
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: List.generate(7, (index) {
                                    return Expanded(
                                      child: Center(
                                        child: Text(
                                          _daysOfWeek[index],
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
                              
                              // Calendar grid - dynamically switch between monthly and weekly
                              _currentView == CalendarView.monthly 
                                ? _buildMonthlyView() 
                                : _buildWeeklyView(),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Create Schedule Button
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _createSchedule,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Buat Jadwal",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Bottom wave background
              Image.asset(
                'assets/icons/plan_typebg.png',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ],
      ),
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
        bool isSelected = date.day == selectedDate.day && 
                         date.month == selectedDate.month && 
                         date.year == selectedDate.year;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFF0026FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSelected
                    ? Colors.white
                    : isCurrentMonth 
                      ? Color(0xFF084BC4) 
                      : Color(0xFF212729).withOpacity(0.5),
                ),
              ),
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
        bool isSelected = date.day == selectedDate.day && 
                         date.month == selectedDate.month && 
                         date.year == selectedDate.year;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFF0026FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSelected
                    ? Colors.white
                    : isCurrentMonth 
                      ? Color(0xFF084BC4) 
                      : Color(0xFF212729).withOpacity(0.5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Build time option widget
  Widget _buildTimeOption(String time, {bool isHighlighted = false}) {
    return InkWell(
      onTap: () {
        final parts = time.split('.');
        setState(() {
          _selectedTime = TimeOfDay(
            hour: int.parse(parts[0]),
            minute: int.parse(parts[1]),
          );
        });
      },
      child: Container(
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isHighlighted ? Colors.blue[800] : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: isHighlighted ? null : Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 12,
            color: isHighlighted ? Colors.white : Colors.black87,
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Helper method to get month name
  String _getMonthName(int monthNumber) {
    return [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ][monthNumber - 1];
  }

  // Method to handle schedule creation
  void _createSchedule() {
    // Create schedule logic here
    final formattedDate = "${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}";
    final formattedTime = "${_selectedTime.hour.toString().padLeft(2, '0')}.${_selectedTime.minute.toString().padLeft(2, '0')}";
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Jadwal Pemilahan Sampah berhasil dibuat untuk $formattedDate pukul $formattedTime'),
        backgroundColor: Colors.blue[800],
      ),
    );
  }
  
  // Scroll controller for tracking scroll position
  late ScrollController _scrollController;
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

// Calendar view enum
enum CalendarView {
  monthly,
  weekly
}