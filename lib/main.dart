import 'package:agenda/creation.dart';
import 'package:agenda/list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp( routes: {
    "/create": (BuildContext context) => CreateContactPage(),
    "/": (BuildContext context) => ListPage(),
  }));
}

