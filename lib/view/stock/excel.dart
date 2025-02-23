import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/file_picker_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ExcelScreen extends StatelessWidget {
  const ExcelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text("Import From Excel"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 20, 20, 20),
        child: Column(
          children: [
            CustomButton(
              width: 80,
              height: 45,
              buttonColor: blackColor,
              textColor: whiteColor,
              text: "Import",
              onTap: () async {
                await FilePickerHelper.pickFile(fileType: FileType.custom, allowedExtensions: ["xlsx"]);
              },
            )
          ],
        ),
      ),
    );
  }
}
