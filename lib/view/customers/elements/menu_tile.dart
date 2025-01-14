import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';

class MenuTile extends PopupMenuItem<int> {
  MenuTile({
    Key? key,
    required int value,
    required String title,
    TextStyle? textStyle,
    bool selected = false,
    bool enabled = true,
  }) : super(
          key: key,
          value: value,
          enabled: enabled,
          child: Container(
            width: 150,
            decoration: BoxDecoration(
              color: selected ? Colors.grey[300] : null,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              children: [
                Text(title, style: textStyle ?? const TextStyle(fontSize: 14)),
                Spacer(),
                if (selected) Icon(Icons.check_circle, size: 15, color: black87Color),
              ],
            ),
          ),
        );
}

