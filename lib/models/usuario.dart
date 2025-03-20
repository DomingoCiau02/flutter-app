// ignore_for_file: non_constant_identifier_names

class Usuario {
  int? id;
  String? usuario;
  int? contactoId;
  String? correo;
  String? contacto;
  String? api_Key;
  String? api_token;

  Usuario(this.id, this.usuario, this.contactoId, this.correo, this.contacto,
      this.api_Key, this.api_token);

  Usuario.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        usuario = parsedJson["usuario"],
        contactoId = parsedJson["contacto_Id"],
        correo = parsedJson["correo"],
        contacto = parsedJson["contacto"],
        api_Key = parsedJson["api_key"],
        api_token = parsedJson[""];

  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "contacto_Id": contactoId,
        "correo": correo,
        "contacto": contacto,
        "api_key": api_Key,
      };
}
