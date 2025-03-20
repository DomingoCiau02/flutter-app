// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';
import '../models/models.dart';
import '../provider/granja_provider.dart';
import '../theme/app_theme.dart';

class AlimView extends StatefulWidget {
  const AlimView({super.key});

  @override
  State<AlimView> createState() => _AlimViewState();
}

class _AlimViewState extends State<AlimView> {
  RanchoDivision? divisionSeleccionado;
  TipoAlimento? alimentoSeleccionado;
  var cantidad = TextEditingController();
  int filaSeleccionada = -1;

  //se encarga de borrar un elemento de la lista y lo restructura.
  void delteTable(GranjaProvider ProvGranja, DetalleAlimDivision data) {
    setState(() {
      ProvGranja.listaDetalleAlimentacion.remove(data);
      for (int i = 0; i < ProvGranja.listaDetalleAlimentacion.length; i++) {
        ProvGranja.listaDetalleAlimentacion[i] = DetalleAlimDivision(
          ProvGranja.listaDetalleAlimentacion[i].id,
          ProvGranja.listaDetalleAlimentacion[i].cantidad,
          ProvGranja.listaDetalleAlimentacion[i].tipoAlimento,
          ProvGranja.listaDetalleAlimentacion[i].alimentoRanchoDivisionId,
          ProvGranja.listaDetalleAlimentacion[i].ranchoDivision,
          i,
        );
      }
      cantidad.clear();
      filaSeleccionada = -1;
    });
  }

  //al agregar un nuevo pesaje se agrega a la lista y se muestra en la tabla
  void addToTable(GranjaProvider ProvGranja) {
    if (divisionSeleccionado == null ||
        alimentoSeleccionado == null ||
        cantidad.text.isEmpty) {
      var snackBar = SnackBar(
        backgroundColor: Colors.grey[500],
        content: const Text(
          'Campo de alimentacion, alimento o cantidad vacio.',
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 1, milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        if (filaSeleccionada == -1) {
          ProvGranja.listaDetalleAlimentacion.add(
            DetalleAlimDivision(
              ProvGranja.listaDetalleAlimentacion.length,
              double.parse(cantidad.text),
              alimentoSeleccionado!,
              ProvGranja.listaDetalleAlimentacion.length,
              divisionSeleccionado!,
              ProvGranja.listaDetalleAlimentacion.length,
            ),
          );
        } else {
          ProvGranja.listaDetalleAlimentacion[filaSeleccionada] =
              DetalleAlimDivision(
            ProvGranja.listaDetalleAlimentacion[filaSeleccionada].id,
            double.parse(cantidad.text),
            alimentoSeleccionado!,
            ProvGranja.listaDetalleAlimentacion[filaSeleccionada]
                .alimentoRanchoDivisionId,
            divisionSeleccionado!,
            filaSeleccionada,
          );
          filaSeleccionada = -1;
        }
        cantidad.clear();
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
            Text(
              "Detalle alimentacion",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            Text(
              ProvGranja.granjaUsuario["nombre"],
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          //boton de para guardar todos los datos
          IconButton(
            onPressed: ProvGranja.botonActivo
                ? null
                : () {
                    if (ProvGranja.listaDetalleAlimentacion.isEmpty) {
                      var snackBar = SnackBar(
                        backgroundColor: Colors.grey[500],
                        content: const Text(
                          'Sin elementos.',
                          textAlign: TextAlign.center,
                        ),
                        duration: const Duration(seconds: 1, milliseconds: 500),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      ProvGranja.botonActivo = false;
                    } else {
                      AlimentacionController()
                          .updateAlimentacion(context, ProvGranja);
                    }
                  },
            icon: const Icon(
              Icons.save_outlined,
              size: 37,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
      //sskssfafds
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //campo de seleccion de la divicion del rancho
            DropdownButton<RanchoDivision>(
              hint: const Text("Selecciona la división del rancho"),
              items: ProvGranja.listaDivisionesRancho
                  .map<DropdownMenuItem<RanchoDivision>>(
                      (RanchoDivision value) {
                return DropdownMenuItem<RanchoDivision>(
                  value: value,
                  child: Text(value.nombre.toString()),
                );
              }).toList(),
              value: divisionSeleccionado,
              icon: const Icon(Icons.arrow_drop_down_outlined),
              underline: Container(
                height: .5,
                color: Colors.grey[800],
              ),
              onChanged: (RanchoDivision? value) {
                setState(
                  () {
                    divisionSeleccionado = value!;
                  },
                );
              },
              isExpanded: true,
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                //campo de seleccion del tipo de alimento
                Expanded(
                  child: DropdownButton<TipoAlimento>(
                    hint: const Text("Tipo alimento"),
                    items: ProvGranja.listaTiposAlimento
                        .map<DropdownMenuItem<TipoAlimento>>(
                            (TipoAlimento value) {
                      return DropdownMenuItem<TipoAlimento>(
                        value: value,
                        child: Text(value.nombre.toString()),
                      );
                    }).toList(),
                    value: alimentoSeleccionado,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    underline: Container(
                      height: .5,
                      color: Colors.grey[800],
                    ),
                    onChanged: (TipoAlimento? value) {
                      setState(
                        () {
                          alimentoSeleccionado = value!;
                        },
                      );
                    },
                    isExpanded: true,
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                //campo de texto de la cantidad de alimento.
                Text(
                  "Cantidad:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.number,
                    controller: cantidad,
                    decoration: const InputDecoration(
                      fillColor: Color.fromARGB(0, 3, 168, 244),
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: .5)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: .5)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 0),
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
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(47, 33, 149, 243),
                    ),
                    dataRowColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(38, 158, 158, 158),
                    ),
                    columnSpacing: 0,
                    columns: const [
                      DataColumn(label: Text('Divición')),
                      DataColumn(label: Text('Alimento')),
                      DataColumn(
                        label: Text('Cantidad'),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text('Acciones'),
                        numeric: true,
                      ),
                    ],
                    rows: ProvGranja.listaDetalleAlimentacion.map(
                      (data) {
                        return DataRow(
                          cells: [
                            DataCell(Text(data.ranchoDivision.nombre)),
                            DataCell(Text(data.tipoAlimento.nombre)),
                            DataCell(Text('${data.cantidad}')),
                            DataCell(
                              ButtonBar(
                                buttonPadding: const EdgeInsets.all(0),
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        cantidad.text = '${data.cantidad}';
                                        divisionSeleccionado =
                                            data.ranchoDivision;
                                        alimentoSeleccionado =
                                            data.tipoAlimento;
                                        filaSeleccionada = data.indice;
                                      });
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      delteTable(ProvGranja, data);
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //boton para agregar un nuevo pesaje
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addToTable(ProvGranja);
        },
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
