// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../provider/granja_provider.dart';
import '../router/url.dart';

class PesosController {
  //metodo que trae los pesajes dependiendo del id del tipo de pesaje seleccionado y los guarda en el provider
  Future<void> getPesajes(
      BuildContext context, GranjaProvider ProvGranja) async {
    List<DetallePesoDivision> listaDetalles = [];
    int posicion = 0;

    final httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    try {
      final uri = Uri.parse(
          '${Links.apiPesaje}/${ProvGranja.pesajeSeleccionado["id"]}?api_key=${ProvGranja.listaUser["api_key"].toString()}');
      final request = await httpClient.getUrl(uri);

      request.headers.set('Content-Type', 'application/json; charset=UTF-8');

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      if (response.statusCode == 200) {
        final jasonData = jsonDecode(responseBody);
        for (var elemento in jasonData["detalles"]) {
          listaDetalles.add(
            DetallePesoDivision(
              elemento["id"],
              double.parse(elemento["peso"]),
              elemento["sexo"],
              elemento["pesaje_rancho_division_id"],
              elemento["estatus"],
              DateTime.parse(elemento["created_at"]),
              DateTime.parse(elemento["updated_at"]),
              posicion,
            ),
          );
          posicion++;
        }

        ProvGranja.listaDetallesPesaje.clear();
        ProvGranja.listaDetallesPesaje = listaDetalles;
        Navigator.pushNamed(context, 'PesosLista');
      }
    } catch (e) {
      print('Error during POST request: $e');
      ProvGranja.botonActivo = false;
    }
    ProvGranja.botonActivo = false;
  }

  //metodo que se encarga de subir los pesajes de la división.
  Future<void> postPesaje(
      GranjaProvider ProvGranja,
      DateTime fecha,
      TipoPesaje? tipo,
      RanchoDivision? divicionSeleccionado,
      List<Map<String, dynamic>> Pesajes) async {
    final httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    List<Map<String, dynamic>> pesos = Pesajes.map((data) {
      return {
        'sexo': data['sexo'],
        'peso': data['peso'],
      };
    }).toList();

    try {
      final uri = Uri.parse(
          '${Links.apiPesaje}?api_key=${ProvGranja.listaUser["api_key"].toString()}');
      final request = await httpClient.postUrl(uri);

      request.headers.set('Content-Type', 'application/json; charset=UTF-8');

      final pesajeNuevo = {
        "rancho_division_id": divicionSeleccionado!.id,
        "fecha": fecha.toIso8601String(),
        "tipo_pesaje_id": tipo!.id,
        "detalles": pesos
      };

      final requestBodyJson = jsonEncode(pesajeNuevo);
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
    ProvGranja.botonActivo = false;
  }

  //metodo que se encarga de subir los pesajes  del rancho ya modificados.
  Future<void> updatePesaje(GranjaProvider ProvGranja, DateTime fecha,
      TipoPesaje? tipo, RanchoDivision? divicionSeleccionado) async {
    final httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    List<Map<String, dynamic>> pesos = ProvGranja.listaDetallesPesaje.map(
      (data) {
        return {
          'sexo': data.sexo,
          'peso': data.peso,
        };
      },
    ).toList();

    try {
      final uri = Uri.parse(
          '${Links.apiPesaje}/${ProvGranja.pesajeSeleccionado["id"]}?api_key=${ProvGranja.listaUser["api_key"].toString()}');
      final request = await httpClient.putUrl(uri);

      request.headers.set('Content-Type', 'application/json; charset=UTF-8');

      final pesajeNuevo = {
        "rancho_division_id": divicionSeleccionado!.id,
        "fecha": fecha.toIso8601String(),
        "tipo_pesaje_id": tipo!.id,
        "detalles": pesos
      };

      final requestBodyJson = jsonEncode(pesajeNuevo);
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
    ProvGranja.botonActivo = false;
  }
}
