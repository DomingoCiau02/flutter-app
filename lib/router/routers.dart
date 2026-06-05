import 'package:flutter/material.dart';
import 'package:app/view/view.dart';

import '../models/menu_model.dart';

class AppRoutes {
  static const rutaInicial = 'NuevoPesajeGeneral';

  static final menuOpciones = <MenuOpcion>[
    MenuOpcion(ruta: 'login', nombre: 'Vista_Login', vista: const LoginView()),
    MenuOpcion(ruta: 'rancho', nombre: 'Vista_Rancho', vista: const RanchoView()),
    MenuOpcion(ruta: 'granjas', nombre: 'Vista_Granjas', vista: const GranjaView()),
    MenuOpcion(ruta: 'potreros', nombre: 'Vista_Potreros', vista: const PotreroView()),
    MenuOpcion(ruta: 'PesosLista', nombre: 'Vista_lista_Pesos', vista: const PesosView()),
    MenuOpcion(ruta: 'NuevoPesajeGeneral', nombre: 'Vista_nuevo_peso', vista: const AddPesajeGralView()),
    MenuOpcion(ruta: 'NuevoAlimentacionGral', nombre: 'Vista_nuevo_alimentacion', vista: const AddAlimentacionGralView()),
    MenuOpcion(ruta: 'Vista_alimentacion', nombre: 'Vista_detalles_alim', vista: const AlimView()),
    MenuOpcion(ruta: 'vistaPesajeAnimal', nombre: 'vista_nuevo_pesaje_animal', vista: const NewPesajeAnimalView()),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRutas() {
    Map<String, Widget Function(BuildContext)> appRutas = {};

    for (var opcion in menuOpciones) {
      appRutas.addAll({opcion.ruta: (BuildContext context) => opcion.vista});
    }
    return appRutas;
  }
}
