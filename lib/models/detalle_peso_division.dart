class DetallePesoDivision {
  int id;
  double peso;
  String sexo;
  int ranchoDivisionId;
  bool estatus;
  DateTime createdAt;
  DateTime updatedAt;
  int posicion;

  DetallePesoDivision(this.id, this.peso, this.sexo, this.ranchoDivisionId,
      this.estatus, this.createdAt, this.updatedAt, this.posicion);

  DetallePesoDivision.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        peso = parsedJson["peso"],
        sexo = parsedJson["sexo"],
        ranchoDivisionId = parsedJson["rancho_division_id"],
        estatus = parsedJson["estatus"],
        createdAt = parsedJson["created_at"],
        updatedAt = parsedJson["updated_at"],
        posicion = parsedJson["posicion"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "peso": peso,
        "sexo": sexo,
        "rancho_divicion_id": ranchoDivisionId,
      };
}
