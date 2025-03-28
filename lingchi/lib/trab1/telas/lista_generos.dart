import 'package:flutter/material.dart';
import 'package:lingchi/trab1/state/service.dart';
import 'package:lingchi/trab1/telas/lista_filmes.dart';

class ListaGeneros extends StatefulWidget {
  const ListaGeneros({super.key});

  @override
  ListaGenerosState createState() => ListaGenerosState();
}

class ListaGenerosState extends State<ListaGeneros> {
  final _service = StateService();

  final _generosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Gêneros',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _service.generos.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListaFilmes(
                                      genero: _service.generos[index],
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(_service.generos[index],
                              style:
                                  Theme.of(context).textTheme.headlineMedium!),
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
            await showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Gênero',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: _generosController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _service.generos.add(_generosController.text);
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Salvar',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      ],
                    ),
                  );
                });

            _generosController.clear();
          }),
    );
  }
}
