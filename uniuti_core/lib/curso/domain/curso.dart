part of '../../uniuti_core.dart';

class Curso {
  String id;
  String nome;
  Curso({
    required this.id,
    required this.nome,
  });

  @override
  String toString() => nome;
}
