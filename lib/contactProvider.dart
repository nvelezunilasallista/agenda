import 'dart:io';

import 'package:agenda/contactModel.dart';
import 'package:agenda/contactResponseModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactProviderDB{

  Database? db;

  ContactProviderDB();

  init() async{
    Directory applicationDirectory =
                        await getApplicationDocumentsDirectory();

    var fullPath = join(applicationDirectory.path, "Contacts.db");

    this.db = await openDatabase(fullPath, onCreate: (Database newDb, int version){
      return newDb.execute("""
      CREATE TABLE Contactos(
        _id TEXT,
        nombre TEXT,
        apellidos TEXT,
        email TEXT,
        telefono TEXT);
      """);
    }, version: 1);
  }

  agregarContacto(ContactModel contacto) async{
    await this.db!.rawInsert(""" 
      INSERT INTO Contactos(_id, nombre, apellidos, email, telefono)
      VALUES (?,?,?,?,?)
    """,[contacto.id, contacto.nombre, contacto.apellidos, contacto.email, contacto.telefono]);
  }

  Future<ContactResponseModel> obtenerContactos() async{
    var results = await this.db!.rawQuery("""
     SELECT * FROM Contactos ORDER BY nombre, apellidos
     """);

    ContactResponseModel response = ContactResponseModel.fromDB(results);

    return response;
  }



}