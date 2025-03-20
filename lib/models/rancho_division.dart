// ignore_for_file: non_constant_identifier_names, file_names

class RanchoDivision {
  int id;
  String nombre;
  int database_id;
  String hectarea;
  int capacidad_hectarea;
  String uso_suelo;
  int granja_id;

  RanchoDivision(this.id, this.nombre, this.database_id, this.hectarea,
      this.capacidad_hectarea, this.uso_suelo, this.granja_id);

  RanchoDivision.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        nombre = parsedJson["nombre"],
        database_id = parsedJson["database_id"],
        hectarea = parsedJson["hectarea"],
        capacidad_hectarea = parsedJson["capacidad_hectarea"],
        uso_suelo = parsedJson["uso_suelo"],
        granja_id = parsedJson["granja_id"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "database_id": database_id,
        "hectarea": hectarea,
        "capacidad_hectarea": capacidad_hectarea,
        "uso_suelo": uso_suelo,
        "granja_id": granja_id,
      };
}
