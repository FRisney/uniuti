part of '../../../http_client.dart';

class AlunoRemoteRepository implements AlunoRepository {
  AlunoRemoteRepository(this.client);
  final RemoteClient client;

  @override
  Future<Aluno?> byId(String id) async {
    dev.log(DateTime.now().toIso8601String(), name: 'Aluno.byId');
    final response = await client.post(
      '/Usuario/get-user-by-id',
      params: {'id': id},
    );
    if (response.statusCode >= 500) {
      throw RemoteClientException(response.body['erro']);
    } else if (response.statusCode >= 400) {
      var erro = response.body['errors'];
      if (erro is List) {
        throw RemoteClientException(parseErrorsList(erro));
      } else {
        throw RemoteClientException(parseErrorsMap(erro));
      }
    }
    return AlunoParser.fromMap(response.body);
  }

  @override
  Future<List<Aluno>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<String?> performRegister(Aluno aluno) async {
    dev.log(DateTime.now().toIso8601String(), name: 'Aluno.performRegister');
    final response = await client.post(
      '/v1/Auth/CreateUser',
      body: {
        "nomeCompleto": aluno.nome,
        "email": aluno.usuario!.login,
        "password": aluno.usuario!.senha,
        "celular": aluno.celular?.contato,
        "instituicaoId": aluno.instituicao?.id,
        "cursoId": aluno.curso?.id,
        "endereco": aluno.endereco == null
            ? null
            : EnderecoParser.toMap(aluno.endereco!),
      },
    );
    aluno.usuario!.senha = '';
    String ret = '';
    if (response.statusCode >= 500) {
      return response.body['erro'];
    } else if (response.statusCode >= 400) {
      var erro = response.body['errors'];
      if (erro is List) {
        return parseErrorsList(erro, ret);
      } else {
        return parseErrorsMap(erro, ret);
      }
    }
    return null;
  }

  @override
  Future<String?> update(Aluno model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
