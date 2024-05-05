import 'package:flutter/material.dart';

class Design{
  static TextFormField campoTexto(TextEditingController t, String texto){
    return TextFormField(
      controller: t,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.orange[100],
        hintText: texto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
  static Widget botonGreen(String texto, void Function() accion){
    return ElevatedButton(
      onPressed: () {
        accion();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Background color
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Text(texto),
    );
  }
  static Widget botonRed(String texto, void Function() accion){
    return ElevatedButton(
      onPressed: () {
        accion();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Background color
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Text(texto),
    );
  }
}