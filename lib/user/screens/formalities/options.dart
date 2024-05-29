import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gps_semovil/app/core/design.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'package:gps_semovil/user/screens/formalities/formalities.dart';
import 'package:gps_semovil/user/screens/formalities/information.dart';

class Options extends StatefulWidget {
  final UserModel user;
  const Options({super.key, required this.user});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Opciones', style: TextStyle(color: Design.paleYellow)),
        backgroundColor: Design.teal,
      ),
      body: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 500 ? 2 : 1,
          childAspectRatio: MediaQuery.of(context).size.width > 500 ? 3 : 4,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              CustomButton(
                label: 'Primera vez',
                icon: Icons.fiber_new,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Information(mode: 0, user: widget.user)));
                },
              ),
              CustomButton(
                label: 'Renovación',
                icon: Icons.refresh,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Information(mode: 1, user: widget.user)));
                },
              ),
              CustomButton(
                label: 'Extraviado',
                icon: Icons.error_outline,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Information(mode: 2, user: widget.user)));
                },
              ),
              CustomButton(
                label: 'Ver trámites pendientes',
                icon: Icons.warning_amber,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ScreenFormalities(user: widget.user)));
                },
              ),
            ],
          ),
        ),
      ),
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
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(5),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 30),
        label: Text(label, style: const TextStyle(fontSize: 16)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Design.seaGreen,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
