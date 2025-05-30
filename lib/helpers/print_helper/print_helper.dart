import 'package:db_billmate/common_widgets/custom_dropdown.dart';
import 'package:db_billmate/common_widgets/sd_toast.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
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
  static final itemHeader = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10);
  static final itemText = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9);
  static final amountText = pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 10);
  static final impAmountText = pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 11);
  static final trnxImpAmountText = pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 20);
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
                        // pw.Container(
                        //   width: 5, // Set width
                        //   height: 5, // Set height
                        //   margin: const pw.EdgeInsets.only(right: 5),
                        //   decoration: const pw.BoxDecoration(
                        //     shape: pw.BoxShape.circle,
                        //     color: PdfColors.black, // Set background color to black
                        //   ),
                        // ),
                        pw.Text('Invoice Number: ', style: impAmountTextBold),
                        pw.Text('${model.invoiceNumber}', style: impAmountTextBold),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        // pw.Container(
                        //   width: 5, // Set width
                        //   height: 5, // Set height
                        //   margin: const pw.EdgeInsets.only(right: 5),
                        //   decoration: const pw.BoxDecoration(
                        //     shape: pw.BoxShape.circle,
                        //     color: PdfColors.black, // Set background color to black
                        //   ),
                        // ),
                        pw.Text('Customer: ', style: amountText),
                        pw.Text('${model.customerName}', style: impAmountTextBold),
                      ],
                    ),
                  ],
                  pw.Divider(thickness: .5),
                  // pw.SizedBox(height: 10),
                  pw.Row(
                    children: [
                      pw.SizedBox(
                        width: 100,
                        child: pw.Text("Item", style: itemHeader),
                      ),
                      pw.SizedBox(
                        width: 20,
                        child: pw.Text("Qty", textAlign: pw.TextAlign.end, style: itemHeader),
                      ),
                      pw.SizedBox(width: 15),
                      pw.SizedBox(
                        width: 25,
                        child: pw.Text("Rate", textAlign: pw.TextAlign.end, style: itemHeader),
                      ),
                      pw.SizedBox(
                        width: 40,
                        child: pw.Text("Total", textAlign: pw.TextAlign.end, style: itemHeader),
                      ),
                    ],
                  ),
                  pw.Divider(thickness: .5),
                  for (int i = 0; i < (model.items?.length ?? 0); i++)
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                          width: 10,
                          child: pw.Text("${i + 1}", style: valueText),
                          // child: pw.Text("00", style: valueText),
                        ),
                        pw.SizedBox(width: 1),
                        pw.SizedBox(
                          width: 70,
                          child: pw.Text(model.items![i].name.toString(), style: itemText),
                        ),
                        pw.SizedBox(
                          width: 40,
                          child: pw.Text("${model.items![i].quantity} ${model.items![i].unit}", textAlign: pw.TextAlign.end, style: itemText),
                        ),
                        pw.SizedBox(width: 3),
                        pw.SizedBox(
                          width: 30,
                          child: pw.Text(model.items![i].salePrice.toString(), textAlign: pw.TextAlign.end, style: itemText),
                        ),
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text((double.parse(model.items![i].billPrice ?? "0.00").toStringAsFixed(2)).toString(), textAlign: pw.TextAlign.end, style: itemText),
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

  static Future<void> printTransaction(BuildContext context, WidgetRef ref, TransactionModel model, String customerName) async {
    Printer selectedPrinter = ref.watch(printerProvider.notifier).state;
    if (selectedPrinter == const Printer(url: "")) {
      printerPop(context, ref);
      return;
    }

    final doc = pw.Document();
    final ByteData imageData = await rootBundle.load('assets/image/dblogo.jpg');
    final Uint8List imageBytes = imageData.buffer.asUint8List();

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

                  pw.SizedBox(height: 10),
                  if (model.transactionType == TransactionType.sale)
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('${model.description}', style: impAmountTextBold),
                      ],
                    ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('Customer: ', style: amountText),
                      pw.Text(customerName, style: impAmountTextBold),
                    ],
                  ),

                  pw.Divider(thickness: .5),

                  // // Totals
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(model.toGet ? "Given" : 'Recieved:', style: impAmountText),
                          pw.Text(double.parse("${model.amount}").toStringAsFixed(2), style: trnxImpAmountText),
                        ],
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('----Thank You----', style: impAmountText),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Divider(thickness: .000000000000000000000000000000000000000000000001),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('----------------------', style: impAmountText),
                    ],
                  ),
                  pw.SizedBox(height: 10),
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
      SDToast.errorToast(title: "Error", description: "Printing failed: $e");
    }
  }

  static Future<void> printFullTransaction(BuildContext context, WidgetRef ref, List<TransactionModel> transactionList, String customerName, String currentBalance, String datePeriod) async {
    Printer selectedPrinter = ref.watch(printerProvider.notifier).state;
    if (selectedPrinter == const Printer(url: "")) {
      printerPop(context, ref);
      return;
    }

    final doc = pw.Document();
    final ByteData imageData = await rootBundle.load('assets/image/dblogo.jpg');
    final Uint8List imageBytes = imageData.buffer.asUint8List();

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
                          pw.Text(DateFormat("dd/MM/yyyy").format(DateTime.now()), style: valueText),
                          pw.Text(DateFormat("hh:mm a").format(DateTime.now()), style: valueText),
                          pw.Text(DateFormat("EEEE").format(DateTime.now()), style: valueText),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text('Customer: ', style: amountText),
                      pw.Text(customerName, style: impAmountTextBold),
                    ],
                  ),
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Transactions between', style: amountText),
                      pw.Text(datePeriod, style: impAmountTextBold),
                    ],
                  ),
                  pw.Divider(thickness: .5),
                  for (TransactionModel model in transactionList) ...[
                    pw.Row(
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(DateFormat("dd/MM/yyyy").format(model.dateTime ?? DateTime.now()), style: valueText),
                            pw.Text(DateFormat("hh:mm a").format(model.dateTime ?? DateTime.now()), style: valueText),
                            pw.Text(DateFormat("EEEE").format(model.dateTime ?? DateTime.now()), style: valueText),
                          ],
                        ),
                        pw.SizedBox(width: 10),
                        pw.Text(model.toGet ? "Given" : 'Recieved', style: impAmountText),
                        pw.Spacer(),
                        pw.Text(model.toGet ? double.parse("${model.amount}").toStringAsFixed(2) : "-${double.parse("${model.amount}").toStringAsFixed(2)}", style: impAmountText),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                  ],
                  pw.Divider(thickness: .5),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Current Balance:', style: impAmountTextBold),
                      pw.Text(double.parse(currentBalance).toStringAsFixed(2), style: impAmountTextBold),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('----ThankYou----', style: impAmountText),
                    ],
                  ),
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
      SDToast.errorToast(title: "Error", description: "Printing failed: $e");
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
                width: 300,
                child: SearchableDropdown<Printer>(
                  height: 50,
                  width: 300,
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
                      SDToast.successToast(description: "Printer selected successfully");
                      context.pop();
                      // selectedPrinter = newPrinter;
                    }
                  },
                ),
              ),
            ));
  }
}
