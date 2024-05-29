import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gps_semovil/administrator/screens/traffic_officer_admin/add_trafic_officer.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/app/core/modules/database/user_firestore.dart';
import 'package:gps_semovil/user/models/user_model.dart';

class HomeAdminTraficOfficer extends StatefulWidget {
  const HomeAdminTraficOfficer({super.key});

  @override
  State<HomeAdminTraficOfficer> createState() => _HomeAdminTraficOfficerState();
}

class _HomeAdminTraficOfficerState extends State<HomeAdminTraficOfficer> {
  List<UserModel> officers = [];

  @override
  void initState() {
    super.initState();
    loadOfficers();
  }

  void loadOfficers() async {
    var fetchedOfficers = await getTrafficOfficers();
    setState(() {
      officers = fetchedOfficers;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadOfficers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oficiales de Tránsito', style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
        centerTitle: true,
        foregroundColor: Design.paleYellow,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Design.paleYellow),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTrafficOfficer()));
            },
          ),
        ],
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: officers.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: officerCard(context, officers[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget officerCard(BuildContext context, UserModel officer) {
    return Card(
      elevation: 10,
      color: Design.teal,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.person, size: 50, color: Design.paleYellow),
        title: Text(officer.names + ' ' + officer.lastname,style: TextStyle(color: Colors.white),),
        subtitle: Text(officer.email ?? 'No email',style: TextStyle(color: Design.lightOrange),),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Design.mintGreen,),
              onPressed: () {
                // Implementar funcionalidad de edición
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Implementar funcionalidad de eliminación
              },
            ),
          ],
        ),
      ),
    );
  }
}
