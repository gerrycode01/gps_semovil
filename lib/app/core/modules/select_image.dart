import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<FilePickerResult?> pickPDFFile() async {
  try {
    // Configura el selector para que solo acepte archivos PDF
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      // Si el usuario selecciona un archivo, puedes hacer algo con él aquí
      // Por ejemplo, obtener la ruta del archivo seleccionado:
      String? filePath = result.files.single.path;
      print("Archivo seleccionado: $filePath");
      return result;
    } else {
      // Usuario canceló la selección
      print("Selección de archivo cancelada");
      return null;
    }
  } catch (e) {
    // Manejar errores si algo va mal
    print("Error al seleccionar el archivo: $e");
    return null;
  }
}
