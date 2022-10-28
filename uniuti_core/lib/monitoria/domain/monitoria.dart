part of '../../uniuti_core.dart';

class Monitoria {
  String id;
  String titulo;
  String descricao;
  Disciplina disciplina;
  Status status;
  Aluno? prestador;
  Aluno? solicitante;
  Monitoria({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.disciplina,
    required this.status,
    this.prestador,
    this.solicitante,
  }) {
    if (prestador == null && solicitante == null) {
      throw SolicitantePrestadorInvalidosException();
    }
  }

  int get tipoSolicitacao {
    var tipo = 1;
    if (prestador != null && solicitante == null) tipo = 2;
    return tipo;
  }
}
