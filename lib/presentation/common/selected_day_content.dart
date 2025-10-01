import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';

class SelectedDayContent extends StatefulWidget {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? selectedDate;
  final void Function(DateTime selectedDate) onChanged;

  const SelectedDayContent({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
    this.selectedDate,
    required this.onChanged,
  });

  @override
  State<SelectedDayContent> createState() => _SelectedDayContentState();
}

class _SelectedDayContentState extends State<SelectedDayContent> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 34),
        Text(
          widget.title,
          style: context.style.headline3.copyWith(
            color: context.color.gray900,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Scrollbar(
            thickness: 2,
            thumbVisibility: true,
            radius: const Radius.circular(3),
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
        ),
      ],
    );
  }
}
