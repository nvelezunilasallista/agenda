import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:agenda/contactModel.dart';

class ContactProviderAPI{

  Future<void> crearContacto(ContactModel contact) async{
    try{
      var url = Uri.parse("http://10.0.2.2:8282/api/contact");
      var responseHttp = await http.post(url, body:{
        'nombre': contact.nombre,
        'apellidos': contact.apellidos,
        'telefono': contact.telefono,
        'email': contact.email
      });
      String rawResponse = utf8.decode(responseHttp.bodyBytes);
    }catch(ex){}
  }

}