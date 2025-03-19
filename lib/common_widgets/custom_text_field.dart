import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomTextField extends HookWidget {
  final Color? fillColor;
  final double? width;
  final double? height;
  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintTextStyle;
  final String? label;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final Widget? prefix;
  final Widget? suffix;
  final double? boarderRadius;
  final int? maxLines;
  final bool firstLetterCapital;
  final bool selectAllOnFocus;
  final bool readOnly;
  final bool isAmount;

  const CustomTextField({
    super.key,
    this.fillColor,
    this.width,
    this.height,
    required this.controller,
    this.hintText = "",
    this.hintTextStyle,
    this.label,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.isPassword = false,
    this.validator,
    this.textInputType,
    this.prefix,
    this.suffix,
    this.boarderRadius,
    this.maxLines,
    this.firstLetterCapital = false,
    this.selectAllOnFocus = false,
    this.readOnly = false,
    this.isAmount = false,
  });

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);
    final errorText = useState<String?>(null);
    final effectiveFocusNode = focusNode ?? useFocusNode();

    useEffect(() {
      // Add listener to focus node to select text on focus
      void handleFocusChange() {
        if (selectAllOnFocus && effectiveFocusNode.hasFocus) {
          controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller.text.length,
          );
        }
      }

      effectiveFocusNode.addListener(handleFocusChange);
      return () => effectiveFocusNode.removeListener(handleFocusChange);
    }, [effectiveFocusNode, selectAllOnFocus]);

    return SizedBox(
      width: width,
      height: (errorText.value != null && errorText.value != "")
          ? (height ?? 50) + 20
          : (height ?? 50),
      child: TextFormField(
        readOnly: readOnly,
        textCapitalization: firstLetterCapital
            ? TextCapitalization.words
            : TextCapitalization.none,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorCode.colorList(context).customTextColor,
            ),
        maxLines: maxLines ?? 1,
        keyboardType: textInputType,
        controller: controller,
        focusNode: effectiveFocusNode,
        obscureText: isPassword ? obscureText.value : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? whiteColor,
          hintText: hintText,
          hintStyle: hintTextStyle ??
              Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffA8B1BE),
                  ),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(boarderRadius ?? 8),
            borderSide: BorderSide(
              color: ColorCode.colorList(context).borderColor!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(boarderRadius ?? 8),
            borderSide: BorderSide(
              color: ColorCode.colorList(context).primary!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(boarderRadius ?? 8),
            borderSide: BorderSide(
              color: ColorCode.colorList(context).borderColor!,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(boarderRadius ?? 8),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(boarderRadius ?? 8),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: Colors.red,
              ),
          prefixIcon: prefix,
          suffixIcon: suffix ??
              (isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        obscureText.value = !obscureText.value;
                      },
                    )
                  : null),
        ),
        textAlign: isAmount ? TextAlign.right : TextAlign.left,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        cursorColor: ColorCode.colorList(context).customTextColor,
        validator: (value) {
          final validationResult = validator?.call(value);
          errorText.value = validationResult;
          return validationResult;
        },
      ),
    );
  }
}
