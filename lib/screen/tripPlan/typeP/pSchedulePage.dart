import 'package:flutter/material.dart';

class PSchedulePage extends StatefulWidget {
  const PSchedulePage({super.key});

  @override
  State<PSchedulePage> createState() => _PSchedulePageState();
}

class _PSchedulePageState extends State<PSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5월 도쿄 여행방'),
      ),

    );
  }
}
