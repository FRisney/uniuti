part of '../../uniuti_core.dart';

abstract class MonitoriaParser {
  static Monitoria fromMap(Map<String, dynamic> map) => Monitoria(
        id: map['id'],
        titulo: map['titulo'],
        descricao: map['descricao'],
        disciplina: map['disciplina'],
        status: map['status'],
      );

  static Map<String, dynamic> toMap(Monitoria monitoria) => {
        'id': monitoria.id,
        'titulo': monitoria.titulo,
        'descricao': monitoria.descricao,
        'disciplina': monitoria.disciplina,
        'status': monitoria.status,
      };
}
