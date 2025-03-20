// ignore_for_file: non_constant_identifier_names

class TipoPesaje {
  int? id;
  String? nombre;
  int? dias;
  int? database_id;
  bool? estatus;

  TipoPesaje(this.id, this.nombre, this.dias, this.database_id, this.estatus);

  TipoPesaje.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        nombre = parsedJson["nombre"],
        dias = parsedJson["dias"],
        database_id = parsedJson["database_id"],
        estatus = parsedJson["estatus"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "dias": dias,
        "database_id": database_id,
        "estatud": estatus
      };
}
