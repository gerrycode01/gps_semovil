import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gps_semovil/app/core/design.dart';
import '../../../app/core/modules/database/fines_firestore.dart';
import '../../../traffic_officer/models/fine-model.dart';
import '../../models/user_model.dart';

class FinesScreen extends StatefulWidget {
  final UserModel user;

  const FinesScreen({super.key, required this.user});

  @override
  State<FinesScreen> createState() => _FinesScreenState();
}

class _FinesScreenState extends State<FinesScreen> {
  List<FineModel> _finesList = [];

  @override
  void initState() {
    super.initState();
    loadFines();
  }

  void loadFines() async {
    try {
      List<FineModel> fines = await getFinesByUser(widget.user.curp);
      setState(() {
        _finesList = fines;
      });
    } catch (error) {
      print("Error cargando la lista de multas: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2; // Ajusta aquí para más columnas en pantallas más grandes
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Design.teal,
          title: Text('Tus multas', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          foregroundColor: Design.paleYellow,
          bottom: TabBar(
            labelColor: Design.paleYellow,
            indicatorColor: Design.seaGreen,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: 'Pendientes'),
              Tab(text: 'Historial'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildFineList('Pendiente', crossAxisCount),
            buildFineList('Atendido', crossAxisCount),
          ],
        ),
      ),
    );
  }

  Widget buildFineList(String status, int crossAxisCount) {
    List<FineModel> filteredFines = _finesList.where((fine) => fine.status == status).toList();
    return AnimationLimiter(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1.5,
        ),
        itemCount: filteredFines.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: crossAxisCount,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: FineCard(
                  fine: filteredFines[index],
                  onTap: status == 'Pendiente' ? () => _showPaymentDialog(context, filteredFines[index]) : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPaymentDialog(BuildContext context, FineModel fine) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Confirmación de Pago', style: TextStyle(color: Design.teal)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('¿Estás seguro que deseas realizar el pago de esta multa?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.redAccent)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Confirmar', style: TextStyle(color: Design.teal)),
              onPressed: () {
                payFine(fine.id);
                Navigator.of(context).pop();
                setState(() {
                  loadFines();
                });
              },
            ),
          ],
        );
      },
    );
  }
}

class FineCard extends StatelessWidget {
  final FineModel fine;
  final VoidCallback? onTap;

  const FineCard({Key? key, required this.fine, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: fine.status == 'Pendiente' ? Colors.red[300] : Colors.green[300],
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description, size: 40, color: Colors.white),
            Text(
              fine.place ?? "Sin ubicación",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              fine.formattedDate(),
              style: TextStyle(color: Colors.white70),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${fine.articles} - ${fine.justifications}" ?? "",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
