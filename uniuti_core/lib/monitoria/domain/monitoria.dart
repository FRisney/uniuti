part of '../../uniuti_core.dart';

class Monitoria {
  int id;
  String titulo;
  String descricao;
  Disciplina disciplina;
  Aluno? prestador;
  Aluno? solicitante;
  Status status;
  List<Aluno> pendencias;
  Monitoria({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.disciplina,
    this.prestador,
    this.solicitante,
    required this.status,
    required this.pendencias,
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
