import 'package:flutter/material.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class ScrapListView extends StatefulWidget {
  const ScrapListView({super.key});

  @override
  State<ScrapListView> createState() => _ScrapListViewState();
}

class _ScrapListViewState extends State<ScrapListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.gray50,
      body: Column(
        children: [
          Text('scrap'),
        ],
      ),
    );
  }
}
