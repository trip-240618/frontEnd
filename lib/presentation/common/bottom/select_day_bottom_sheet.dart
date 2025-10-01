import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/bottom/base_bottom_sheet.dart';
import 'package:tripStory/presentation/common/selected_day_content.dart';

class SelectDayBottomSheet extends StatefulWidget {
  final String title;
  final bool edit;
  final DateTime startDate;
  final DateTime endDate;

  final DateTime? selectedDate;
  final void Function(DateTime selectedDate) onChanged;

  const SelectDayBottomSheet({
    super.key,
    required this.title,
    required this.edit,
    required this.startDate,
    required this.endDate,
    required this.selectedDate,
    required this.onChanged,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required bool edit,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime? selectedDate,
    required void Function(DateTime selectedDate) onChanged,
  }) {
    return BaseBottomSheet.show(
      context,
      SelectDayBottomSheet(
        title: title,
        edit: edit,
        startDate: startDate,
        endDate: endDate,
        selectedDate: selectedDate,
        onChanged: onChanged,
      ),
      heightRatio: 0.5,
    );
  }

  @override
  State<SelectDayBottomSheet> createState() => _SelectDayBottomSheetState();
}

class _SelectDayBottomSheetState extends State<SelectDayBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: SelectedDayContent(
        title: widget.title,
        startDate: widget.startDate,
        endDate: widget.endDate,
        selectedDate: widget.selectedDate,
        onChanged: widget.onChanged,
      ),
    );
  }
}
