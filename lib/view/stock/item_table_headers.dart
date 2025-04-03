import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ItemTableHeaders extends HookWidget {
  final int? flex;
  final String value;
  final Function(bool)? onTap;

  const ItemTableHeaders({super.key, this.flex, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isEditing = useState(false);
    return Expanded(
        flex: flex ?? 1,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: ColorCode.colorList(context).primary),
              ),
              if (onTap != null)
                CustomIconButton(
                  shape: BoxShape.circle,
                  icon: Icons.edit_rounded,
                  iconSize: 15,
                  buttonSize: 30,
                  buttonColor: transparentColor,
                  iconColor: appPrimary,
                  onTap: () {
                    isEditing.value = !isEditing.value;
                    onTap!(isEditing.value);
                  },
                ),
            ],
          ),
        ));
  }
}
