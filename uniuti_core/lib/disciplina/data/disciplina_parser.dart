part of '../../uniuti_core.dart';

abstract class DisciplinaParser {
  static Disciplina fromMap(Map<String, dynamic> map) => Disciplina(
        id: map['id'],
        nome: map['nome'],
        descricao: map['descricao'],
      );

  static Map<String, dynamic> toMap(Disciplina disciplina) => {
        'id': disciplina.id,
        'nome': disciplina.nome,
        'descricao': disciplina.descricao,
      };
}
