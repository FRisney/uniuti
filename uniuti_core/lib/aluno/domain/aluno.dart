part of '../../uniuti_core.dart';

class Aluno {
  String id;
  String nome;
  Endereco? endereco;
  Curso? curso;
  Contato? celular;
  Usuario? usuario;
  Instituicao? instituicao;
  Aluno({
    required this.id,
    required this.nome,
    required this.endereco,
    this.curso,
    this.celular,
    this.usuario,
    this.instituicao,
  });

  void updateCurso(Curso? novoCurso) {
    curso = novoCurso;
  }

  void updateInstituicao(Instituicao? novaInstituicao) {
    instituicao = novaInstituicao;
  }
}
