import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../config/app_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback onTap;
  final Color color;

  const AppButton({
    super.key,
    required this.text,
    required this.enabled,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: enabled ? color : AppColors.deactivated,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
        onPressed: enabled ? onTap : () {},
        child: Text(text, style: AppStyles.semiBold(Sizes.s14, Colors.white)),
      ),
    );
  }
}
