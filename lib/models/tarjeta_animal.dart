class TarjetaAnimal {
  final int id;
  final int ranchoId;
  final int granjaId;
  final int divisionRanchoId;
  final int? loteAnimalId;
  final String nombre;
  final String sexo;
  final int? razaAnimalId;
  final int? clasificacionAnimalId;
  final int tipoAnimalId;
  final String registro;
  final String proposito;
  final double costo;
  final String? observaciones;

  TarjetaAnimal(
    this.id,
    this.ranchoId,
    this.granjaId,
    this.divisionRanchoId,
    this.loteAnimalId,
    this.nombre,
    this.sexo,
    this.razaAnimalId,
    this.clasificacionAnimalId,
    this.tipoAnimalId,
    this.registro,
    this.proposito,
    this.costo,
    this.observaciones,
  );

  TarjetaAnimal.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        ranchoId = parsedJson['rancho_id'],
        granjaId = parsedJson['granaja_id'],
        divisionRanchoId = parsedJson['division_rancho_id'],
        loteAnimalId = parsedJson['lote_animal_id'],
        nombre = parsedJson['nombre'],
        sexo = parsedJson['sexo'],
        razaAnimalId = parsedJson['raza_animal_id'],
        clasificacionAnimalId = parsedJson['clasisficacion_animal_id'],
        tipoAnimalId = parsedJson['tipo_animal_id'],
        registro = parsedJson['registro'],
        proposito = parsedJson['proposito'],
        costo = parsedJson['costo'],
        observaciones = parsedJson['observaciones'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'rancho_id': ranchoId,
        'granaja_id': granjaId,
        'division_rancho_id': divisionRanchoId,
        'lote_animal_id': loteAnimalId,
        'nombre': nombre,
        'sexo': sexo,
        'raza_animal_id': razaAnimalId,
        'clasisficacion_animal_id': clasificacionAnimalId,
        'tipo_animal_id': tipoAnimalId,
        'registro': registro,
        'proposito': proposito,
        'costo': costo,
        'observaciones': observaciones,
      };
}
