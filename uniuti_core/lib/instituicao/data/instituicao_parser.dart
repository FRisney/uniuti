part of '../../uniuti_core.dart';

class InstituicaoParser {
  static Instituicao fromMap(Map<String, dynamic> map) {
    var contatos = <Contato>[];
    if (map['email'] != null) {
      contatos.add(Email(map['email']));
    }
    if (map['celular'] != null) {
      contatos.add(Celular(map['celular']));
    }
    if (map['telefone'] != null) {
      contatos.add(Telefone(map['telefone']));
    }
    return Instituicao(
      id: map['id'],
      contatos: contatos,
      endereco: map['endereco'] == null
          ? null
          : EnderecoParser.fromMap(map['endereco']),
      nome: map['nome'],
    );
  }

  static Map<String, dynamic> toMap(Instituicao instituicao) => {
        'id': instituicao.id,
        'nome': instituicao.nome,
        'endereco': instituicao.endereco == null
            ? null
            : EnderecoParser.toMap(instituicao.endereco!),
        'email': instituicao.contatos.firstWhere((element) => element is Email),
        'celular':
            instituicao.contatos.firstWhere((element) => element is Celular),
        'telefone':
            instituicao.contatos.firstWhere((element) => element is Telefone),
      };
}
