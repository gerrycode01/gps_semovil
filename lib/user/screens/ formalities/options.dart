import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones'),
        backgroundColor: Colors.blue.shade400,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(50),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomButton(label: 'Primera vez', icon: Icons.fiber_new, onPressed: () {}),
                const SizedBox(height: 20),
                CustomButton(label: 'Renovación', icon: Icons.refresh, onPressed: () {}),
                const SizedBox(height: 20),
                CustomButton(label: 'Extraviado', icon: Icons.error_outline, onPressed: () {}),
              ],
            ),
          ],
        )
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Hace que el botón tenga el ancho máximo
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 30), // Aumenta el tamaño del ícono
        label: Text(label),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, // Color de texto e ícono
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Aumenta el tamaño del texto
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Aumenta el relleno para un botón más grande
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Bordes redondeados
          ),
        ),
      ),
    );
  }
}
