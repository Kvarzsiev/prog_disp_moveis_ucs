import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lingchi/trab1/models/filme.dart';
import 'package:lingchi/trab1/state/service.dart';
import 'package:lingchi/trab1/telas/lista_filmes.dart';
import 'package:uuid/v4.dart';

class EditarFilme extends StatefulWidget {
  const EditarFilme({super.key, required this.genero, this.filme});

  final String genero;
  final Filme? filme;

  @override
  EditarFilmeState createState() => EditarFilmeState();
}

class EditarFilmeState extends State<EditarFilme> {
  final _service = StateService();

  final _formKey = GlobalKey<FormState>();

  late Filme _filme;

  final TextEditingController _titulo = TextEditingController();
  final TextEditingController _diretor = TextEditingController();
  final TextEditingController _genero = TextEditingController();

  @override
  void initState() {
    super.initState();

    final filme = widget.filme;
    if (filme != null) {
      _filme = filme;

      _titulo.text = _filme.titulo;
      _diretor.text = _filme.diretor;
      _genero.text = _filme.genero;
    } else {
      _genero.text = widget.genero;

      _filme = Filme(
        id: const UuidV4().generate(),
        genero: widget.genero,
        diretor: 'Diretor',
        titulo: 'Filme',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _filme.titulo,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(_filme.id),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Título'),
                            controller: _titulo,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Por favor, insira um valor válido!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Diretor'),
                            controller: _diretor,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Por favor, insira um valor válido!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            enabled: false,
                            decoration:
                                const InputDecoration(labelText: 'Gênero'),
                            controller: _genero,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _filme.titulo = _titulo.text;
                              _filme.diretor = _diretor.text;
                              _filme.genero = _genero.text;

                              final filmeIndex = _service.filmes
                                  .indexWhere((filme) => filme.id == _filme.id);

                              if (filmeIndex >= 0) {
                                _service.filmes.replaceRange(
                                    filmeIndex, filmeIndex + 1, [_filme]);
                              } else {
                                _service.filmes.add(_filme);
                              }
                              inspect(_service.filmes);

                              // kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListaFilmes(
                                            genero: widget.genero,
                                          )));
                            }
                          },
                          child: Text(
                            'Salvar',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
