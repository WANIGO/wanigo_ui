import 'package:flutter/material.dart';
import 'src/core/theme.dart';
import 'src/widgets/global_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wanigo UI',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GlobalAppBar(),
      body: Center(
        child: Text(
          'test',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
