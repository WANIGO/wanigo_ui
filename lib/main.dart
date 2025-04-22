import 'package:flutter/material.dart';
import 'package:wanigo_part/essentials/app_colors.dart';
import 'package:wanigo_part/widgets/calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: TColors.appPrimaryColor,
        scaffoldBackgroundColor: TColors.backgroundWhite,
        appBarTheme: AppBarTheme(
          backgroundColor: TColors.backgroundWhite,
          elevation: 0,
          iconTheme: IconThemeData(color: TColors.textPrimary),
        ),
      ),
      home: const CustomCalendar(),
    );
  }
}