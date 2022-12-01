part of '../../uniuti_core.dart';

class Disciplina extends Equatable {
  final String id;
  final String nome;
  final String descricao;
  const Disciplina({
    required this.id,
    required this.nome,
    required this.descricao,
  });
  @override
  String toString() => nome;

  @override
  List<Object?> get props => [id];
}
