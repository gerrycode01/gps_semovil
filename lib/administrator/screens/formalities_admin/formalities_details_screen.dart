import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/constants.dart';
import 'package:gps_semovil/user/models/formalities_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';

class FormalitiesDetailScreen extends StatelessWidget {
  final Formalities formalities;

  const FormalitiesDetailScreen({super.key, required this.formalities});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Formalidad'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildInfoText('ID: ${formalities.idFormalities}'),
            buildInfoText('Tipo de Licencia: ${formalities.driverLicenseType}'),
            buildInfoText('Precio: \$${formalities.price.toString()}'),
            buildInfoText('CURP del Usuario: ${formalities.user.curp}'),
            buildInfoText('Fecha: ${formalities.date.toDate()}'),
            buildDocumentLink(context, 'Documento INE', formalities.ineDoc),
            buildDocumentLink(context, 'Comprobante de Domicilio',
                formalities.addressProofDoc),
            if (formalities.oldDriversLicense != null)
              buildDocumentLink(
                  context, 'Licencia Anterior', formalities.oldDriversLicense!),
            if (formalities.theftLostCertificate != null)
              buildDocumentLink(context, 'Certificado de Extravío',
                  formalities.theftLostCertificate!),
            if (formalities.paidProofDoc != null)
              buildDocumentLink(
                  context, 'Comprobante de Pago', formalities.paidProofDoc!),
            buildInfoText('Primera Vez: ${formalities.firsTime ? "Sí" : "No"}'),
            buildInfoText(
                'Estado Actual: ${Const.statusForm[formalities.status]}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => updateStatus(context),
              child: const Text('Actualizar Estado'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoText(String text) => Text(text);

  Widget buildDocumentLink(BuildContext context, String title, String url) {
    return ListTile(
      title: Text(title),
      subtitle: Text(url),
      onTap: () => downloadAndOpenPDF(context, url),
    );
  }

  Future<void> downloadAndOpenPDF(BuildContext context, String url) async {
    final Dio dio = Dio();
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/temp.pdf';
    try {
      await dio.download(url, path);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => PDFView(filePath: path)));
    } catch (e) {
      final snackBar =
          SnackBar(content: Text('Error al abrir el documento: $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void updateStatus(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: Const.statusForm.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(Const.statusForm[index]!),
            onTap: () {
              Navigator.pop(context);
              // Lógica para actualizar el estado aquí
            },
          ),
        );
      },
    );
  }
}
