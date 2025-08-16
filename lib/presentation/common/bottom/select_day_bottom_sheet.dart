import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/presentation/common/bottom/base_bottom_sheet.dart';

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
  late final List<DateTime> dateList;
  late DateTime? selectedDateInternal;

  @override
  void initState() {
    super.initState();
    final start = widget.startDate;
    final end = widget.endDate;

    dateList = List.generate(
      end.difference(start).inDays + 1,
      (index) => start.add(Duration(days: index)),
    );

    selectedDateInternal = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 34),
          Text(
            widget.title,
            style: context.style.headline3.copyWith(
              color: context.color.gray800,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: dateList.length,
              itemBuilder: (context, index) {
                final date = dateList[index];

                return RadioListTile<DateTime>(
                  title: Text(
                    date.formatDateWithWeekdayKo,
                    style: context.style.body1Normal,
                  ),
                  value: date,
                  groupValue: selectedDateInternal,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  fillColor: WidgetStateProperty.resolveWith(
                    (states) => !states.contains(WidgetState.selected)
                        ? context.color.gray400.withValues(alpha: .32)
                        : context.color.gray900,
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedDateInternal = value;
                      });
                      widget.onChanged(value);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
