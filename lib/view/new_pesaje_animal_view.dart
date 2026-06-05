// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:app/controller/controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../provider/granja_provider.dart';
import '../theme/app_theme.dart';

class NewPesajeAnimalView extends StatefulWidget {
  const NewPesajeAnimalView({super.key});

  @override
  State<NewPesajeAnimalView> createState() => _NewPesajeAnimalViewState();
}

class _NewPesajeAnimalViewState extends State<NewPesajeAnimalView> {
  var pesoKG = TextEditingController();
  List<TarjetaAnimal> listaTargetaAnimalFiltro = [];

  PesajeAnimal pesajeAnimal = PesajeAnimal(0, DateFormat('yyyy-MM-dd').format(DateTime.now()), 0, 0, 0);
  bool listaVacia = false;
  int filaSeleccionada = -1;
  int indexFilaTabla = 0;

  //?--------variables de seleccion----------------------
  TipoPesaje? tipoPesaje;
  RanchoDivision? divisionSeleccionado;
  TipoAnimal? tipoAnimal;
  RazaAnimal? razaAnimal;
  TarjetaAnimal? tarjetaAnimal;

  void filtroAnimales(GranjaProvider ProvGranja) {
    listaTargetaAnimalFiltro = ProvGranja.listaTargetaAnimal;
    listaVacia = true;
    if (divisionSeleccionado != null) {
      listaTargetaAnimalFiltro = listaTargetaAnimalFiltro.where((animal) => animal.divisionRanchoId == divisionSeleccionado?.id).toList();
    }

    if (tipoAnimal != null) {
      listaTargetaAnimalFiltro = listaTargetaAnimalFiltro.where((animal) => animal.tipoAnimalId == tipoAnimal?.id).toList();
    }

    if (razaAnimal != null) {
      listaTargetaAnimalFiltro = listaTargetaAnimalFiltro.where((animal) => animal.razaAnimalId == razaAnimal?.id).toList();
    }
  }

  //se encarga de borrar un elemento de la lista y lo restructura.
  void delteTable(Map<String, dynamic> data) {
    setState(() {
      pesajeAnimal.listaDetallesPesaje?.remove(data);
      for (int i = 0; i < pesajeAnimal.listaDetallesPesaje!.length; i++) {
        pesajeAnimal.listaDetallesPesaje![i] = {'peso': pesajeAnimal.listaDetallesPesaje![i]['peso'], 'indice': i};
      }
      pesoKG.clear();
      filaSeleccionada = -1;
    });
  }

  //al agregar un nuevo pesaje se agrega a la lista y se muestra en la tabla
  void addToTable() {
    if (pesoKG.text.isEmpty) {
      const snackBar = SnackBar(content: Text('Campo de peso vacio.'), duration: Duration(seconds: 1, milliseconds: 500));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        if (filaSeleccionada == -1) {
          pesajeAnimal.listaDetallesPesaje!.add({'peso': pesoKG.text, 'indice': indexFilaTabla++});
        } else {
          pesajeAnimal.listaDetallesPesaje![filaSeleccionada] = {'peso': pesoKG.text, 'indice': filaSeleccionada};
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
                      if (tipoPesaje == null || pesajeAnimal.listaDetallesPesaje!.isEmpty || tarjetaAnimal == null) {
                        const snackBar = SnackBar(
                          content: Text('Campo de división o tipo pesajes vacío.'),
                          duration: Duration(seconds: 1, milliseconds: 500),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        ProvGranja.botonActivo = false;
                      } else {
                        PesajeAnimalController().postPesajeAnimal(
                          pesajeAnimal,
                          ProvGranja,
                          DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          tarjetaAnimal!,
                          tipoPesaje!,
                        );
                        setState(() {
                          PotreroController().datoPesaje(ProvGranja, context, false);
                        });
                      }
                    },
            icon: const Icon(Icons.save_outlined, size: 37, color: AppTheme.primary),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                //!-----------------campo de seleccion de la divicion del rancho---------------------
                Expanded(
                  child: DropdownButton<RanchoDivision>(
                    hint: const Text("División del rancho"),
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
                        filtroAnimales(ProvGranja);
                      });
                    },
                    isExpanded: true,
                  ),
                ),

