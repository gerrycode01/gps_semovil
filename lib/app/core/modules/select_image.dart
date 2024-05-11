import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}
/*

CircleAvatar(
radius: 50,
backgroundColor: Colors.red,
child: IconButton(
icon: const Icon(Icons.person),
iconSize: 50,
onPressed: () async {
final image = await getImage();
setState(() {
image_to_upload = File(image!.path);
});
print('IconButton presionado');
},
),
)

 */