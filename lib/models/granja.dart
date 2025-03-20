// ignore_for_file: non_constant_identifier_names

class Granja {
  int? id;
  String? nombre;
  String? tipo_division;
  int? rancho_id;
  int? database_id;
  bool? estatus;
  String? created_at;
  String? update_at;

  Granja(this.id, this.nombre, this.tipo_division, this.rancho_id,
      this.database_id, this.estatus, this.created_at, this.update_at);

  Granja.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        nombre = parsedJson["nombre"],
        tipo_division = parsedJson["tipo_division"],
        rancho_id = parsedJson["rancho_id"],
        database_id = parsedJson["database_id"],
        estatus = parsedJson["estatus"],
        created_at = parsedJson["created_at"],
        update_at = parsedJson["update_at"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "tipo_division": tipo_division,
        "rancho_id": rancho_id,
        "estatus": estatus,
        "database_id": database_id,
        "created_at": created_at,
        "update_at": update_at,
      };
}
