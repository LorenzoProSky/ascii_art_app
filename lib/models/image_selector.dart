import 'package:image_picker/image_picker.dart';
import 'notifiers/image_path_cache.dart';

class ImageSelector {
  static void selectImage(ImagePathCache cache, bool needCamera) async {
    final picker = ImagePicker();
    final XFile? selectedFile;

    if (needCamera) {
      selectedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 800,
          maxHeight: 800,
          imageQuality: 75,
          requestFullMetadata: false);
    } else {
      selectedFile = await picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 800,
          maxHeight: 800,
          imageQuality: 75,
          requestFullMetadata: false);
    }

    final path = selectedFile!.path;
    cache.imagePath = path;
  }
}
