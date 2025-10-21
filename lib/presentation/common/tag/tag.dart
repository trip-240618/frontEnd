import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/image/round_thumbnail_image.dart';

/// id와 태그 보여주는 컴포넌트
class Tag extends StatelessWidget {
  final String label;
  final Widget _leadingWidget;
  final EdgeInsets _padding;
  final Color leadingColor;
  final bool? isActive;

  const Tag._({
    super.key,
    required this.label,
    required Widget leadingWidget,
    required EdgeInsets padding,
    this.isActive,
    required this.leadingColor,
  })  : _leadingWidget = leadingWidget,
        _padding = padding;

  factory Tag.person({
    Key? key,
    required String label,
    required Color leadingColor,
    String? imageUrl,
    bool? isActive,
  }) {
    return Tag._(
      key: key,
      label: label,
      leadingColor: leadingColor,
      padding: const EdgeInsets.all(8),
      isActive: isActive,
      leadingWidget: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.pink.shade100,
        ),
        child: RoundThumbnailImage(imageUrl: imageUrl),
      ),
    );
  }

  factory Tag.hashtag({
    Key? key,
    required String label,
    required Color leadingColor,
    bool? isActive,
  }) {
    return Tag._(
      key: key,
      label: label,
      padding: const EdgeInsets.all(10),
      leadingColor: leadingColor,
      isActive: isActive,
      leadingWidget: Builder(
        builder: (context) => Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: leadingColor,
          ),
          child: Center(
            child: Text(
              "#",
              style: context.style.caption2.copyWith(
                color: context.color.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: context.color.white,
        border: Border.all(color: isActive ?? false ? context.color.gray900 : context.color.gray200, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _leadingWidget,
          const SizedBox(width: 4),
          Text(
            label,
            style: context.style.caption1,
          ),
        ],
      ),
    );
  }
}
