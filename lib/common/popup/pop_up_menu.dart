import 'package:flutter/material.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class MultiPopUpMenu extends StatelessWidget {
  final List<PopupMenuAction> items;
  final String icon;
  final Color? backgroundColor;

  const MultiPopUpMenu({
    super.key,
    required this.items,
    required this.icon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: DividerThemeData(
          color: context.color.gray200,
        ),
      ),
      child: PopupMenuButton<int>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        offset: const Offset(-20, 40),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(maxWidth: 125),
        menuPadding: EdgeInsets.zero,
        shadowColor: context.color.black.withValues(alpha: 0.4),
        icon: SvgIcon(assetPath: icon),
        color: backgroundColor ?? context.color.gray50,
        itemBuilder: (_) => _buildMenuItems(context),
      ),
    );
  }

  List<PopupMenuEntry<int>> _buildMenuItems(BuildContext context) {
    final List<PopupMenuEntry<int>> menuItems = [];

    for (int i = 0; i < items.length; i++) {
      final action = items[i];
      menuItems.add(_buildMenuItem(context, i, action));

      if (i != items.length - 1) menuItems.add(_buildDivider());
    }

    return menuItems;
  }

  PopupMenuItem<int> _buildMenuItem(
    BuildContext context,
    int index,
    PopupMenuAction action,
  ) {
    return PopupMenuItem<int>(
      padding: EdgeInsets.zero,
      value: index,
      onTap: action.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgIcon(
              assetPath: action.iconPath,
              color: context.color.gray600,
            ),
            const SizedBox(width: 10),
            Text(
              action.title,
              style: context.style.caption1,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuDivider _buildDivider() => PopupMenuDivider(height: 1);
}

class PopupMenuAction {
  final String title;
  final VoidCallback onTap;
  final String iconPath;

  PopupMenuAction({
    required this.title,
    required this.onTap,
    required this.iconPath,
  });
}
