// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:app/controller/controller.dart';
import 'package:provider/provider.dart';
import '../icons/my_flutter_app_icons.dart';
import '../provider/granja_provider.dart';
import '../theme/app_theme.dart';

class GranjaView extends StatefulWidget {
  const GranjaView({super.key});

  @override
  State<GranjaView> createState() => _GranjaViewState();
}

class _GranjaViewState extends State<GranjaView> {
  @override
  Widget build(BuildContext context) {
    final ProvGranja = Provider.of<GranjaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Lista de granjas",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            Text(
              ProvGranja.ranchoUsuario["nombre"],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      //el body se pregunta si la lista de las granjas con el filtro de la pantalla anterior esta vacia, y aparti de ahi decide que witget crear
      body:
          ProvGranja.listaGranjaFiltro.isNotEmpty
              ? ListView.builder(
                itemCount: ProvGranja.listaGranjaFiltro.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ListTile(
                          tileColor:
                              AppTheme.lightTheme.listTileTheme.tileColor,
                          contentPadding:
                              AppTheme.lightTheme.listTileTheme.contentPadding,
                          shape: AppTheme.lightTheme.listTileTheme.shape,

                          //aqui guardo la granja cuando se le hace click
                          onTap:
                              ProvGranja.botonActivo
                                  ? null
                                  : () {
                                    setState(() {
                                      ProvGranja.botonActivo = true;
                                      ProvGranja.granjaUsuario =
                                          ProvGranja.listaGranjaFiltro[index]
                                              .toJson();
                                      GranjaController().cargarPantalla(
                                        context,
                                        ProvGranja,
                                      );
                                    });
                                  },

                          dense: AppTheme.lightTheme.listTileTheme.dense,
                          leading: const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Icon(
                              MyFlutterApp.hat_cowboy,
                              color: AppTheme.primary,
                              size: 30,
                            ),
                          ),
                          title: Text(
                            '${ProvGranja.listaGranjaFiltro[index].nombre}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      const Divider(thickness: 2),
                    ],
                  );
                },
              )
              : const Center(
                child: Text(
                  "Sin granjas",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
