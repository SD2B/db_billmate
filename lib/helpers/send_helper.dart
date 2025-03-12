import 'dart:io';

import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SendHelper {
  static Future<void> shareDatabase() async {
    try {
      // Get the database path
      final dbPath = await getDatabasesPath();
      final dbFile = File(join(dbPath, 'local_storage.db'));

      // Check if the database file exists
      if (await dbFile.exists()) {
        // Share the database file via WhatsApp
        await Share.shareXFiles([XFile(dbFile.path)], text: 'Here is the database file.');
      } else {
        qp("Database file does not exist.");
      }
    } catch (e) {
      qp('Error sharing database: $e');
    }
  }



  static Future<void> shareImage(Uint8List imageBytes) async {
    try {
      // Get the temporary directory
      final tempDir = await getTemporaryDirectory();
      final file = File(join(tempDir.path, 'shared_image.png'));
      await Share.shareXFiles([XFile(file.path)], text: 'Here is the image.');
    } catch (e) {
      qp('Error sharing image: $e');
    }
  }

  static const platform = MethodChannel('whatsapp_share');

  static Future<void> shareImageToWhatsAppWindows(Uint8List imageBytes, String phoneNumber) async {
    try {
      // Save image to a temporary file
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}\\shared_image.png';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);

      // Run WhatsApp command
      Process.run(
        'cmd',
        ['/c', 'start', 'whatsapp.exe', '--send-to', phoneNumber, '--attach', filePath],
      ).then((result) {
        if (result.exitCode != 0) {
          qp('Error sharing image: ${result.stderr}');
        }
      });
    } catch (e) {
      qp('Error: $e');
    }
  }

  static Future<void> openWhatsAppAndSendImage(String phoneNumber, String imagePath) async {
    try {
      // Step 1: Open WhatsApp Chat with the given phone number
      String url = 'whatsapp://send?phone=$phoneNumber';
      Process.run('cmd', ['/c', 'start', url], runInShell: true);

      // Step 2: Copy Image to Clipboard using PowerShell
      await Process.run('powershell', ['-Command', "\$img = Get-Item '$imagePath'; Set-Clipboard -Path \$img.FullName"]);

      // Step 3: Wait for WhatsApp to open
      await Future.delayed(Duration(seconds: 3));

      // Step 4: Paste and send the image in the chat
      await Process.run('powershell', [
        '-Command',
        "\$wshell = New-Object -ComObject WScript.Shell; "
            "\$wshell.AppActivate('WhatsApp'); "
            "\$wshell.SendKeys('^v'); "
            "Start-Sleep -Seconds 1; "
            "\$wshell.SendKeys('{ENTER}');"
      ]);
    } catch (e) {
      qp('Error: $e');
    }
  }
}
