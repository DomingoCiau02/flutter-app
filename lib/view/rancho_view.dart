// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:app/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../controller/controller.dart';
import '../icons/my_flutter_app_icons.dart';
import '../provider/granja_provider.dart';

class RanchoView extends StatefulWidget {
  const RanchoView({super.key});
  @override
  State<RanchoView> createState() => _RanchoViewState();
}

class _RanchoViewState extends State<RanchoView> {
  @override
  Widget build(BuildContext context) {
    final ProvGranja = Provider.of<GranjaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Ranchos",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            cerrarSecion(context);
          },
          icon: const Icon(Icons.logout_rounded, size: 35),
        ),
      ),

      //el body se pregunta si la lista de ranchos esta vacia y aparti de ahi decide que witget crear.
      body:
          ProvGranja.listaRancho.isNotEmpty
              ? ListView.builder(
                itemCount: ProvGranja.listaRancho.length,
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
                          onTap:
                              ProvGranja.botonActivo
                                  ? null
                                  : () {
                                    //aqui se hace un flitro que se encarga de buscar en la lista de las granjas solo aquellos elementos que tengan un rancho_i igual al id del rancho que se selecciona
                                    setState(() {
                                      ProvGranja.botonActivo = true;
                                      ProvGranja.listaGranjaFiltro =
                                          ProvGranja.listaGranja
                                              .where(
                                                (element) =>
                                                    element.rancho_id ==
                                                    ProvGranja
                                                        .listaRancho[index]
                                                        .id,
                                              )
                                              .toList();
                                      ProvGranja.ranchoUsuario =
                                          ProvGranja.listaRancho[index]
                                              .toJson();
                                      if (ProvGranja.listaGranjaFiltro.length ==
                                          1) {
                                        ProvGranja.granjaUsuario =
                                            ProvGranja.listaGranjaFiltro[0]
                                                .toJson();
                                        GranjaController().cargarPantalla(
                                          context,
                                          ProvGranja,
                                        );
                                      } else {
                                        Navigator.pushNamed(context, 'granjas');
                                        ProvGranja.botonActivo = false;
                                      }
                                    });
                                  },
                          dense: AppTheme.lightTheme.listTileTheme.dense,
                          leading: const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Icon(
                              MyFlutterApp.barn,
                              color: AppTheme.primary,
                              size: 30,
                            ),
                          ),
                          title: Text(
                            '${ProvGranja.listaRancho[index].nombre}',
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
                  "Sin ranchos",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
    );
  }

  Future cerrarSecion(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Draggable(
          feedback: Container(),
          child: AlertDialog(
            backgroundColor: Colors.white,
            titlePadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: const Color.fromARGB(31, 94, 92, 92),
                  toolbarHeight: MediaQuery.of(context).size.height * 0.05,
                  title: Text(
                    'Cerrar seción',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  automaticallyImplyLeading: false,
                ),
              ],
            ),
            content: const Text("¿Seguro que quiere cerrar sesión?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed:
                    () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      'login',
                      (route) => false,
                    ),
                //Navigator.pushReplacementNamed(context, 'login'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
