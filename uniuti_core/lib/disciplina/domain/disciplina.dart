part of '../../uniuti_core.dart';

class Disciplina {
  String id;
  String nome;
  String descricao;
  Disciplina({
    required this.id,
    required this.nome,
    required this.descricao,
  });
  @override
  String toString() => nome;
}
