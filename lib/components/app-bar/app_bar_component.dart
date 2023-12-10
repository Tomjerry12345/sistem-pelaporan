import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/button/badge_icon_button.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';

enum TypeLeftWidget {
  defaultWidget,
  badgeWidget,
}

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icLeft;
  final IconData? icRight;
  final TypeLeftWidget typeLeftWidget;
  final Function()? leftOnPressed;
  final Function()? rightOnPressed;
  final List<Widget>? tab;
  final Color? bg;
  final Color fg;
  final double sizeTitle;
  final String textBadge;
  final int? maxLinesTitle;
  final double height;

  const AppBarComponent(
      {super.key,
      this.title = "",
      this.icLeft,
      this.icRight = Icons.logout,
      this.typeLeftWidget = TypeLeftWidget.defaultWidget,
      this.leftOnPressed,
      this.rightOnPressed,
      this.tab,
      this.bg,
      this.fg = Colors.black,
      this.sizeTitle = 24,
      this.textBadge = "0",
      this.maxLinesTitle,
      this.height = 150});

  Widget titleC() {
    return TextComponent(
      title,
      color: fg,
      size: sizeTitle,
      maxLines: maxLinesTitle,
    );
  }

  Widget leftIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: IconButton(
        icon: Icon(
          icLeft,
          size: 32,
          color: fg,
        ),
        onPressed: leftOnPressed,
      ),
    );
  }

  Widget rightIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        icon: Icon(
          icRight,
          size: 32,
          color: fg,
        ),
        onPressed: rightOnPressed,
      ),
    );
  }

  Widget badgeIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 8),
      child: BadgeIconButton(
        icon: Icons.notifications,
        badgeText: textBadge,
        onPressed: leftOnPressed,
        iconSize: 32,
        // badgePosition: BadgePosition.bottomLeft,
      ),
    );
  }

  Widget? leadingWidget() {
    if (typeLeftWidget == TypeLeftWidget.defaultWidget) {
      return leftIcon();
    } else if (typeLeftWidget == TypeLeftWidget.badgeWidget) {
      return badgeIcon();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleC(),
      centerTitle: false,
      toolbarHeight: height,
      backgroundColor: bg,
      leading: leadingWidget(),
      actions: [rightIcon()],
      bottom: (tab != null && tab!.isNotEmpty)
          ? TabBar(
              tabs: tab ?? [],
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
