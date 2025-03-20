// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../provider/granja_provider.dart';
import '../router/url.dart';
import 'controller.dart';

class GranjaController {
  Future<void> cargarPantalla(
      BuildContext context, GranjaProvider ProvGranja) async {
    bool bandera = false;
    final httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.parse(
        '${Links.apiGranjas}/${ProvGranja.granjaUsuario["id"]}?api_key=${ProvGranja.listaUser["api_key"].toString()}&granja_id=${ProvGranja.granjaUsuario["id"].toString()}');
    final request = await httpClient.getUrl(uri);

    request.headers.set('Content-Type', 'application/json; charset=UTF-8');

    try {
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      if (response.statusCode == 200) {
        final jasonData = jsonDecode(responseBody);

        for (var element in jasonData["cajero_granja"]) {
          if (element["cajero_id"] == ProvGranja.listaUser["id"]) {
            bandera = true;
          }
        }
        ProvGranja.botonActivo = false;
      } else {
        throw Exception("Error en la obtecion");
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error2: $e');
      ProvGranja.botonActivo = false;
    }

    if (bandera) {
      PotreroController().datoPesaje(ProvGranja, context, true);
      AlimentacionController().getTiposAlimento(ProvGranja);
      AlimentacionController().getAlimentacion(ProvGranja);
      PesajeAnimalController().getTarjetaAnimal(ProvGranja);
      getRanchoDivision(ProvGranja);
    } else {
      var snackBar = SnackBar(
        backgroundColor: Colors.grey[500],
        content: const Text(
          'Sin acceso.',
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 750),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future getRanchoDivision(GranjaProvider ProvGranja) async {
    List<RanchoDivision> divisionesRancho = [];
    final httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.parse(
        '${Links.apiRanchoDivicion}?api_key=${ProvGranja.listaUser["api_key"].toString()}&granja_id=${ProvGranja.granjaUsuario["id"].toString()}');
    final request = await httpClient.getUrl(uri);

    request.headers.set('Content-Type', 'application/json; charset=UTF-8');

    try {
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      if (response.statusCode == 200) {
        final jasonData = jsonDecode(responseBody);
        for (var element in jasonData) {
          if (element["granja_id"] == ProvGranja.granjaUsuario["id"]) {
            RanchoDivision ra = RanchoDivision(
                element["id"],
                element["nombre"],
                element["database_id"],
                element["hectarea"],
                element["capacidad_hectarea"],
                element["uso_suelo"],
                element["granja_id"]);
            divisionesRancho.add(ra);
          }
        }
        ProvGranja.listaDivisionesRancho.clear();
        ProvGranja.listaDivisionesRancho = divisionesRancho;
      } else {
        throw Exception("Error en la obtecion");
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error2: $e');
      ProvGranja.botonActivo = false;
    }
  }
}
