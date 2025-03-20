
class AlimRanchoDivision {
  int id;
  int granjaId;
  int databaseId;
  bool estatus;
  String fecha;
  String hora;

  AlimRanchoDivision(this.id, this.granjaId, this.databaseId, this.estatus,
      this.fecha, this.hora);

  AlimRanchoDivision.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        granjaId = parsedJson["granja_id"],
        databaseId = parsedJson["database_id"],
        estatus = parsedJson["estatus"],
        fecha = parsedJson["fecha"],
        hora = parsedJson["hora"];

  Map<String, dynamic> toJson() => {
        'id': id,
        'granja_id': granjaId,
        'database_id': databaseId,
        'estatus': estatus,
        'fecha': fecha,
        'hora': hora,
      };
}
