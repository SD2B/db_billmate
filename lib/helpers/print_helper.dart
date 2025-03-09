import 'package:db_billmate/common_widgets/custom_dropdown.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

final printerProvider = StateProvider<Printer>((ref) => const Printer(url: ""));

class PrintHelper {
// Define common text styles
  static final headerText = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10);
  static final labelText = pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 7);
  static final amountText = pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 10);
  static final impAmountText = pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 11);
  static final impAmountTextBold = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11);
  static final valueText = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7);
  static final quoteText = pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 9);

  static Future<void> printInvoice(BuildContext context, WidgetRef ref, BillModel model) async {
    Printer selectedPrinter = ref.watch(printerProvider.notifier).state;
    if (selectedPrinter == const Printer(url: "")) {
      printerPop(context, ref);
      return;
    }

    final doc = pw.Document();
    final ByteData imageData = await rootBundle.load('assets/image/dblogo.jpg');
    // final ByteData quoteImage = await rootBundle.load('asset/quote.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    // final Uint8List quoteImageBytes = quoteImage.buffer.asUint8List();

    // Add content to the PDF document
    doc.addPage(
      pw.Page(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.roll80, // 80mm thermal printer format
        build: (pw.Context context) {
          return pw.SizedBox(
              width: 200,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Container(width: 30, height: 30, decoration: pw.BoxDecoration(shape: pw.BoxShape.circle, image: pw.DecorationImage(image: pw.MemoryImage(imageBytes), fit: pw.BoxFit.cover))),
                      pw.SizedBox(width: 10),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Das Brothers Stores', style: headerText),
                          pw.Text('+91 96458 89956', style: amountText),
                        ],
                      ),
                      pw.Spacer(),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(DateFormat("dd/MM/yyyy").format(model.dateTime ?? DateTime.now()), style: valueText),
                          pw.Text(DateFormat("hh:mm a").format(model.dateTime ?? DateTime.now()), style: valueText),
                          pw.Text(DateFormat("EEEE").format(model.dateTime ?? DateTime.now()), style: valueText),
                        ],
                      ),
                    ],
                  ),
                  if (model.customerName?.isNotEmpty == true) ...[
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Container(
                          width: 5, // Set width
                          height: 5, // Set height
                          margin: const pw.EdgeInsets.only(right: 5),
                          decoration: const pw.BoxDecoration(
                            shape: pw.BoxShape.circle,
                            color: PdfColors.black, // Set background color to black
                          ),
                        ),
                        pw.Text('Customer name: ', style: amountText),
                        pw.Text('${model.customerName}', style: amountText),
                      ],
                    ),
                  ],
                  pw.Divider(thickness: .5),
                  // pw.SizedBox(height: 10),
                  for (int i = 0; i < (model.items?.length ?? 0); i++)
                    pw.Row(
                      children: [
                        pw.Text("${i + 1}", style: valueText),
                        pw.SizedBox(width: 5),
                        pw.SizedBox(
                          width: 70,
                          child: pw.Text(model.items![i].name.toString(), style: amountText),
                        ),
                        pw.Spacer(),
                        // pw.SizedBox(width: 5),
                        pw.SizedBox(
                          width: 30,
                          child: pw.Text(model.items![i].salePrice.toString(), textAlign: pw.TextAlign.end, style: amountText),
                        ),
                        pw.SizedBox(width: 5),
                        pw.SizedBox(
                          width: 40,
                          child: pw.Text("${model.items![i].quantity} ${model.items![i].unit}", textAlign: pw.TextAlign.end, style: amountText),
                        ),
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text((double.parse(model.items![i].billPrice ?? "0.00").toStringAsFixed(2)).toString(), textAlign: pw.TextAlign.end, style: amountText),
                        ),
                      ],
                    ),

                  pw.Divider(thickness: .5),

                  // // Totals
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total:', style: impAmountText),
                      pw.Text(double.parse(model.total ?? "0.00").toStringAsFixed(2), style: impAmountText),
                    ],
                  ),

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Old balance:', style: impAmountTextBold),
                      pw.Text(double.parse(model.ob ?? "0.00").toStringAsFixed(2), style: impAmountTextBold),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Grand total:', style: impAmountText),
                      pw.Text(double.parse(model.grandTotal ?? "0.00").toStringAsFixed(2), style: impAmountText),
                    ],
                  ),

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Received:', style: impAmountText),
                      pw.Text(double.parse(model.received).toStringAsFixed(2), style: impAmountText),
                    ],
                  ),
                  if ((double.tryParse(model.discount) ?? 0) != 0)
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Discount:', style: impAmountText),
                        pw.Text(double.parse(model.discount).toStringAsFixed(2), style: impAmountText),
                      ],
                    ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Balance:', style: impAmountTextBold),
                      pw.Text(double.parse(model.currentBalance ?? "0.00").toStringAsFixed(2), style: impAmountTextBold),
                    ],
                  ),
                  pw.SizedBox(height: 10),

                  pw.SizedBox(height: 10),
                  pw.Divider(thickness: .000000000000000000000000000000000000000000000001),
                ],
              ));
        },
      ),
    );

    try {
      // Print the document using the selected printer
      await Printing.directPrintPdf(
        printer: selectedPrinter,
        onLayout: (format) async => doc.save(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Printing failed: $e')),
      );
    }
  }

  static Future<dynamic> printerPop(BuildContext context, WidgetRef ref) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: whiteColor,
              title: Text("Select a printer"),
              content: SizedBox(
                height: 70,
                width: 200,
                child: SearchableDropdown<Printer>(
                  height: 50,
                  width: 180,
                  hint: "Select printer",
                  initialValue: ref.read(printerProvider.notifier).state != const Printer(url: "") ? ref.read(printerProvider.notifier).state : null,
                  itemAsString: (p0) => p0.name,
                  asyncValues: () async {
                    List<Printer> printerList = await Printing.listPrinters();
                    printerList = printerList.map((printer) {
                      return Printer(name: printer.name, url: printer.url);
                    }).toList();
                    return printerList;
                  },
                  onChanged: (Printer? newPrinter) {
                    if (newPrinter != null) {
                      ref.read(printerProvider.notifier).state = newPrinter;
                      // selectedPrinter = newPrinter;
                    }
                  },
                ),
              ),
            ));
  }
}
