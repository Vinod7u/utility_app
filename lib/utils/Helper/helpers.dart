import 'dart:io';

import 'package:file_picker/file_picker.dart';

class Helpers{

  Future<void> pickFile() async {
    // Open file manager
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Get the selected file
      File file = File(result.files.single.path!);
      print('Selected file path: ${file.path}');
    } else {
      // User canceled the picker
      print('No file selected');
    }
  }
}