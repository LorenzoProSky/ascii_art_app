import 'package:image_picker/image_picker.dart';
import 'image_path_cache.dart';

class ImageSelector {
  static void selectImage(ImagePathCache cache, bool needCamera) async {
    final picker = ImagePicker();
    final XFile? selectedFile;

    if (needCamera) {
      selectedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      selectedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    final path = selectedFile!.path;
    cache.imagePath = path;
  }
}
