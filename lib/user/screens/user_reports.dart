import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_semovil/user/screens/user_add_reports.dart';

import '../models/user_model.dart';

class UserReports extends StatefulWidget {
  const UserReports({super.key, required this.user});

  final UserModel user;

  @override
  State<UserReports> createState() => _UserReportsState();
}

class _UserReportsState extends State<UserReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserAddReports(
                      user: widget.user,
                    ))).then((value) => setState(() {}));
          }, icon: Icon(Icons.add))
        ],
      ),
    );
  }
}
