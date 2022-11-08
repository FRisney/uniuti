part of '../../uniuti_core.dart';

abstract class MonitoriaParser {
  static Monitoria fromMap(Map<String, dynamic> map) => Monitoria(
        id: map['id'],
        titulo: map['titulo'] ?? 'Monitoria',
        descricao: map['descricao'],
        disciplina: DisciplinaParser.fromMap(map['disciplina']),
        instituicao: InstituicaoParser.fromMap(map['disciplina']),
        status: map['status'] ?? Status('N/A'),
        criacao: DateTime.parse(map['createdAt']),
      );

  static Map<String, dynamic> toMap(Monitoria monitoria) => {
        'id': monitoria.id,
        'titulo': monitoria.titulo,
        'descricao': monitoria.descricao,
        'disciplina': monitoria.disciplina,
        'status': monitoria.status,
      };
}
