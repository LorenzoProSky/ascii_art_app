import 'package:image_picker/image_picker.dart';
import 'notifiers/image_path_cache.dart';

class ImageSelector {
  static void selectImage(ImagePathCache cache, bool needCamera) async {
    final picker = ImagePicker();
    final XFile? selectedFile;

    if (needCamera) {
      selectedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 1000,
          maxHeight: 1000,
          imageQuality: 50,
          requestFullMetadata: false);
    } else {
      selectedFile = await picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 1000,
          maxHeight: 1000,
          imageQuality: 50,
          requestFullMetadata: false);
    }

    final path = selectedFile!.path;
    cache.imagePath = path;
  }
}
