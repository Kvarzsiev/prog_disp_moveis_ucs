import 'package:flutter/material.dart';
import 'package:lingchi/trab1/models/filme.dart';
import 'package:lingchi/trab1/state/service.dart';
import 'package:lingchi/trab1/telas/editar_filme.dart';

class ListaFilmes extends StatefulWidget {
  const ListaFilmes({super.key, required this.genero});

  final String genero;

  @override
  ListaFilmesState createState() => ListaFilmesState();
}

class ListaFilmesState extends State<ListaFilmes> {
  final _service = StateService();

  late List<Filme> _list;

  @override
  void initState() {
    super.initState();

    _list = _service.filmes
        .where((filme) => filme.genero == widget.genero)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              '${widget.genero} - Filmes',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    final filme = _list[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarFilme(
                              genero: widget.genero,
                              filme: filme,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(filme.titulo,
                              style:
                                  Theme.of(context).textTheme.headlineMedium!),
                          subtitle: Text(filme.diretor,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditarFilme(
                          genero: widget.genero,
                        )));
          }),
    );
  }
}
