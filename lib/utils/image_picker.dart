import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage() async {
  try {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      maxWidth: 1280,
      maxHeight: 1280,
      imageQuality: 80,
      source: ImageSource.gallery,
      requestFullMetadata: true,
    );

    return pickedImage;
  } catch (e) {
    throw Exception(e.toString());
  }
}
