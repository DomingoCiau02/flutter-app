// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/models/models.dart';
import 'package:intl/intl.dart';
import '../provider/granja_provider.dart';
import '../router/url.dart';

class AlimentacionController {
  Future getTiposAlimento(GranjaProvider ProvGranja) async {
    List<TipoAlimento> tiposAlimento = [];
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.parse(
      '${Links.apiTipoAlimento}?api_key=${ProvGranja.listaUser["api_key"].toString()}&granja_id=${ProvGranja.granjaUsuario["id"].toString()}',
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
          tiposAlimento.add(
            TipoAlimento(
              element["id"],
              element["nombre"],
              element["producto_id"],
              element["database_id"],
              element["estatus"],
              DateTime.parse(element["created_at"]),
              DateTime.parse(element["updated_at"]),
            ),
          );
        }
        ProvGranja.listaTiposAlimento.clear();
        ProvGranja.listaTiposAlimento = tiposAlimento;
      } else {
        throw Exception("Error en la obtecion");
      }
    } catch (e) {
      // ignore:
      print('Error2: $e');
    }
  }

  //metodo que se encarga de subir las alimentaciones  del rancho.
  Future<void> postAlimentacion(
    BuildContext context,
    GranjaProvider ProvGranja,
    List<DetalleAlimDivision> alimentos,
  ) async {
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
    List<Map<String, dynamic>> cantidades =
        alimentos.map((data) {
          return {
            'cantidad': data.cantidad,
            'tipo_alimento_id': data.tipoAlimento.id,
            'rancho_division_id': data.ranchoDivision.id,
          };
        }).toList();

    try {
      final uri = Uri.parse(
        '${Links.apiAlimentosRancho}?api_key=${ProvGranja.listaUser["api_key"].toString()}',
      );
      final request = await httpClient.postUrl(uri);

      request.headers.set('Content-Type', 'application/json; charset=UTF-8');

      final nuevoAlimentacion = {
        "granja_id": ProvGranja.granjaUsuario["id"],
        "fecha": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "hora": DateFormat('HH:mm').format(DateTime.now()),
        "detalles": cantidades,
      };

      final requestBodyJson = jsonEncode(nuevoAlimentacion);
      request.write(requestBodyJson);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      if (response.statusCode != 200) {
        print(response.statusCode);
      }
    } catch (e) {
      print('Error during POST request: $e');
    }
    getAlimentacion(ProvGranja);
    Navigator.pop(context);
    ProvGranja.botonActivo = false;
  }

  Future<void> getAlimentacion(GranjaProvider ProvGranja) async {
    List<AlimRanchoDivision> alimentacion = [];
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.parse(
      '${Links.apiAlimentosRancho}?api_key=${ProvGranja.listaUser["api_key"].toString()}',
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
          if (element["granja_id"] == ProvGranja.granjaUsuario["id"]) {
            alimentacion.add(
              AlimRanchoDivision(
                element["id"],
                element["granja_id"],
                element["database_id"],
                element["estatus"],
                element["fecha"],
                element["hora"],
              ),
            );
          }
        }
        ProvGranja.listaAlimentacion.clear();
        ProvGranja.listaAlimentacion = alimentacion;
        ProvGranja.botonActivo = false;
      } else {
        throw Exception("Error en la obtecion");
      }
    } catch (e) {
      // ignore:
      print('Error2: $e');
    }
  }

  Future<void> getDetallesAlim(
    GranjaProvider ProvGranja,
    BuildContext context,
  ) async {
    List<DetalleAlimDivision> detalles = [];
    int indice = 0;
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.parse(
      '${Links.apiAlimentosRancho}/${ProvGranja.alimSeleccionado["id"]}?api_key=${ProvGranja.listaUser["api_key"].toString()}',
    );
    final request = await httpClient.getUrl(uri);

    request.headers.set('Content-Type', 'application/json; charset=UTF-8');

    try {
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      if (response.statusCode == 200) {
        final jasonData = jsonDecode(responseBody);
        for (var element in jasonData['detalles']) {
          detalles.add(
            DetalleAlimDivision(
              element['id'],
              double.parse(element['cantidad']),
              ProvGranja.listaTiposAlimento.firstWhere(
                (objeto) => objeto.id == element['tipo_alimento_id'],
              ),
              element['alimento_rancho_division_id'],
              ProvGranja.listaDivisionesRancho.firstWhere(
                (objeto) => objeto.id == element['rancho_division_id'],
              ),
              indice,
            ),
          );
          indice++;
        }
        ProvGranja.listaDetalleAlimentacion.clear();
        ProvGranja.listaDetalleAlimentacion = detalles;
        Navigator.pushNamed(context, 'Vista_alimentacion');
        ProvGranja.botonActivo = false;
      } else {
        throw Exception("Error en la obtecion");
      }
    } catch (e) {
      // ignore:
      print('Error: $e');
    }
  }

  Future<void> updateAlimentacion(
    BuildContext context,
    GranjaProvider ProvGranja,
  ) async {
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
    List<Map<String, dynamic>> cantidades =
        ProvGranja.listaDetalleAlimentacion.map((data) {
          return {
            'cantidad': data.cantidad,
            'tipo_alimento_id': data.tipoAlimento.id,
            'rancho_division_id': data.ranchoDivision.id,
          };
        }).toList();

    try {
      final uri = Uri.parse(
        '${Links.apiAlimentosRancho}/${ProvGranja.alimSeleccionado["id"]}?api_key=${ProvGranja.listaUser["api_key"].toString()}',
      );
      final request = await httpClient.putUrl(uri);

      request.headers.set('Content-Type', 'application/json; charset=UTF-8');

      final nuevoAlimentacion = {
        "granja_id": ProvGranja.granjaUsuario["id"],
        "fecha": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "hora": DateFormat('HH:mm').format(DateTime.now()),
        "detalles": cantidades,
      };

      final requestBodyJson = jsonEncode(nuevoAlimentacion);
      request.write(requestBodyJson);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      if (response.statusCode != 200) {
        print(response.statusCode);
      }
    } catch (e) {
      print('Error during POST request: $e');
      ProvGranja.botonActivo = false;
    }
    getAlimentacion(ProvGranja);
    Navigator.pop(context);
    ProvGranja.botonActivo = false;
  }
}
