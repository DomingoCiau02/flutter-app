class TipoAnimal {
  int id;
  String nombre;
  bool estatus;
  int databaseId;

  TipoAnimal(
    this.id,
    this.nombre,
    this.estatus,
    this.databaseId,
  );

  TipoAnimal.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        nombre = parsedJson['nombre'],
        estatus = parsedJson['estatus'],
        databaseId = parsedJson['database_id'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "estatus": estatus,
        "database_id": databaseId,
      };
}
