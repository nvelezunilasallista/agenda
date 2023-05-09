import 'dart:convert';

import 'package:agenda/contactModel.dart';

class ContactResponseModel{

  List<ContactModel> listaContactos = <ContactModel>[];

  ContactResponseModel.empty(){
    this.listaContactos = List.empty();
  }

  ContactResponseModel.fromDB(List<Map> resultadosQuery){
    for (int i = 0; i < resultadosQuery.length; i++){
      var resultado = resultadosQuery[i];
      ContactModel contacto = ContactModel(resultado);
      this.listaContactos.add(contacto);
    }
  }

}