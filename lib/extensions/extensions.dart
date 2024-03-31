import 'package:image_picker/image_picker.dart';

extension GetImageMimeType on XFile {
  String getMimeTypeFromExtension() {
    final extension = path.split('.').last;
    switch (extension) {
      case 'jpg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      case 'heic':
        return 'image/heic';
      case 'heif':
        return 'image/heif';

      default:
        return 'application/octet-stream'; // Unknown type
    }
  }
}
