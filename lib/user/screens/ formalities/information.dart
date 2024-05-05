import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/screens/%20formalities/firstime.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.orange[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,  // Añade la sombra detrás de la tarjeta
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85, // Ajusta el ancho de la tarjeta
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,  // Minimiza el tamaño de la columna al contenido
              children: [
                const Text(
                  'ATENCION',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Divider(color: Colors.grey),
                const SizedBox(height: 10),
                const Text(
                  'En el estado de Nayarit, la Secretaría de Movilidad es el organismo encargado de expandir las licencias de conducir a tipo de vehículos o servicios. Por eso, cuando decidas gestionar tu nueva licencia ten en cuenta tener estos documentos:',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                const Text('• Identificacion oficial vigente'),
                const Text('• Comprobante de domicilio'),
                const Text('• CURP'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Design.botonGreen("Continuar", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FirstTime()));
                    }),
                    Design.botonRed("Cancelar", () {
                      Navigator.pop(context);
                    })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
