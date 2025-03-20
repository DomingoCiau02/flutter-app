import 'package:app/models/models.dart';

class DetalleAlimDivision {
  int id;
  double cantidad;
  TipoAlimento tipoAlimento;
  int alimentoRanchoDivisionId;
  RanchoDivision ranchoDivision;
  int indice;

  DetalleAlimDivision(
    this.id,
    this.cantidad,
    this.tipoAlimento,
    this.alimentoRanchoDivisionId,
    this.ranchoDivision,
    this.indice,
  );

  DetalleAlimDivision.fromJson(Map<String, dynamic> parsedJson)
    : id = parsedJson['id'],
      cantidad = parsedJson['cantidad'],
      tipoAlimento = parsedJson['tipo_alimento'],
      alimentoRanchoDivisionId = parsedJson['alimento_rancho_division_id'],
      ranchoDivision = parsedJson['rancho_division'],
      indice = parsedJson["indice"];

  Map<String, dynamic> toJson() => {
    'id': id,
    'cantidad': cantidad,
    'tipo_alimento': tipoAlimento,
    'alimentoRanchoDivisionId': alimentoRanchoDivisionId,
    'rancho_division': ranchoDivision,
  };
}
