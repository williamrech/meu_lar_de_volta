import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_styles.dart';
import '../../models/need_model.dart';

class NeedChip extends StatelessWidget {
  final NeedModel need;

  const NeedChip({super.key, required this.need});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      decoration: BoxDecoration(
        color: need.blocked ? AppColors.deactivated : AppColors.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        need.name,
        style: AppStyles.regular(Sizes.s10).copyWith(
          decoration: need.blocked ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
