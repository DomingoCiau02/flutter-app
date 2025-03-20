// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/models/models.dart';
import '../provider/granja_provider.dart';
import '../router/url.dart';

class PesajeAnimalController {
  //funcion que se encarga de traer los datos de la raza, tipo de animal y cambia la pantalla
  pantallaPesajeAnimal(BuildContext context, GranjaProvider ProvGranja) async {
    await getTipoAnimal(ProvGranja);
    await getRazaAnimal(ProvGranja);
    Navigator.pushNamed(context, 'vistaPesajeAnimal');
    ProvGranja.botonActivo = false;
  }

  Future<void> getTipoAnimal(GranjaProvider ProvGranja) async {
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);

    ProvGranja.listaTipoAnimal.clear();

    final uri = Uri.parse(
      '${Links.apiTiposAnimal}?api_key=${ProvGranja.listaUser["api_key"].toString()}',
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
          ProvGranja.listaTipoAnimal.add(
            TipoAnimal(
              element['id'],
              element['nombre'],
              element['estatus'],
              element['database_id'],
            ),
          );
        }
      }
    } catch (e) {
      print('Error: $e');
      ProvGranja.botonActivo = false;
    }
  }

  Future<void> getRazaAnimal(GranjaProvider ProvGranja) async {
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);

    ProvGranja.listaRazaAnimal.clear();

    final uri = Uri.parse(
      '${Links.apiRazasAnimal}?api_key=${ProvGranja.listaUser["api_key"].toString()}',
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
          ProvGranja.listaRazaAnimal.add(
            RazaAnimal(
              element['id'],
              element['nombre'],
              element['genotipo'],
              element['fenotipo'],
              element['clasificacion_animal_id'],
              element['database_id'],
            ),
          );
        }
      }
    } catch (e) {
      print('Error: $e');
      ProvGranja.botonActivo = false;
    }
  }

  Future<void> getTarjetaAnimal(GranjaProvider ProvGranja) async {
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);

    ProvGranja.listaTargetaAnimal.clear();

    final uri = Uri.parse(
      '${Links.apiTargetaAnimal}?api_key=${ProvGranja.listaUser["api_key"].toString()}',
    );

    final request = await httpClient.getUrl(uri);

    request.headers.set('Content-Type', 'application/json; charset=UTF-8');

    try {
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      if (response.statusCode == 200) {
        final jasonData = jsonDecode(responseBody);
        jasonData.forEach((element) {
          if (element['granja_id'] == ProvGranja.granjaUsuario['id']) {
            ProvGranja.listaTargetaAnimal.add(
              TarjetaAnimal(
                element['id'],
                element['rancho_id'],
                element['granja_id'],
                element['rancho_division_id'],
                element['lote_animal_id'],
                element['nombre'],
                element['sexo'],
                element['raza_animal_id'],
                element['clasificacion_animal_id'],
                element['tipo_animal_id'],
                element['registro'],
                element['proposito'],
                double.parse(element['costo']),
                element['observaciones'],
              ),
            );
          }
        });
      }
    } catch (e) {
      print('Error: $e');
      ProvGranja.botonActivo = false;
    }
  }

  Future<void> postPesajeAnimal(
    PesajeAnimal pesaje,
    GranjaProvider ProvGranja,
    String fecha,
    TarjetaAnimal tarjetaAnimal,
    TipoPesaje tipoPesaje,
  ) async {
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
    List<Map<String, dynamic>> pesos =
        pesaje.listaDetallesPesaje!.map((data) {
          return {'sexo': data['sexo'], 'peso': data['peso']};
        }).toList();

    try {
      final uri = Uri.parse(
        '${Links.apiPesajesAnimal}?api_key=${ProvGranja.listaUser["api_key"].toString()}',
      );
      final request = await httpClient.postUrl(uri);

      request.headers.set('Content-Type', 'application/json; charset=UTF-8');

      final pesajeNuevo = {
        "fecha": pesaje.fecha,
        "tipo_pesaje_id": tipoPesaje.id,
        "tarjeta_animal_id": tarjetaAnimal.id,
        "detalles_animal": pesos,
      };

      final requestBodyJson = jsonEncode(pesajeNuevo);
      request.write(requestBodyJson);

      final response = await request.close();
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
