// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:app/models/models.dart';
import 'package:app/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/controller.dart';
import '../provider/granja_provider.dart';

class AddPesajeGralView extends StatefulWidget {
  const AddPesajeGralView({super.key});

  @override
  State<AddPesajeGralView> createState() => _AddPesajeGralViewState();
}

class _AddPesajeGralViewState extends State<AddPesajeGralView> {
  List<Map<String, dynamic>> tableData = [];
  late DateTime _fechaElegida = DateTime.now();
  String? sexoAnimal;
  TipoPesaje? tipoSeleccionado;
  RanchoDivision? divisionSeleccionado;
  var pesoKG = TextEditingController();
  int indexFilaTabla = 0;
  int filaSeleccionada = -1;

  //Toma la fecha seleeccionada y la guarda en una variable
  void seleccionarDato() async {
    var fecha = await crearRelog();
    if (fecha != null) {
      setState(() {
        _fechaElegida = fecha;
      });
    }
  }

  //creas el showDataPiker que es el relog y le pones valores por defecto
  Future<DateTime?> crearRelog() {
    return showDatePicker(context: context, initialDate: _fechaElegida, firstDate: DateTime(1990), lastDate: DateTime.now());
  }

  //se encarga de borrar un elemento de la lista y lo restructura.
  void delteTable(Map<String, dynamic> data) {
    setState(() {
      tableData.remove(data);
      for (int i = 0; i < tableData.length; i++) {
        tableData[i] = {'sexo': tableData[i]['sexo'], 'peso': tableData[i]['peso'], 'indice': i};
      }
      pesoKG.clear();
      filaSeleccionada = -1;
    });
  }

  //al agregar un nuevo pesaje se agrega a la lista y se muestra en la tabla
  void addToTable() {
    if (sexoAnimal == null || pesoKG.text.isEmpty) {
      const snackBar = SnackBar(content: Text('Campo de sexo o peso vacio.'), duration: Duration(seconds: 1, milliseconds: 500));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        if (filaSeleccionada == -1) {
          tableData.add({'sexo': sexoAnimal, 'peso': pesoKG.text, 'indice': indexFilaTabla++});
        } else {
          tableData[filaSeleccionada] = {'sexo': sexoAnimal, 'peso': pesoKG.text, 'indice': filaSeleccionada};
          filaSeleccionada = -1;
        }
        pesoKG.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProvGranja = Provider.of<GranjaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text("Nuevo pesaje", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
            Text(
              ProvGranja.granjaUsuario["nombre"] ?? '',
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.055, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          //boton de para guardar todos los datos
          IconButton(
            onPressed:
                ProvGranja.botonActivo
                    ? null
                    : () {
                      if (tipoSeleccionado == null || tableData.isEmpty || divisionSeleccionado == null) {
                        const snackBar = SnackBar(
                          content: Text('Campo de tipo, divición o pesajes vacio.'),
                          duration: Duration(seconds: 1, milliseconds: 500),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        ProvGranja.botonActivo = false;
                      } else {
                        PesosController().postPesaje(ProvGranja, _fechaElegida, tipoSeleccionado, divisionSeleccionado, tableData);
                        setState(() {
                          PotreroController().datoPesaje(ProvGranja, context, false);
                        });
                      }
                    },
            icon: const Icon(Icons.save_outlined, size: 37, color: AppTheme.primary),
          ),
        ],
      ),

      /*creamos el formulario de nuevo pesage 
      *contiene:
      * 2 Dropdownbuton para el sexo y el tipo de pesaje(raido desde la api)
      * un Texlabel para ingresar el peso nuevo
      * una boton para seleccionar la fecha 
      * una tabla para mostrar los pesages ingresados
      */
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //campo de seleccion de la divicion del rancho
            DropdownButton<RanchoDivision>(
              hint: const Text("Selecciona la división del rancho"),
              items:
                  ProvGranja.listaDivisionesRancho.map<DropdownMenuItem<RanchoDivision>>((RanchoDivision value) {
                    return DropdownMenuItem<RanchoDivision>(value: value, child: Text(value.nombre.toString()));
                  }).toList(),
              value: divisionSeleccionado,
              icon: const Icon(Icons.arrow_drop_down_outlined),
              underline: Container(height: .5, color: Colors.grey[800]),
              onChanged: (RanchoDivision? value) {
                setState(() {
                  divisionSeleccionado = value!;
                });
              },
              isExpanded: true,
            ),

            //campo de seleccion del tipo de pesaje del animal
            DropdownButton<TipoPesaje>(
              hint: const Text("Selecciona el tipo de pesaje"),
              items:
                  ProvGranja.listaTipoPesaje.map<DropdownMenuItem<TipoPesaje>>((TipoPesaje value) {
                    return DropdownMenuItem<TipoPesaje>(value: value, child: Text(value.nombre.toString()));
                  }).toList(),
              value: tipoSeleccionado,
              icon: const Icon(Icons.arrow_drop_down_outlined),
              underline: Container(height: .5, color: Colors.grey[800]),
              onChanged: (TipoPesaje? value) {
                setState(() {
                  tipoSeleccionado = value!;
                });
              },
              isExpanded: true,
            ),

            const SizedBox(height: 8),

            //boton de seleccion de fecha del pesaje
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text('Selecciona la fecha: ', style: TextStyle(fontSize: 17, color: Colors.grey[600]))),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent), // Cambia "Colors.blue" por el color deseado
                  ),
                  onPressed: () {
                    seleccionarDato();
                  },
                  icon: const Icon(Icons.calendar_today, size: 28, color: AppTheme.primary),
                  label: Text(DateFormat('yyyy-MM-dd').format(_fechaElegida), style: TextStyle(fontSize: 17, color: Colors.grey[600])),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                //campo de seleccion del sexo del animal
                Expanded(
                  child: DropdownButton<String>(
                    hint: const Text("Selecciona el sexo"),
                    items:
                        ['Macho', 'Hembra'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(value: value, child: Text(value));
                        }).toList(),
                    value: sexoAnimal,
                    dropdownColor: Colors.grey[200],
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    underline: Container(height: .5, color: Colors.grey[800]),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        sexoAnimal = value!;
                      });
                    },
                    //isExpanded: true,
                  ),
                ),

                const SizedBox(width: 5),

                //campo de texto del pesaje.
                Text("Peso:", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.number,
                    controller: pesoKG,
                    decoration: const InputDecoration(
                      fillColor: Color.fromARGB(0, 3, 168, 244),
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: .5)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: .5)),
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            //tabla para mostrar los pesajes ingresados
            Expanded(
              child: ListView(
                children: [
                  DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(47, 33, 149, 243)),
                    dataRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(38, 158, 158, 158)),
                    columnSpacing: 40,
                    columns: const [
                      DataColumn(label: Text('Sexo')),
                      DataColumn(label: Text('Peso'), numeric: true),
                      DataColumn(label: Text('Acciones'), numeric: true),
                    ],
                    rows:
                        tableData.map((data) {
                          return DataRow(
                            cells: [
                              DataCell(Text(data['sexo'])),
                              DataCell(Text(data['peso'])),
                              DataCell(
                                ButtonBar(
                                  buttonPadding: const EdgeInsets.all(0),
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          pesoKG.text = data['peso'];
                                          sexoAnimal = data['sexo'];
                                          filaSeleccionada = data['indice'];
                                        });
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        delteTable(data);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //boton para agregar un nuevo pesaje
      floatingActionButton: FloatingActionButton(onPressed: addToTable, tooltip: 'Increment', child: const Icon(Icons.add)),
    );
  }
}
