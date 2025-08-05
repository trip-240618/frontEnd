import 'package:flutter/material.dart';

class PlanBView extends StatefulWidget {
  const PlanBView({super.key});

  @override
  State<PlanBView> createState() => _PlanBViewState();
}

class _PlanBViewState extends State<PlanBView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "PlanB",
          ),
        ],
      ),
    );
  }
}
