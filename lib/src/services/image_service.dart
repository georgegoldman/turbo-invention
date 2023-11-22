import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:technical_assessment/utils/filename_gen.dart';

class ImageService {
  Future<File?> pickAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // check if the file was picked
    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = generateRandomFileName();
      final savedImage =
          await File(pickedFile.path).copy('${appDir.path}/$fileName');
      return savedImage;
    }
    return null;
  }
}
