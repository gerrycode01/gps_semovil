import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

//File? image_to_upload;
//onPressed: () async {
//final XFile? imagen = await getImage();
//setState((){image_to_upload = File(imagen!.path)})
//},
