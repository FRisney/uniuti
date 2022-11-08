part of '../../../http_client.dart';

class UsuarioRemoteRepository implements UsuarioRepository {
  UsuarioRemoteRepository(this.client);
  RemoteClient client;

  @override
  Future<String?> performRefreshToken(Aluno usuario) async {
    var response = await client.post('/refresh-login', body: {});
    if (response.statusCode >= 500) {
      throw RemoteClientException(response.reasonPhrase ?? 'Erro inesperado!');
    }
    return response.body['token'];
  }

  @override
  Future<String?> performLogin(Aluno aluno) async {
    var response = await client.post(
      '/v1/Auth/LoginUser',
      body: {'email': aluno.usuario!.login, 'password': aluno.usuario!.senha},
    );
    if (response.statusCode >= 400) {
      String ret = '';
      if (response.body['errors'].runtimeType == Map) {
        ret = parseErrorsMap(response.body['errors'], ret);
      } else if (response.body['errors'].runtimeType == List) {
        ret = parseErrorsList(response.body['errors'], ret);
      }
      return ret;
    }
    aluno.updateFromMap(response.body['data']['usuario']);
    aluno.usuario!.token = response.body['data']['token'];
    return null;
  }

  @override
  Future<Usuario?> byId(String id) async {
    return null;
  }

  @override
  Future<List<Usuario>> getAll() async {
    return [];
  }
}
