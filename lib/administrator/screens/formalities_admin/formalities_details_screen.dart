import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/app/core/modules/database/constants.dart';
import 'package:gps_semovil/app/core/modules/database/formalities_firestore.dart';
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
        backgroundColor: Design.teal,
        centerTitle: true,
        foregroundColor: Design.paleYellow,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            detailCard(
                title: "ID", value: formalities.idFormalities.toString()),
            detailCard(
                title: "Tipo de Licencia",
                value: formalities.driverLicenseType),
            detailCard(
                title: "Precio", value: "\$${formalities.price.toString()}"),
            detailCard(title: "CURP del Usuario", value: formalities.user.curp),
            detailCard(title: "Fecha", value: "${formalities.date.toDate()}"),
            detailCard(
                title: "Primera Vez",
                value: formalities.firsTime ? "Sí" : "No"),
            detailCard(
                title: "Estado Actual",
                value: Const.statusForm[formalities.status]!),
            const SizedBox(height: 20),
            ...buildDocumentLinks(context),
            ElevatedButton(
              onPressed: () => updateStatus(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Design.teal,
                backgroundColor: Design.paleYellow, // Text color
              ),
              child: const Text('Actualizar Estado'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildDocumentLinks(BuildContext context) {
    return [
      if (formalities.ineDoc.isNotEmpty)
        documentItem(context, 'Documento INE', formalities.ineDoc),
      if (formalities.addressProofDoc.isNotEmpty)
        documentItem(
            context, 'Comprobante de Domicilio', formalities.addressProofDoc),
      if (formalities.oldDriversLicense != null)
        documentItem(
            context, 'Licencia Anterior', formalities.oldDriversLicense!),
      if (formalities.theftLostCertificate != null)
        documentItem(context, 'Certificado de Extravío',
            formalities.theftLostCertificate!),
      if (formalities.paidProofDoc != null)
        documentItem(context, 'Comprobante de Pago', formalities.paidProofDoc!),
    ];
  }

  Widget documentItem(BuildContext context, String title, String url) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Design.teal)),
      trailing: IconButton(
        icon: const Icon(Icons.visibility, color: Design.teal),
        onPressed: () => downloadAndOpenPDF(context, url),
      ),
    );
  }

  Widget detailCard({required String title, required String value}) {
    return Card(
      color: Design.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: ListTile(
        title: Text(title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(color: Colors.white70)),
      ),
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
            title: Text(Const.statusForm[index]!,
                style: const TextStyle(color: Design.teal)),
            onTap: () async {
              formalities.status = index;
              await updateFormalities(formalities);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
