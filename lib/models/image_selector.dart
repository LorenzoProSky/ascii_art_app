import 'package:image_picker/image_picker.dart';
import 'image_path_cache.dart';

class ImageSelector {
  static void selectImage(ImagePathCache cache) async {
    final picker = ImagePicker();
    final selectedFile = await picker.pickImage(source: ImageSource.gallery);

    final path = selectedFile!.path;
    cache.imagePath = path;
  }

  static void takeImage(ImagePathCache cache) async {
    final picker = ImagePicker();
    final selectedFile = await picker.pickImage(source: ImageSource.camera);

    final path = selectedFile!.path;
    cache.imagePath = path;
  }
}
