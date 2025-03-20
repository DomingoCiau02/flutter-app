import 'package:flutter/material.dart';

class LoginTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  //*indica de que tipo es el teclado si es true de tipo usuario si es false de tipo contraseña
  final bool tipoForm;

  final FocusNode? focusNextTextFormField;
  final FocusNode? focusThisTextFormField;

  const LoginTextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.tipoForm,
    this.focusNextTextFormField,
    this.focusThisTextFormField,
  });

  @override
  State<LoginTextFieldWidget> createState() => _LoginTextFieldWidgetState();
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {
  bool pass = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      //Enfocar a este TextFormField
      focusNode: widget.focusThisTextFormField,
      //Accion al dar enter al teclado
      onFieldSubmitted: widget.tipoForm
          ? (_) {
              //Pasar al siguiente TextFormField
              FocusScope.of(context)
                  .requestFocus(widget.focusNextTextFormField);
            }
          : (_) {
              //Cerrar teclado
              FocusScope.of(context).unfocus();
            },
      //me muestra el tipo de teclado si es true es de tipo imail y false solo de tipo texto
      keyboardType:
          widget.tipoForm ? TextInputType.emailAddress : TextInputType.text,
      obscureText: widget.tipoForm ? false : pass,

      //decoracion del texfield
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: widget.tipoForm
            ? null
            : IconButton(
                icon: pass
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.grey,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                onPressed: () {
                  setState(
                    () {
                      pass = !pass;
                    },
                  );
                },
              ),
        fillColor: Colors.blueGrey[50],
        labelStyle: const TextStyle(fontSize: 15),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
      ),

      //fucnion que se encarga de validar si esta vacio o no el campo
      validator: (value) {
        if (value!.isEmpty) {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }
}
