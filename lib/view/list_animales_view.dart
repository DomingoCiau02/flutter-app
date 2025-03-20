// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../icons/my_flutter_app_icons.dart';
import '../provider/granja_provider.dart';
import '../theme/app_theme.dart';

class ListAnimalesView extends StatefulWidget {
  const ListAnimalesView({super.key});

  @override
  State<ListAnimalesView> createState() => _ListAnimalesViewState();
}

class _ListAnimalesViewState extends State<ListAnimalesView> {
  @override
  Widget build(BuildContext context) {
    final ProvGranja = Provider.of<GranjaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Lista animales",
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
      ),
      body: ProvGranja.listaTargetaAnimal.isNotEmpty
          ? ListView.builder(
              itemCount: ProvGranja.listaTargetaAnimal.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      child: ListTile(
                        tileColor: AppTheme.lightTheme.listTileTheme.tileColor,
                        contentPadding:
                            AppTheme.lightTheme.listTileTheme.contentPadding,
                        shape: AppTheme.lightTheme.listTileTheme.shape,
                        onTap: ProvGranja.botonActivo
                            ? null
                            : () {
                                //aqui se hace un flitro que se encarga de buscar en la lista de las granjas solo aquellos elementos que tengan un rancho_i igual al id del rancho que se selecciona
                                setState(
                                  () {
                                    //ProvGranja.botonActivo = true;
                                  },
                                );
                              },
                        dense: AppTheme.lightTheme.listTileTheme.dense,
                        leading: const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(
                            MyFlutterApp.cow,
                            color: AppTheme.primary,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          ProvGranja.listaTargetaAnimal[index].nombre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                        trailing: Text(
                          ProvGranja.listaTargetaAnimal[index].proposito,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.043,
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
                "Sin animales registrados",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
