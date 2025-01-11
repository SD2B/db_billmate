import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScaffoldFooter extends StatelessWidget {
  const ScaffoldFooter({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 30,
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Text(
                  "🕧 ${DateFormat("hh:mm aaa").format(DateTime.now()).toString()}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Spacer(),
                Text(
                  "📅 ${DateFormat("EEEE, MMMM dd, yyyy").format(DateTime.now()).toString()}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
