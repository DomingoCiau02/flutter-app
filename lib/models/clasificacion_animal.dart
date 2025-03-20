class ClasificacionAnimal {
  int id;
  String nombre;
  String sexo;
  int edadRangoInferior;
  int edadRangoSuperior;
  String descripcion;
  double precioPorPieza;
  double precioPorKilo;
  int loteAnimalId;
  int databaseId;

  ClasificacionAnimal(
    this.id,
    this.nombre,
    this.sexo,
    this.edadRangoInferior,
    this.edadRangoSuperior,
    this.descripcion,
    this.precioPorPieza,
    this.precioPorKilo,
    this.loteAnimalId,
    this.databaseId,
  );

  ClasificacionAnimal.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        nombre = parsedJson['clasificacion'],
        sexo = parsedJson['sexo'],
        edadRangoInferior = parsedJson['edad_rango_inferior'],
        edadRangoSuperior = parsedJson['edad_rango_superior'],
        descripcion = parsedJson['descripcion'],
        precioPorPieza = parsedJson['precio_por_pieza'],
        precioPorKilo = parsedJson['precio_por_kilo'],
        loteAnimalId = parsedJson['lote_animal_id'],
        databaseId = parsedJson['database_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'clasificacion': nombre,
        'sexo': sexo,
        'edadRangoInferior': edadRangoInferior,
        'edadRangoSuperior': edadRangoSuperior,
        'descripcion': descripcion,
        'precioPorPieza': precioPorPieza,
        'precioPorKilo': precioPorKilo,
        'loteAnimalId': loteAnimalId,
        'databaseId': databaseId,
      };
}
