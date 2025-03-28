import 'package:flutter/material.dart';
import 'package:lingchi/trab1/telas/lista_generos.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const ListaGeneros(),
    );
  }
}