                const SizedBox(width: 15),

                //!---------------campo de seleccion del tipo de animal-----------------------------
                Expanded(
                  child: DropdownButton<TipoAnimal>(
                    hint: const Text("Tipo de animal"),
                    items:
                        ProvGranja.listaTipoAnimal.map<DropdownMenuItem<TipoAnimal>>((TipoAnimal value) {
                          return DropdownMenuItem<TipoAnimal>(value: value, child: Text(value.nombre.toString()));
                        }).toList(),
                    value: tipoAnimal,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    underline: Container(height: .5, color: Colors.grey[800]),
                    onChanged: (TipoAnimal? value) {
                      setState(() {
                        tipoAnimal = value!;
                        filtroAnimales(ProvGranja);
                      });
                    },
                    isExpanded: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                //!--------------campo de seleccion de la raza del animal----------------------
                Expanded(
                  child: DropdownButton<RazaAnimal>(
                    hint: const Text("Raza del animal"),
                    items:
                        ProvGranja.listaRazaAnimal.map<DropdownMenuItem<RazaAnimal>>((RazaAnimal value) {
                          return DropdownMenuItem<RazaAnimal>(value: value, child: Text(value.nombre.toString()));
                        }).toList(),
                    value: razaAnimal,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    underline: Container(height: .5, color: Colors.grey[800]),
                    onChanged: (RazaAnimal? value) {
                      setState(() {
                        razaAnimal = value!;
                        filtroAnimales(ProvGranja);
                      });
                    },
                    isExpanded: true,
                  ),
                ),

                const SizedBox(width: 15),

                //!----------------campo de seleccion del animal----------------------
                Expanded(
                  child: DropdownButton<TarjetaAnimal>(
                    hint: const Text("Animal"),
                    items:
                        listaVacia
                            ? listaTargetaAnimalFiltro.map<DropdownMenuItem<TarjetaAnimal>>((TarjetaAnimal value) {
                              return DropdownMenuItem<TarjetaAnimal>(value: value, child: Text(value.nombre.toString()));
                            }).toList()
                            : ProvGranja.listaTargetaAnimal.map<DropdownMenuItem<TarjetaAnimal>>((TarjetaAnimal value) {
                              return DropdownMenuItem<TarjetaAnimal>(value: value, child: Text(value.nombre.toString()));
                            }).toList(),
                    value: tarjetaAnimal,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    underline: Container(height: .5, color: Colors.grey[800]),
                    onChanged: (TarjetaAnimal? value) {
                      setState(() {
                        tarjetaAnimal = value!;
                      });
                    },
                    isExpanded: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //campo de seleccion del tipo de pesaje del animal
                Expanded(
                  child: DropdownButton<TipoPesaje>(
                    hint: const Text("Tipo de pesaje"),
                    items:
                        ProvGranja.listaTipoPesaje.map<DropdownMenuItem<TipoPesaje>>((TipoPesaje value) {
                          return DropdownMenuItem<TipoPesaje>(value: value, child: Text(value.nombre.toString()));
                        }).toList(),
                    value: tipoPesaje,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    underline: Container(height: .5, color: Colors.grey[800]),
                    onChanged: (TipoPesaje? value) {
                      setState(() {
                        tipoPesaje = value!;
                      });
                    },
                    isExpanded: true,
                  ),
                ),

                const SizedBox(width: 15),

                //campo de texto del pesaje.
                Expanded(
                  child: Row(
                    children: [
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
                ),
              ],
            ),
            //tabla para mostrar los pesajes ingresados
            Expanded(
              child: ListView(
                children: [
                  DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(47, 33, 149, 243)),
                    dataRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(38, 158, 158, 158)),
                    columns: const [DataColumn(label: Text('Peso'), numeric: true), DataColumn(label: Text('Acciones'), numeric: true)],
                    rows:
                        pesajeAnimal.listaDetallesPesaje!.map((data) {
                          return DataRow(
                            cells: [
                              DataCell(Text(data['peso'])),
                              DataCell(
                                ButtonBar(
                                  buttonPadding: const EdgeInsets.all(0),
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          pesoKG.text = data['peso'];
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
