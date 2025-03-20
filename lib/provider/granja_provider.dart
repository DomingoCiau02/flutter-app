// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:app/models/models.dart';

class GranjaProvider with ChangeNotifier {
  //---------------variables de funciones-------------------------
  bool _botonActivo = false;

  //---------------elementos seleccionados por el usuario---------
  Map<String, dynamic> _ranchoUsuario = {};
  Map<String, dynamic> _granjaUsuario = {};
  Map<String, dynamic> _listaUser = {};
  Map<String, dynamic> _pesajeSeleccionado = {};
  Map<String, dynamic> _alimSeleccionado = {};

  //------------------lista de objetos-------------------------

  //lista de ranchos del usuario
  List<Rancho> _listaRancho = [];
  //lista de granjas del usuario
  List<Granja> _listaGranja = [];
  //lista de granjas separadas por id rancho
  List<Granja> _listaGranjaFiltro = [];
  //lista diviciones de una granja
  List<RanchoDivision> _listaDivisionesRancho = [];
  //lista de los tipos de pesaje del rancho
  List<TipoPesaje> _listaTiposPesaje = [];
  // lista de los pesajes de la divion
  List<PesajeRachoDivision> _listaPesajes = [];
  //detalles de los pesajes de por fecha aqui se encuentra la lista de pesos y sexo
  List<DetallePesoDivision> _listaDetallesPesaje = [];
  //lista de los tipos de alimento
  List<TipoAlimento> _listaTiposAlimento = [];
  //lista de alimentaciones de la granja
  List<AlimRanchoDivision> _listaAlimentacion = [];
  //lista de detalles alimentacion
  List<DetalleAlimDivision> _listaDetalleAlimentacion = [];
  //lista de tipos de animales de la granja
  List<TipoAnimal> _listaTipoAnimal = [];
  //lista de las razas del animal
  List<RazaAnimal> _listaRazaAnimal = [];
  //lista de las clasificacion animales
  List<ClasificacionAnimal> _listaClasificacionAnimal = [];
  //lista de animales
  List<TarjetaAnimal> _listaTargetaAnimal = [];

  bool get botonActivo => _botonActivo;
  set botonActivo(bool valor) {
    _botonActivo = valor;
    notifyListeners();
  }

  Map<String, dynamic> get alimSeleccionado => _alimSeleccionado;
  set alimSeleccionado(Map<String, dynamic> valor) {
    _alimSeleccionado = valor;
    notifyListeners();
  }

  Map<String, dynamic> get pesajeSeleccionado => _pesajeSeleccionado;
  set pesajeSeleccionado(Map<String, dynamic> valor) {
    _pesajeSeleccionado = valor;
    notifyListeners();
  }

  Map<String, dynamic> get ranchoUsuario => _ranchoUsuario;
  set ranchoUsuario(Map<String, dynamic> valor) {
    _ranchoUsuario = valor;
    notifyListeners();
  }

  Map<String, dynamic> get granjaUsuario => _granjaUsuario;
  set granjaUsuario(Map<String, dynamic> valor) {
    _granjaUsuario = valor;
    notifyListeners();
  }

  Map<String, dynamic> get listaUser => _listaUser;
  set listaUser(Map<String, dynamic> valor) {
    _listaUser = valor;
    notifyListeners();
  }

  List<Granja> get listaGranja => _listaGranja;
  set listaGranja(List<Granja> valor) {
    _listaGranja = valor;
    notifyListeners();
  }

  List<Rancho> get listaRancho => _listaRancho;
  set listaRancho(List<Rancho> valor) {
    _listaRancho = valor;
    notifyListeners();
  }

  List<Granja> get listaGranjaFiltro => _listaGranjaFiltro;
  set listaGranjaFiltro(List<Granja> valor) {
    _listaGranjaFiltro = valor;
    notifyListeners();
  }

  List<RanchoDivision> get listaDivisionesRancho => _listaDivisionesRancho;
  set listaDivisionesRancho(List<RanchoDivision> valor) {
    _listaDivisionesRancho = valor;
    notifyListeners();
  }

  List<TipoPesaje> get listaTipoPesaje => _listaTiposPesaje;
  set listaTipoPesaje(List<TipoPesaje> valor) {
    _listaTiposPesaje = valor;
    notifyListeners();
  }

  List<PesajeRachoDivision> get listaPesajes => _listaPesajes;
  set listaPesajes(List<PesajeRachoDivision> valor) {
    _listaPesajes = valor;
    notifyListeners();
  }

  List<DetallePesoDivision> get listaDetallesPesaje => _listaDetallesPesaje;
  set listaDetallesPesaje(List<DetallePesoDivision> valor) {
    _listaDetallesPesaje = valor;
    notifyListeners();
  }

  List<TipoAlimento> get listaTiposAlimento => _listaTiposAlimento;
  set listaTiposAlimento(List<TipoAlimento> valor) {
    _listaTiposAlimento = valor;
    notifyListeners();
  }

  List<AlimRanchoDivision> get listaAlimentacion => _listaAlimentacion;
  set listaAlimentacion(List<AlimRanchoDivision> valor) {
    _listaAlimentacion = valor;
    notifyListeners();
  }

  List<DetalleAlimDivision> get listaDetalleAlimentacion =>
      _listaDetalleAlimentacion;
  set listaDetalleAlimentacion(List<DetalleAlimDivision> valor) {
    _listaDetalleAlimentacion = valor;
    notifyListeners();
  }

  List<TipoAnimal> get listaTipoAnimal => _listaTipoAnimal;
  set listaTipoAnimal(List<TipoAnimal> valor) {
    _listaTipoAnimal = valor;
    notifyListeners();
  }

  List<RazaAnimal> get listaRazaAnimal => _listaRazaAnimal;
  set listaRazaAnimal(List<RazaAnimal> valor) {
    _listaRazaAnimal = valor;
    notifyListeners();
  }

  List<ClasificacionAnimal> get listaClasificacionAnimal =>
      _listaClasificacionAnimal;
  set listaClasificacionAnimal(List<ClasificacionAnimal> valor) {
    _listaClasificacionAnimal = valor;
    notifyListeners();
  }

  List<TarjetaAnimal> get listaTargetaAnimal => _listaTargetaAnimal;
  set listaTargetaAnimal(List<TarjetaAnimal> valor) {
    _listaTargetaAnimal = valor;
    notifyListeners();
  }
}
