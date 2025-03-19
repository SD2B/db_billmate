import 'dart:io';
import 'dart:typed_data';
import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/helpers/send_helper.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class InvoiceViewSharePop extends HookWidget {
  final BillModel model;
  const InvoiceViewSharePop({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    // Create the initial data state
    final data = useState(model.items);
    final datas = useState([for (int i = 0; i < 100; i++) ...?data.value]);

    // Chunk the items into groups of 20
    final chunkedData = [for (int i = 0; i < datas.value.length; i += 20) datas.value.sublist(i, i + 20 > datas.value.length ? datas.value.length : i + 20)];

    // Create a list of controllers, one for each chunk
    final controllers = useMemoized(
      () => List.generate(chunkedData.length, (index) => WidgetsToImageController()),
      [chunkedData.length],
    );

    return AlertDialog(
      backgroundColor: whiteColor,
      content: SizedBox(
        height: 600,
        child: Column(
          children: [
            // Loop through chunks and wrap them inside WidgetsToImage
            Container(
              constraints: BoxConstraints(minWidth: 300, maxWidth: context.width() - 100),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(chunkedData.length, (index) {
                    return WidgetsToImage(
                      controller: controllers[index],
                      child: Container(
                        width: 300,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: chunkedData[index].map((item) => Text(datas.value.indexOf(item).toString())).toList(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            CustomButton(
              width: 150,
              height: 45,
              buttonColor: appPrimary,
              textColor: whiteColor,
              text: "Send",
              onTap: () async {
                List<File> capturedImages = [];

                for (var controller in controllers) {
                  Uint8List? bytes = await controller.capture();
                  if (bytes != null) {
                    File file = await bytesToImageFile(bytes);
                    capturedImages.add(file);
                  }
                }

                if (capturedImages.isNotEmpty) {
                  for (var file in capturedImages) {
                    await SendHelper.openWhatsAppAndSendImage("9656595353", file.path);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
