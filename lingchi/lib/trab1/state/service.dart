import 'package:lingchi/trab1/models/filme.dart';
import 'package:uuid/v4.dart';

class StateService {
  static final StateService _instance = StateService._internal();

  StateService._internal();

  factory StateService() {
    return _instance;
  }

  List<String> generos = ['Épico'];
  List<Filme> filmes = [
    Filme(
      id: const UuidV4().generate(),
      genero: 'Épico',
      diretor: 'Peter Jackson',
      titulo: 'O Senhor dos Anéis: A Sociedade do Anel',
    )
  ];
}
