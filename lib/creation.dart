import 'package:agenda/contactModel.dart';
import 'package:agenda/contactProvider.dart';
import 'package:flutter/material.dart';

class CreateContactPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _CreateContactPage();
  }
}

class _CreateContactPage extends State<CreateContactPage>{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String lastName = "";
  String fistName = "";
  String email = "";
  String cellphoneNumber = "";

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Agenda")),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              getFirstNameInput(),
              getLastNameInput(),
              getEmailInput(),
              getCellphoneInput(),
              getSubmitButton()
            ],
          ),
        )
      )

    );
  }

  TextFormField getFirstNameInput(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nombre del contacto",
        hintText: "Jhon"
      ),
      validator: (value) {
        if(value!.length > 0){
          return null;
        }
        else{
          return "El nombre no puede ser vacío";
        }
      },
      onSaved: (value){
        fistName = value!;
      },
    );
  }

  TextFormField getLastNameInput(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "Apellidos del contacto",
          hintText: "Doe"
      ),
      validator: (value) {
        if(value!.length > 0){
          return null;
        }
        else{
          return "Los apellidos no pueden ser vacíos";
        }
      },
      onSaved: (value){
        lastName = value!;
      },
    );
  }

  TextFormField getEmailInput(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Email del contacto",
          hintText: "jhon@mail.com"
      ),
      validator: (value) {
        String pattern = r'^[^@]+@[^@]+\.[^@]+$';
        RegExp expression = new RegExp(pattern);
        if(expression.hasMatch(value!)){
          return null;
        }
        else{
          return "El email no es valido";
        }
      },
      onSaved: (value){
        email = value!;
      },
    );
  }

  TextFormField getCellphoneInput(){
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          labelText: "Celular del contacto",
          hintText: "3000000000"
      ),
      validator: (value) {
        if(value!.length >=7 && value!.length <= 10){
          return null;
        }
        else{
          return "El número celular no es valido";
        }
      },
      onSaved: (value){
        cellphoneNumber = value!;
      },
    );
  }

  ElevatedButton getSubmitButton(){
    return ElevatedButton(
        onPressed: (){
          if(formKey.currentState!.validate()){
            formKey.currentState!.save();
            crearContacto();
            Navigator.pop(context);
          }
        },
        child: Text("Guardar nuevo contacto"));
  }

  crearContacto() async{
    ContactModel contacto =
    ContactModel.fromValues(fistName, lastName, email, cellphoneNumber, "0");
    ContactProviderDB provider = ContactProviderDB();
    await provider.init();

    var id = await provider.agregarContacto(contacto);

  }
}
