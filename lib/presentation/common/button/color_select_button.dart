import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/enum/trip_color.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

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
      height: 28,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: TripColor.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final tripColor = TripColor.values[index];
          final isSelected = tripColor == selectedColor;

          return BaseButton(
            borderRadius: 4,
            onTap: () => onSelected(tripColor),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tripColor.color,
                border: isSelected
                    ? Border.all(
                        color: context.color.gray900,
                        width: 2,
                      )
                    : null,
              ),
              child: isSelected ? SvgIcon(assetPath: IconConstants.check) : null,
            ),
          );
        },
      ),
    );
  }
}
