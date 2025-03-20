class PesajeAnimal {
  final int? id;
  final String? fecha;
  final int? tipoPesajeId;
  final int? tarjetaAnimalId;
  final int? databaseId;
  final List<Map<String, dynamic>>? listaDetallesPesaje = [];

  PesajeAnimal(this.id, this.fecha, this.tipoPesajeId, this.tarjetaAnimalId,
      this.databaseId);

  PesajeAnimal.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        fecha = parsedJson['fecha'],
        tipoPesajeId = parsedJson['tipo_pesaje_id'],
        tarjetaAnimalId = parsedJson['tarjeta_animal_id'],
        databaseId = parsedJson['database_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'fecha': fecha,
        'tipo_pesaje_id': tipoPesajeId,
        'tarjeta_animal_id': tarjetaAnimalId,
        'database_id': databaseId,
        'lista_detalles_pesaje': listaDetallesPesaje
      };
}
