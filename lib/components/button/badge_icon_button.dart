import 'package:flutter/material.dart';

class BadgeIconButton extends StatelessWidget {
  final IconData icon;
  final String badgeText;
  final VoidCallback? onPressed;
  final double iconSize;

  const BadgeIconButton({
    required this.icon,
    required this.badgeText,
    this.onPressed,
    this.iconSize = 24
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          InkWell(onTap: onPressed, child: Container(width: iconSize + 8, height: iconSize + 8, child: Icon(icon, size: iconSize))),
          if (badgeText.isNotEmpty)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Center(
                  child: Text(
                    badgeText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
