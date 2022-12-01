part of '../../http_client.dart';

class InstituicaoRemoteRepository implements InstituicaoRepository {
  InstituicaoRemoteRepository(this.client);

  final RemoteClient client;

  @override
  Future<Instituicao?> byId(String id) {
    // TODO: implement byId
    throw UnimplementedError();
  }

  @override
  Future<List<Instituicao>> getAll() async {
    dev.log(DateTime.now().toIso8601String(), name: 'Instituicao.getAll');
    final Response response;
    try {
      response = await client.get('/v1/Instituicao/FindAll');
    } catch (e) {
      rethrow;
    }
    if (response.statusCode >= 400) {
      var erro = response.body['errors'];
      // TODO refinar Exception de erros 400
      throw RemoteClientException(
          (erro is List) ? parseErrorsList(erro) : parseErrorsMap(erro));
    }
    final list = <Instituicao>[];
    for (var item in response.body['data']) {
      list.add(InstituicaoParser.fromMap(item));
    }
    return list;
  }

  @override
  Future<String?> update(Instituicao model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
