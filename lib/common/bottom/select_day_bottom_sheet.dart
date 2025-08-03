import 'package:flutter/material.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/extension/date_extension.dart';

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
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 40,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              color: context.color.neutral300,
            ),
          ),
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
