import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';

class HeaderLabel extends StatelessWidget {
  final String header;
  final String? subHeader;
  final String? para;
  final double? headFontSize;
  final bool centerAlign;
  const HeaderLabel({super.key, required this.header, this.subHeader, this.para, this.headFontSize, this.centerAlign = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centerAlign == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(header, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: headFontSize ?? 24, fontWeight: FontWeight.w500, color: ColorCode.colorList(context).customTextColor)),
        if (subHeader != null) ...[
          const SizedBox(height: 5),
          Text(subHeader ?? "", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: ColorCode.colorList(context).labelColor)),
        ],
        if (para != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(para ?? "", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: ColorCode.colorList(context).labelColor)),
            ],
          ),
        ],
      ],
    );
  }
}

class LabelHeader extends StatelessWidget {
  final String label;
  final String header;
  final double? headFontSize;
  final bool centerAlign;
  const LabelHeader({super.key, required this.label, required this.header, this.headFontSize, this.centerAlign = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centerAlign == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: ColorCode.colorList(context).labelColor)),
        Text(header, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: headFontSize ?? 24, fontWeight: FontWeight.w500, color: appPrimary)),
      ],
    );
  }
}
