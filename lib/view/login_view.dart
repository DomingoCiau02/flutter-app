// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:app/widget/widgets.dart';
import 'package:provider/provider.dart';
import '../controller/controller.dart';
import '../provider/granja_provider.dart';
import '../theme/app_theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var userController = TextEditingController();
  var passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  bool pass = true;

  @override
  Widget build(BuildContext context) {
    final ProvGranja = Provider.of<GranjaProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //contenedor en el que se agrega la imagen del logo de la empresa
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
            child: Image.asset("assets/images/logo.png", height: 200),
          ),

          //se crea una targeta centrada para que muestra el login
          //esta targeta se puede sobreponersobre el logo
          Center(
            child: Card(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 45,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //texfield de tipo usuario
                      LoginTextFieldWidget(
                        controller: userController,
                        labelText: 'Usuario',
                        tipoForm: true,
                        focusNextTextFormField: _passwordFocus,
                      ),

                      //
                      const SizedBox(height: 20),

                      //Texfiel de tipo contraseña
                      LoginTextFieldWidget(
                        controller: passwordController,
                        labelText: 'Contraseña',
                        tipoForm: false,
                        focusThisTextFormField: _passwordFocus,
                      ),
                      const SizedBox(height: 20),

                      //boton para inicar el login
                      ElevatedButton(
                        onPressed:
                            ProvGranja.botonActivo
                                ? null
                                : () {
                                  //se encarga de validar los datos y cargar la segunda pantalla
                                  if (_formKey.currentState!.validate()) {
                                    // Ambos campos son válidos
                                    setState(() {
                                      ProvGranja.botonActivo = true;
                                      LoginController().inicioSesion(
                                        context,
                                        userController.text,
                                        passwordController.text,
                                        ProvGranja,
                                      );
                                    });
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white,
                          disabledForegroundColor: AppTheme.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 40,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(),
                          child: Text('Inicio'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
