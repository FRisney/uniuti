part of '../../uniuti_core.dart';

class Monitoria {
  String id;
  String titulo;
  String descricao;
  Disciplina? disciplina;
  Status status;
  DateTime criacao;
  Aluno? prestador;
  Aluno? solicitante;

  Monitoria({
    required this.id,
    required this.titulo,
    required this.descricao,
    this.disciplina,
    required this.status,
    required this.criacao,
    this.prestador,
    this.solicitante,
  });
  //  {
  //   if (prestador == null && solicitante == null) {
  //     throw SolicitantePrestadorInvalidosException();
  //   }
  // }

  int get tipoSolicitacao {
    var tipo = 1;
    if (prestador != null && solicitante == null) tipo = 2;
    return tipo;
  }

  String get criadoEm {
    final dia = criacao.day.toString().padLeft(2, '0');
    final mes = criacao.month.toString().padLeft(2, '0');
    final ano = criacao.year.toString().padLeft(4, '0');
    return '$dia/$mes/$ano';
  }

  void updateDisciplina(Disciplina? novaDisciplina) {
    if (novaDisciplina == null) return;
    disciplina = novaDisciplina;
  }

  String? validaDescricao(String? value) {
    var ret = (value == null) ? 'Fornecer uma Descrição!' : null;
    ret ??= (value!.length <= 20)
        ? 'Descricao deve conter mais que 20 caracteres'
        : null;
    return ret;
  }

  void updateDescricao(String? novaDescricao) {
    if (novaDescricao == null) return;
    descricao = novaDescricao;
  }

  void updateTitulo(String? newValue) {
    titulo = newValue ?? '';
  }
}
