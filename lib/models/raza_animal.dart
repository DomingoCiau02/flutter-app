class RazaAnimal {
  int id;
  String nombre;
  String genotipo;
  String fenotipo;
  int? clasificacionAnimalId;
  int databaseId;

  RazaAnimal(
    this.id,
    this.nombre,
    this.genotipo,
    this.fenotipo,
    this.clasificacionAnimalId,
    this.databaseId,
  );

  RazaAnimal.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        nombre = parsedJson["nombre"],
        genotipo = parsedJson["genotipo"],
        fenotipo = parsedJson["fenotipo"],
        clasificacionAnimalId = parsedJson["clasificacion_animal_id"],
        databaseId = parsedJson["database_id"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "genotipo": genotipo,
        "fenotipo": fenotipo,
        "clasificacionAnimalId": clasificacionAnimalId,
        "database_id": databaseId,
      };
}
