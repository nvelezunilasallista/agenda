import 'dart:convert';

class ContactModel{
    String id = "";
    String nombre = "";
    String apellidos = "";
    String email = "";
    String telefono = "";
    String sincronizado = "";

    ContactModel(Map jsonResponse){
      this.id = jsonResponse["_id"];
      this.nombre  = jsonResponse["nombre"];
      this.apellidos  = jsonResponse["apellidos"];
      this.email  = jsonResponse["email"];
      this.telefono  = jsonResponse["telefono"];
      this.sincronizado = jsonResponse["sincronizado"];
    }

    ContactModel.fromValues(String nombre, String apellidos, String email,
        String telefono, String sincronizado){
      this.id = "";
      this.nombre  = nombre;
      this.apellidos  = apellidos;
      this.email  = email;
      this.telefono  = telefono;
      this.sincronizado = sincronizado;
    }

}

