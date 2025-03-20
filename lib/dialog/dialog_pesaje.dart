// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/granja_provider.dart';

class PesajeDialog extends StatefulWidget {
  const PesajeDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PesajeDialogState createState() => _PesajeDialogState();
}

class _PesajeDialogState extends State<PesajeDialog> {
  String? sexoAnimal;
  var pesoKG = TextEditingController();

//creamos la targeta en la que se van a agregar los datos de un nuevo pesaje
  @override
  Widget build(BuildContext context) {
    final ProvGranja = Provider.of<GranjaProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 30,
          ),
          child: Column(
            children: [
              //seleccionar el tipo de sexo
              DropdownButton<String>(
                hint: const Text("Selecciona sexo"),
                items: ['Macho', 'Hembra']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: sexoAnimal,
                dropdownColor: Colors.grey[200],
                icon: const Icon(Icons.arrow_drop_down_outlined),
                elevation: 5,
                underline: Container(
                  height: 1.2,
                  color: Colors.grey[800],
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(
                    () {
                      sexoAnimal = value!;
                    },
                  );
                },
                isExpanded: true,
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("Peso: "),
                  //campo de seleccion del sexo del animal
                  //campo de texto del pesaje.
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      controller: pesoKG,
                      decoration: const InputDecoration(
                        isDense: true,
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2.5, horizontal: 0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 15,
        ),

        //boton para guardar el nuevo pesaje.
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.save_outlined,
            size: 35,
          ),
        ),
      ],
    );
  }
}
