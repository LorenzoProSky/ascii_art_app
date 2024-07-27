import 'package:image_picker/image_picker.dart';
import 'notifiers/image_path_cache.dart';

class ImageSelector {
  static void selectImage(ImagePathCache cache, bool needCamera) async {
    final picker = ImagePicker(); // Image picker package
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
    // The maxWidht, maxHeight numbers are based on the following fact:
    // if the size of the starting image is too large (e.g. 1000x1000),
    // the resulting ASCII art (with sensitivity = 1) will be too large
    // when fitted into its FittedBox => ASCII text will still be correct,
    // but Flutter will not be able to display it properly.
    // The individual characters will be squished together when rendered,
    // resulting in uneven spacing between them ruining the proportions
    // of the ASCII art (visible via uneven margins and separation lines).

    final path = selectedFile!.path;
    cache.imagePath = path; // Save only the path to the cache
  }
}
