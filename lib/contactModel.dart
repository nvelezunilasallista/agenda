import 'dart:convert';

class ContactModel{
    String id = "";
    String nombre = "";
    String apellidos = "";
    String email = "";
    String telefono = "";

    ContactModel(Map jsonResponse){
      this.id = jsonResponse["_id"];
      this.nombre  = jsonResponse["nombre"];
      this.apellidos  = jsonResponse["apellidos"];
      this.email  = jsonResponse["email"];
      this.telefono  = jsonResponse["telefono"];
    }

    ContactModel.fromValues(String nombre, String apellidos, String email, String telefono){
      this.id = "";
      this.nombre  = nombre;
      this.apellidos  = apellidos;
      this.email  = email;
      this.telefono  = telefono;
    }

}

