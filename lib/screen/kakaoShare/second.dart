import 'package:flutter/material.dart';

class SecondTest extends StatefulWidget {
  final String name;
  const SecondTest({super.key, required this.name});

  @override
  State<SecondTest> createState() => _SecondTestState();
}

class _SecondTestState extends State<SecondTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${widget.name}')
        ],
      ),
    );
  }
}
