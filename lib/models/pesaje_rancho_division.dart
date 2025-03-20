// ignore_for_file: file_names

class PesajeRachoDivision {
  int id;
  int tipoPesajeId;
  int ranchoDivisionId;
  DateTime fecha;
  int databaseId;
  bool estatus;
  String nombre;
  int granjaId;
  String tipo;

  PesajeRachoDivision(
    this.id,
    this.tipoPesajeId,
    this.ranchoDivisionId,
    this.fecha,
    this.databaseId,
    this.estatus,
    this.nombre,
    this.granjaId,
    this.tipo,
  );

  PesajeRachoDivision.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        tipoPesajeId = parsedJson["tipo_pesaje_id"],
        ranchoDivisionId = parsedJson["rancho_division_id"],
        fecha = parsedJson["fecha"],
        databaseId = parsedJson["database_id"],
        estatus = parsedJson["estatus"],
        nombre = parsedJson["nombre"],
        granjaId = parsedJson["granja_id"],
        tipo = parsedJson["tipo"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoPesajeId": tipoPesajeId,
        "ranchoDivicionId": ranchoDivisionId,
        "fecha": fecha,
        "dataBaseId": databaseId,
        "estatus": estatus,
        "nombre": nombre,
        "granja_id": granjaId,
        "tipo": tipo,
      };
}
