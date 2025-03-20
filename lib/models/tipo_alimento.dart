class TipoAlimento {
  int id;
  String nombre;
  int productoId;
  int databaseId;
  bool estatus;
  DateTime createdAt;
  DateTime updatedAt;

  TipoAlimento(this.id, this.nombre, this.productoId, this.databaseId,
      this.estatus, this.createdAt, this.updatedAt);

  TipoAlimento.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        nombre = parsedJson["nombre"],
        productoId = parsedJson["producto_id"],
        databaseId = parsedJson["database_id"],
        estatus = parsedJson["estatus"],
        createdAt = parsedJson["created_at"],
        updatedAt = parsedJson["updated_at"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "producto_id": productoId,
        "database_id": databaseId,
        "estatus": estatus,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
