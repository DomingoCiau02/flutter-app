// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/controller.dart';
import '../icons/my_flutter_app_icons.dart';
import '../provider/granja_provider.dart';
import '../theme/app_theme.dart';

class ListPesajesView extends StatefulWidget {
  const ListPesajesView({super.key});

  @override
  State<ListPesajesView> createState() => _ListPesajesViewState();
}

class _ListPesajesViewState extends State<ListPesajesView> {
  seleccion(BuildContext context, int item, GranjaProvider ProvGranja) {
    switch (item) {
      case 0:
        PotreroController().getTipoPesaje(ProvGranja);
        Navigator.pushNamed(context, 'NuevoPesajeGeneral');
        break;
      case 1:
        PotreroController().getTipoPesaje(ProvGranja);
        PesajeAnimalController().pantallaPesajeAnimal(context, ProvGranja);
        break;
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
              "Pesajes",
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
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.add_outlined,
              size: 34,
            ),
            // Callback that sets the selected popup menu item.
            onSelected: ProvGranja.botonActivo
                ? null
                : (item) {
                    ProvGranja.botonActivo = true;
                    seleccion(context, item, ProvGranja);
                  },
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('División...'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Animal...'),
              ),
            ],
          ),
        ],
      ),
      //se desplirga una lista de con la fecha de los pesajes realizados
      body: ProvGranja.listaPesajes.isNotEmpty
          ? ListView.builder(
              itemCount: ProvGranja.listaPesajes.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ListTile(
                      tileColor: AppTheme.lightTheme.listTileTheme.tileColor,
                      contentPadding:
                          AppTheme.lightTheme.listTileTheme.contentPadding,
                      shape: AppTheme.lightTheme.listTileTheme.shape,

                      //aqui guardo la granja cuando se le hace click

                      onTap: ProvGranja.botonActivo
                          ? null
                          : () {
                              setState(() {
                                ProvGranja.botonActivo = true;
                                ProvGranja.pesajeSeleccionado =
                                    ProvGranja.listaPesajes[index].toJson();
                                PotreroController().getTipoPesaje(ProvGranja);
                                PesosController()
                                    .getPesajes(context, ProvGranja);
                              });
                            },

                      dense: AppTheme.lightTheme.listTileTheme.dense,

                      leading: const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Icon(
                          MyFlutterApp.weight_hanging,
                          color: AppTheme.primary,
                          size: 30,
                        ),
                      ),

                      title: Text(
                        ProvGranja.listaPesajes[index].nombre,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat('yyyy-MM-dd')
                            .format(ProvGranja.listaPesajes[index].fecha),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.038,
                        ),
                      ),

                      trailing: Text(
                        ProvGranja.listaPesajes[index].tipo,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                        ),
                      ),
                    ),
                  ),
                  const Divider(thickness: 2),
                ]);
              },
            )
          : const Center(
              child: Text(
                "Sin pesajes registrados",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
