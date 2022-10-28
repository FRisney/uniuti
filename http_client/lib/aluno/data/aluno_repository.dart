part of '../../../http_client.dart';

class RemoteAlunoRepository implements AlunoRepository {
  RemoteAlunoRepository(this.client);
  final RemoteClient client;

  @override
  Future<Aluno?> byId(int id) {
    // TODO: implement byId
    throw UnimplementedError();
  }

  @override
  Future<List<Aluno>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<List<Aluno>> getMany(RepoFilter filter) {
    // TODO: implement getMany
    throw UnimplementedError();
  }

  @override
  Future<Aluno> performRegister(Aluno aluno) async {
    late Aluno novo;
    final response = await client.post(
      '/v1/Auth/CreateUser',
      body: {
        "nomeCompleto": aluno.nome,
        "email": aluno.usuario!.login,
        "password": aluno.usuario!.senha,
        "celular": aluno.celular?.contato,
        "instituicaoId": aluno.instituicao?.id,
        "cursoId": aluno.curso?.id,
        "endereco": EnderecoParser.toMap(aluno.endereco),
      },
    );

    if (response.statusCode == 200) {
      novo = AlunoParser.fromMap(response.body);
    } else {}
    return novo;
  }
}
