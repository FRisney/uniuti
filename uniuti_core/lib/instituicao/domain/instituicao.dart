part of '../../uniuti_core.dart';

class Instituicao {
  int id;
  String nome;
  final List<Contato> contatos;
  Endereco endereco;

  Instituicao({
    required this.id,
    required this.nome,
    required this.contatos,
    required this.endereco,
  });
}
