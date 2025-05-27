import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BackFloatingButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;

  const BackFloatingButton({
    super.key,
    this.backgroundColor = AppColors.primary,
    this.icon = Icons.arrow_back,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: backgroundColor,
      onPressed: () => Navigator.pop(context),
      child: Icon(icon, color: iconColor),
    );
  }
}
