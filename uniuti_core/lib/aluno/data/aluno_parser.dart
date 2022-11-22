part of '../../uniuti_core.dart';

class AlunoParser {
  static Map<String, dynamic> toMap(Aluno aluno) {
    return {
      'id': aluno.id,
      'nome': aluno.nome,
      'cursoId': aluno.curso,
      'celular': aluno.celular,
      'usuario': aluno.usuario,
      'instituicaoId': aluno.instituicao,
    };
  }

  static String toJson(Aluno aluno) {
    return toMap(aluno).toString();
  }

  static Aluno fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'],
      nome: map['nomeCompleto'],
      curso: map['cursoId'],
      celular: Celular(map['celular']),
      instituicao: map['instituicaoId'],
      endereco: map['endereco'] == null
          ? null
          : EnderecoParser.fromMap(map['endereco']),
    );
  }
}

extension AlunoParserExtension on Aluno {
  updateFromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nomeCompleto'];
    celular = Celular(map['celular']);
    curso = map['cursoId'] == null ? null : CursoParser.fromMap(map['cursoId']);
    instituicao = map['instituicaoId'] == null
        ? null
        : InstituicaoParser.fromMap(map['instituicaoId']);
    endereco = map['endereco'] == null
        ? null
        : EnderecoParser.fromMap(map['endereco']);
    usuario!.id = map['id'];
  }
}
