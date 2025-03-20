// ignore_for_file: non_constant_identifier_names
class Rancho {
  int? id;
  String? nombre;
  bool? estatus;
  int? database_id;

  Rancho(this.id, this.nombre, this.estatus, this.database_id);

  Rancho.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        nombre = parsedJson["nombre"],
        estatus = parsedJson["estatus"],
        database_id = parsedJson["database_id"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "estatus": estatus,
        "database_id": database_id,
      };
}
