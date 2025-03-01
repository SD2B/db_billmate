import 'dart:io';

import 'package:db_billmate/models/item_model.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  static Future<FilePickerResult?> pickFile({
    required FileType fileType,
    List<String>? allowedExtensions, // Only needed for custom types
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowedExtensions: allowedExtensions, // Pass allowed extensions if needed
    );

    if (result != null) {
      // return result.files.single.path; // Return selected file path
      return result;
    }
    return null; // Return null if user cancels
  }

  static Future<List<ItemModel>> importExcel() async {
    List<ItemModel> items = [];

    // Pick an Excel file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = await file.readAsBytes();
      var excel = Excel.decodeBytes(bytes);

      // Assuming data is in the first sheet
      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];

        if (sheet == null || sheet.rows.isEmpty) {
          return [];
        }

        // Read headers from the first row
        List<String> headers = sheet.rows.first
            .map((cell) => cell?.value.toString() ?? "")
            .toList();

        // Read data starting from row 1
        for (int rowIndex = 1; rowIndex < sheet.rows.length; rowIndex++) {
          var row = sheet.rows[rowIndex];

          // Convert row data into a Map<String, dynamic>
          Map<String, dynamic> rowData = {};
          for (int i = 0; i < headers.length; i++) {
            rowData[headers[i]] = row[i]?.value?.toString();
          }

          // Convert the map into an ItemModel
          try {
            items.add(ItemModel.fromJson(rowData));
          } catch (e) {
            print("Error parsing row $rowIndex: $e");
          }
        }
        break; // Stop after reading the first sheet
      }
    }
    return items;
  }
}
