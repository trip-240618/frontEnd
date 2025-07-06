import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripStory/core/enum/trip_color.dart';
import 'package:tripStory/util/color.dart';

class ColorSelectButton extends StatelessWidget {
  final TripColor selectedColor;
  final ValueChanged<TripColor> onSelected;

  const ColorSelectButton({
    super.key,
    required this.selectedColor,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: TripColor.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final tripColor = TripColor.values[index];
          final isSelected = tripColor == selectedColor;

          return GestureDetector(
            onTap: () => onSelected(tripColor),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tripColor.color,
                border: isSelected ? Border.all(color: gray900, width: 2) : null,
              ),
              child: isSelected
                  ? SvgPicture.asset(
                      'assets/icon/checkIcon.svg',
                      fit: BoxFit.none,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
