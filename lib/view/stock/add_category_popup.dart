import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/form_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddAttributePopup extends HookConsumerWidget {
  final String title;
  final Function(String) onSave;
  const AddAttributePopup(
      {super.key, required this.title, required this.onSave});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final nameFocus = useFocusNode();
    nameFocus.requestFocus();
    return AlertDialog(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Row(
        children: [
          Text(
            "Add $title",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close_rounded)),
        ],
      ),
      content: CustomTextField(
        width: 250,
        controller: nameController,
        focusNode: nameFocus,
        hintText: "Enter name",
        inputFormatters: [CapitalizeEachWordFormatter()],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              width: 120,
              text: "Save",
              textColor: whiteColor,
              buttonColor: black54Color,
              onTap: () async {
                if (nameController.text.isNotEmpty) {
                  onSave(nameController.text);
                  context.pop();
                }
              },
            ),
            CustomButton(
              width: 120,
              text: "Save & New",
              textColor: whiteColor,
              buttonColor: ColorCode.colorList(context).primary,
              onTap: () async {
                if (nameController.text.isNotEmpty) {
                  onSave(nameController.text);
                  nameController.clear();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
