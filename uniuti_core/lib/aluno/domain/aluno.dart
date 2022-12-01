part of '../../uniuti_core.dart';

class Aluno extends Equatable {
  String id;
  String nome;
  Endereco? endereco;
  Curso? curso;
  Celular? celular;
  Usuario? usuario;
  Instituicao? instituicao;
  Aluno({
    required this.id,
    required this.nome,
    this.endereco,
    this.curso,
    this.celular,
    this.usuario,
    this.instituicao,
  });

  factory Aluno.empty() => Aluno(
        id: '',
        nome: '',
        usuario: Usuario.empty(),
        celular: Celular(''),
      );

  void updateCurso(Curso? novoCurso) {
    curso = novoCurso;
  }

  void updateInstituicao(Instituicao? novaInstituicao) {
    instituicao = novaInstituicao;
  }

  @override
  List<Object?> get props => [id];
}
