import 'dart:async';

import 'package:agenda/contactCard.dart';
import 'package:agenda/contactModel.dart';
import 'package:agenda/contactProvider.dart';
import 'package:agenda/contactProviderAPI.dart';
import 'package:agenda/contactResponseModel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _ListPage();
  }
}

class _ListPage extends State<ListPage>{
  List<Widget> listadoContactos = <Widget>[];
  Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState(){
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
          if(result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile){
            sincronizarContactos();
          }
    });

  }

  @override
  Widget build (BuildContext context){
    obtenerContactos();
    return Scaffold(
        appBar: AppBar(title: Text("Lista Contactos")),
        body: Center(
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: this.listadoContactos,
              ),
            ])),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, "/create");
            },
            label: Text("Crear Contacto"),
            icon: Icon(Icons.add)));
  }

  obtenerContactos() async{

    ContactProviderDB provider = ContactProviderDB();

    await provider.init();

    ContactResponseModel response = await provider.obtenerContactos();

    List<Widget> contactosACargar = <Widget>[];

    for (int i = 0 ; i < response.listaContactos.length; i++){
      Widget wd = ContactCard(
          response.listaContactos[i].nombre + response.listaContactos[i].apellidos,
          response.listaContactos[i].telefono,
          response.listaContactos[i].email);
      contactosACargar.add(wd);
    }
    setState(() {
      this.listadoContactos = contactosACargar;
    });

  }

  void sincronizarContactos() async {
    ContactProviderDB cpdb = ContactProviderDB();
    ContactProviderAPI cpapi = ContactProviderAPI();

    await cpdb.init();

    ContactResponseModel contactosPorSincronizar =
      await cpdb.obtenerContactosPorSincronizar();

    for ( int i = 0;
    i < contactosPorSincronizar.listaContactos.length; i++){
      await cpapi.crearContacto(contactosPorSincronizar.listaContactos[i]);
    }

    await cpdb.marcarContactosSincronizados();
  }


}