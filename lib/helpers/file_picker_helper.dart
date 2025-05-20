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

 
}
