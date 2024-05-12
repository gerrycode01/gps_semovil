import 'package:flutter/material.dart';
import 'package:gps_semovil/app/core/modules/database/firestore.dart';
import 'package:gps_semovil/local.dart';
import 'package:gps_semovil/user/models/user_model.dart';
import 'modules/authentication/authentication.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: Local.email);
  final TextEditingController _passwordController =
      TextEditingController(text: Local.password);
  bool _passwordVisible = false;

  bool _loading = false;

  void _login() async {
    setState(() {
      _loading = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    bool success = await Authentication.loginUser(email, password);

    if (success) {
      UserModel userModel = await getUser(_emailController.text);

      switch (userModel.rol) {
        case 'user':
          {
            Navigator.pushReplacementNamed(context, '/user_homepage',
                arguments: userModel);
            break;
          }
        case 'admin':
          {
            Navigator.pushReplacementNamed(context, '/admin_homepage',
                arguments: userModel);
            break;
          }
        default: {
          Navigator.pushReplacementNamed(context, '/traffic_officer_homepage',
              arguments: userModel);
          break;
        }
      }

      print('Login exitoso');
    } else {
      print('Error al iniciar sesión');
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxFieldWidth = screenWidth > 600 ? 400 : screenWidth * 0.8;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/SEMOVIL.png',
                width: 200,
                height: 200,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: maxFieldWidth),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.orange[100],
                            hintText: 'Correo',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.orange[100],
                            hintText: 'Contraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () async {
                            await Authentication.resetPassword(
                                _emailController.text);
                          },
                          child: const Text(
                            'He olvidado mi contraseña',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _loading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() ==
                                      false) {
                                    return;
                                  }
                                  _login();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green), // Background color
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white), // Text color
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                child: const Text('Log in'),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign_up');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.orange), // Background color
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white), // Text color
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: const Text('Sign up'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void forgotPassword() {}
