// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/provider/granja_provider.dart';
import '../models/models.dart';
import '../router/url.dart';
import 'controller.dart';

class RanchoController {
  //funcion que se encarga de traer la lista de ranchos y la debuelve
  Future getRanchos(BuildContext context, GranjaProvider ProvGranja) async {
    List<Granja> granja = [];
    List<Rancho> rancho = [];
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.parse(
      '${Links.apiRanchos}?api_key=${ProvGranja.listaUser["api_key"].toString()}',
    );
    final request = await httpClient.getUrl(uri);

    request.headers.set('Content-Type', 'application/json; charset=UTF-8');

    try {
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      if (response.statusCode == 200) {
        final jasonData = jsonDecode(responseBody);
        for (var element in jasonData) {
          Rancho ra = Rancho(
            element["id"],
            element["nombre"],
            element["estatus"],
            element["database_id"],
          );
          rancho.add(ra);

          var variableGranja = element["granjas"];

          variableGranja.forEach((elementos) {
            if (elementos["estatus"] as bool != false) {
              Granja gra = Granja(
                elementos["id"],
                elementos["nombre"],
                elementos["tipo_division"],
                elementos["rancho_id"],
                elementos["database_id"],
                elementos["estatus"],
                elementos["created_at"],
                elementos["updated_at"],
              );
              granja.add(gra);
            }
          });
        }

        ProvGranja.listaRancho.clear();
        ProvGranja.listaGranja.clear();
        ProvGranja.listaRancho = rancho;
        ProvGranja.listaGranja = granja;

        if (ProvGranja.listaRancho.length == 1) {
          ProvGranja.ranchoUsuario = ProvGranja.listaRancho[0].toJson();
          ProvGranja.listaGranjaFiltro =
              ProvGranja.listaGranja
                  .where(
                    (element) =>
                        element.rancho_id == ProvGranja.ranchoUsuario['id'],
                  )
                  .toList();
          if (ProvGranja.listaGranjaFiltro.length == 1) {
            ProvGranja.granjaUsuario = ProvGranja.listaGranjaFiltro[0].toJson();
            GranjaController().cargarPantalla(context, ProvGranja);
          } else {
            Navigator.pushReplacementNamed(context, 'granjas');
            ProvGranja.botonActivo = false;
          }
        } else {
          Navigator.pushReplacementNamed(context, 'rancho');
          ProvGranja.botonActivo = false;
        }
      } else {
        throw Exception("Error en la obtecion");
      }
    } catch (e) {
      print('Error2: $e');
      ProvGranja.botonActivo = false;
    }
  }
}
