import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/screens/%20formalities/information.dart';

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
        title: const Text('Opciones', style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
      ),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(50),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                  label: 'Primera vez',
                  icon: Icons.fiber_new,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Information(mode: 0)));
                  },
              ),
              const SizedBox(height: 20),
              CustomButton(
                  label: 'Renovación',
                  icon: Icons.refresh,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Information(mode: 1)));
                  }),
              const SizedBox(height: 20),
              CustomButton(
                  label: 'Extraviado',
                  icon: Icons.error_outline,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Information(mode: 2)));
                  }),
            ],
          ),
        ],
      )),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Hace que el botón tenga el ancho máximo
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 30), // Aumenta el tamaño del ícono
        label: Text(label),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          // Color de texto e ícono
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // Aumenta el tamaño del texto
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // Aumenta el relleno para un botón más grande
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Bordes redondeados
          ),
        ),
      ),
    );
  }
}
