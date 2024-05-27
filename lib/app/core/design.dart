import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Design {
  static TextFormField campoTexto(TextEditingController t, String texto) {
    return TextFormField(
      controller: t,
      decoration: InputDecoration(
        filled: true,
        fillColor: Design.lightOrange,
        hintText: texto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static Widget botonGreen(String texto, void Function() accion) {
    return ElevatedButton(
      onPressed: () {
        accion();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Design.teal),
        // Background color
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        // Text color
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevation: MaterialStateProperty.all(8.0),
      ),
      child: Text(texto),
    );
  }

  static Widget botonRed(String texto, void Function() accion) {
    return ElevatedButton(
      onPressed: () {
        accion();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        // Background color
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        // Text color
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevation: MaterialStateProperty.all(8.0),
      ),
      child: Text(texto),
    );
  }

  static Widget campoFecha(
      BuildContext context, TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.orange[100],
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      readOnly: true,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          controller.text = formattedDate;
        }
      },
    );
  }

  static Widget campoDropdown<T>({
    required T value,
    required List<T> items,
    required void Function(T?) onChanged,
    required String hintText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<T>>((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          hint: Text(hintText, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
  static Widget campoDropdowns<T>({
    required T value,
    required List<T> items,
    required void Function(T?) onChanged,
    required String hintText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<T>>((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          hint: Text(hintText, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }

  static void showSnackBarGood(
      BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  static void showSnackBarNotGood(
      BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  static Future<void> showAlertDialog(
    BuildContext context,
    String title,
    String content,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }

  static void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void navigateAndReplace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Widget textoConIcono({
    required String texto,
    required IconData icono,
    required Color color, // Color para el texto y el ícono
    double size = 16.0, // Tamaño del texto
    double iconSize = 24.0, // Tamaño del ícono
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icono, color: color, size: iconSize),
        const SizedBox(width: 8), // Espacio entre ícono y texto
        Text(
          texto,
          style: TextStyle(
            fontSize: size,
            color: color,
          ),
        ),
      ],
    );
  }

  static Widget campoTextoNoEditable({
    required TextEditingController controller,
    required String hintText,
    Color backgroundColor = Design.paleYellow, // Color de fondo del campo
    double fontSize = 16.0, // Tamaño del texto
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: backgroundColor,
        // Color de fondo personalizable
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(10), // Padding dentro del campo
      ),
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.black, // Color del texto
      ),
      readOnly: true,
      // Hace que el campo sea solo de lectura
      enabled: false, // Deshabilita el campo
    );
  }

  static const Color brightRed = Color(0xFFFF1D44);
  static const Color paleYellow = Color(0xFFFBEBAF);
  static const Color mintGreen = Color(0xFF74BF9D);
  static const Color seaGreen = Color(0xFF56A292);
  static const Color teal = Color(0xFF1C8080);
  static Color? lightOrange = Colors.orange[100];
}
