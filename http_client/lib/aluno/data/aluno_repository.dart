part of '../../../http_client.dart';

class AlunoRemoteRepository implements AlunoRepository {
  AlunoRemoteRepository(this.client);
  final RemoteClient client;

  @override
  Future<Aluno?> byId(String id) {
    // TODO: implement byId
    throw UnimplementedError();
  }

  @override
  Future<List<Aluno>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<String?> performRegister(Aluno aluno) async {
    dev.log('performRegister: ${DateTime.now().toIso8601String()}',
        name: 'call');
    final response = await client.post(
      '/v1/Auth/CreateUser',
      body: {
        "nomeCompleto": aluno.nome,
        "email": aluno.usuario!.login,
        "password": aluno.usuario!.senha,
        "celular": aluno.celular?.contato,
        // "instituicaoId": aluno.instituicao?.id,
        "cursoId": aluno.curso?.id,
        // "endereco": EnderecoParser.toMap(aluno.endereco),
      },
    );
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
}
