// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/models/models.dart';
import '../provider/granja_provider.dart';
import '../router/url.dart';

class PotreroController {
  Future<void> datoPesaje(
    GranjaProvider ProvGranja,
    BuildContext context,
    bool bandera,
  ) async {
    List<PesajeRachoDivision> listaPesajesDivicion = [];
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);

    try {
      final uri = Uri.parse(
        '${Links.apiPesaje}?api_key=${ProvGranja.listaUser["api_key"].toString()}',
      );
      final request = await httpClient.getUrl(uri);

      request.headers.set('Content-Type', 'application/json; charset=UTF-8');

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();
      if (response.statusCode == 200) {
        final jasonData = jsonDecode(responseBody);

        for (var element in jasonData) {
          if (element["rancho_division"]["granja_id"] ==
              ProvGranja.granjaUsuario["id"]) {
            listaPesajesDivicion.add(
              PesajeRachoDivision(
                element["id"],
                element["tipo_pesaje_id"],
                element["rancho_division_id"],
                DateTime.parse(element["fecha"]),
                element["database_id"],
                element["estatus"],
                element["rancho_division"]["nombre"],
                element["rancho_division"]["granja_id"],
                element["tipo_pesaje"]["nombre"],
              ),
            );
          }
        }
        ProvGranja.listaPesajes.clear();
        ProvGranja.listaPesajes = listaPesajesDivicion;
        if (bandera) {
          Navigator.pushNamed(context, 'potreros');
          ProvGranja.botonActivo = false;
        } else {
          Navigator.pop(context);
          ProvGranja.botonActivo = false;
        }
      }
    } catch (e) {
      print('Error during POST request: $e');
      ProvGranja.botonActivo = false;
    }
  }

  Future<void> getTipoPesaje(GranjaProvider ProvGranja) async {
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
    List<TipoPesaje> listaTipoPesaje = [];

    try {
      final uri = Uri.parse(
        '${Links.apiTipoPesaje}?api_key=z0LxEbQGghVeX1dYNPlBqHHOaCrkuLSs',
      );
      final request = await httpClient.getUrl(uri);

      request.headers.set('Content-Type', 'application/json; charset=UTF-8');

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();
      if (response.statusCode == 200) {
        final jasonData = jsonDecode(responseBody);

        jasonData.forEach((element) {
          TipoPesaje tipos = TipoPesaje(
            element['id'],
            element['nombre'],
            element['dias'],
            element['database_id'],
            element['estatus'],
          );
          listaTipoPesaje.add(tipos);
        });
        ProvGranja.listaTipoPesaje.clear();
        ProvGranja.listaTipoPesaje = listaTipoPesaje;
        ProvGranja.botonActivo = false;
      }
    } catch (e) {
      print('Error during POST request: $e');
      ProvGranja.botonActivo = false;
    }
  }
}
