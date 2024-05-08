import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_styles.dart';
import '../../models/need_model.dart';

class NeedTile extends StatefulWidget {
  final Function(bool) setValue;
  final NeedModel need;

  const NeedTile({
    super.key,
    required this.need,
    required this.setValue,
  });

  @override
  State<NeedTile> createState() => _NeedTileState();
}

class _NeedTileState extends State<NeedTile> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.need.blocked,
      child: Opacity(
        opacity: widget.need.blocked ? 0.5 : 1.0,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          fillColor: MaterialStateProperty.all<Color>(
            widget.need.value || widget.need.blocked ? AppColors.primary.withOpacity(0.5) : AppColors.background,
          ),
          checkColor: Colors.black,
          side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 1.5, color: Colors.black)),
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            widget.need.name,
            style: AppStyles.regular(Sizes.s16).copyWith(
              decoration: widget.need.blocked ? TextDecoration.lineThrough : null,
            ),
          ),
          value: widget.need.blocked ? true : widget.need.value,
          onChanged: (value) => widget.setValue(value!),
        ),
      ),
    );
  }
}
