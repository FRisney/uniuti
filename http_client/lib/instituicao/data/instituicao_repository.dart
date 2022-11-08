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
    final response = await client.get('/v1/Instituicao/FindAll');
    if (response.statusCode >= 400) {
      throw RemoteClientException('Erro Inesperado');
    }
    final list = <Instituicao>[];
    for (var item in response.body['data']) {
      list.add(InstituicaoParser.fromMap(item));
    }
    return list;
  }
}
