import 'dart:io';

import 'package:db_billmate/common_widgets/sd_toast.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/view/stock/excel.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';

class ExcelHelper {
//importing data from excel
  static Future<List<dynamic>> importExcel({String excelType = ExcelType.items}) async {
    try {
      List<ItemModel> items = [];
      List<EndUserModel> customers = [];

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
          List<String> headers = sheet.rows.first.map((cell) => cell?.value.toString() ?? "").toList();

          // Read data starting from row 1
          for (int rowIndex = 1; rowIndex < sheet.rows.length; rowIndex++) {
            List<Data?> row = sheet.rows[rowIndex];

            // Convert row data into a Map<String, dynamic>
            Map<String, dynamic> rowData = {};
            for (int i = 0; i < headers.length; i++) {
              rowData[headers[i]] = row[i]?.value?.toString();
            }

            // Convert the map into an ItemModel
            try {
              if (excelType == ExcelType.items) {
                if (rowData["id"] != null) {
                  rowData["id"] = int.tryParse(rowData["id"].toString()) ?? 0;
                }
                if (rowData["bill_id"] != null) {
                  rowData["bill_id"] = int.tryParse(rowData["bill_id"].toString()) ?? 0;
                }
                items.add(ItemModel.fromJson(rowData));
              } else {
                customers.add(EndUserModel.fromJson(rowData));
              }
            } catch (e, stackTrace) {
              qp("Error parsing row $rowIndex: $e");
              qp("Stack trace: $stackTrace");
            }
          }
          break; // Stop after reading the first sheet
        }
      }
      final data = excelType == ExcelType.items ? items : customers;
      return data;
    } catch (e) {
      qp("Error importing Excel: $e");
      SDToast.errorToast(title: "Error importing Excel", description: "$e");
      return [];
    }
  }

  /// Exporting data to excel
  static Future<void> exportToExcel(List<ItemModel> data) async {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];
// Extract headers dynamically from the model
    if (data.isNotEmpty) {
      List<String> headers = data.first.toJson().keys.toList();
      sheet.appendRow(headers.map((header) => TextCellValue(header)).toList());
    }

    // Add data
    for (var item in data) {
      Map<String, dynamic> json = item.toJson();
      sheet.appendRow(json.values.map((value) => TextCellValue(value?.toString() ?? '')).toList());
    }
    // Open Save File dialog
    const String fileExtension = 'xlsx';
    final FileSaveLocation? saveLocation = await getSaveLocation(suggestedName: "items.$fileExtension");
    final String? path = saveLocation?.path;

    if (saveLocation == null) {
      qp("File save canceled.");
      SDToast.errorToast(description: "File save canceled.");
      return; // User canceled file selection
    } else {
      File file = File(path ?? "");
      file.writeAsBytesSync(excel.encode()!);
      qp("Excel file saved at: $path");
      SDToast.successToast(description: "Excel file saved at: $path");
    }

    // Save file
  }
}
