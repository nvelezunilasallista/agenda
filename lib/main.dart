import 'package:agenda/creation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp( routes: {
    "/": (BuildContext context) => CreateContactPage(),
    // "/list": (BuildContext context) => ContactListPage(),
  }));
}

