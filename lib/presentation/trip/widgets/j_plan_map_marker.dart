import 'package:flutter/material.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/global/global_context.dart';

class JPlanMapMarker extends StatelessWidget {
  final int index;

  const JPlanMapMarker({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final context = GlobalContext.navigatorKey.currentContext;
    final size = 35.0;
    return SizedBox(
      width: size,
      height: 60,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context?.color.blue,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$index",
                  style: context?.style.body2Normal.copyWith(
                    fontSize: 20,
                    color: context.color.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SvgIcon(
                assetPath: IconConstants.planMarker,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
