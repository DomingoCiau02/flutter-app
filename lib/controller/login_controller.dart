// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/controller/rancho_controller.dart';
import 'package:app/router/url.dart';
import '../models/usuario.dart';
import '../provider/granja_provider.dart';

class LoginController {
  Future<void> inicioSesion(
    BuildContext context,
    String email,
    String password,
    GranjaProvider ProvGranja,
  ) async {
    bool bandera = false;
    final httpClient =
        HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);

    final uri = Uri.parse(Links.apiLogin);
    final request = await httpClient.postUrl(uri);

    request.headers.set('Content-Type', 'application/json; charset=UTF-8');

    final requestBody = {'usuario': email, 'password': password};
    try {
      final requestBodyJson = jsonEncode(requestBody);
      request.write(requestBodyJson);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      httpClient.close();

      if (response.statusCode == 200) {
        final jasonData = jsonDecode(responseBody);

        Usuario usuario = Usuario(
          jasonData["id"],
          jasonData["usuario"],
          jasonData["contacto_id"],
          jasonData["correo"],
          jasonData["contacto"],
          jasonData["api_key"],
          jasonData["cajero"]["usuario"]["uuid"],
        );

        ProvGranja.listaUser = usuario.toJson();
        bandera = true;
      } else if (response.statusCode == 401) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder:
              (context) => const AlertDialog(
                title: Text('Error de inicio de sesión'),
                content: Text('Las credenciales ingresadas son incorrectas'),
              ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error en $e');
      ProvGranja.botonActivo = false;
    }

    //redireccion a la pantalla de Ranchos
    try {
      if (bandera) {
        // ignore: use_build_context_synchronously
        await RanchoController().getRanchos(context, ProvGranja);
      } else {
        ProvGranja.botonActivo = false;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error en $e');
      ProvGranja.botonActivo = false;
    }
  }
}
