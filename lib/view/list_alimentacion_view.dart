// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:app/controller/alimentacion_controller.dart';
import 'package:provider/provider.dart';
import '../icons/my_flutter_app_icons.dart';
import '../provider/granja_provider.dart';
import '../theme/app_theme.dart';

class ListAlimentacionView extends StatefulWidget {
  const ListAlimentacionView({super.key});

  @override
  State<ListAlimentacionView> createState() => _ListAlimentacionViewState();
}

class _ListAlimentacionViewState extends State<ListAlimentacionView> {
  @override
  Widget build(BuildContext context) {
    final ProvGranja = Provider.of<GranjaProvider>(context);
    //ProvGranja.botonActivo = false;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Alimentación",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            Text(
              ProvGranja.granjaUsuario["nombre"],
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'NuevoAlimentacionGral');
            },
            icon: const Icon(Icons.add_outlined, size: 34),
          ),
        ],
      ),
      //se desplirga una lista de con la fecha de los pesajes realizados
      body:
          ProvGranja.listaAlimentacion.isNotEmpty
              ? ListView.builder(
                itemCount: ProvGranja.listaAlimentacion.length,
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
                                      //ProvGranja.botonActivo = true;
                                      ProvGranja.alimSeleccionado =
                                          ProvGranja.listaAlimentacion[index]
                                              .toJson();
                                      AlimentacionController().getDetallesAlim(
                                        ProvGranja,
                                        context,
                                      );
                                    });
                                  },

                          dense: AppTheme.lightTheme.listTileTheme.dense,

                          leading: const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Icon(
                              MyFlutterApp.wheat,
                              color: AppTheme.primary,
                              size: 35,
                            ),
                          ),

                          title: Text(
                            "Alimentación",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.043,
                            ),
                          ),
                          subtitle: Text(
                            ProvGranja.listaAlimentacion[index].fecha,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.038,
                            ),
                          ),

                          trailing: Text(
                            ProvGranja.listaAlimentacion[index].hora,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.043,
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
                  "Sin alimentación registrado",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
    );
  }
}
