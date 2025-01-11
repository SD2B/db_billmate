import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:flutter/material.dart';

class ScaffoldBody extends StatelessWidget {
  const ScaffoldBody({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: context.height() - 120,
            decoration: BoxDecoration(
              // color: greyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(20),
            child: child,
          ),
        ),
      ],
    );
  }
}
