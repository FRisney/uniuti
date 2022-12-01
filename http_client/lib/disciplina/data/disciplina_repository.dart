part of '../../../http_client.dart';

class DisciplinaRemoteRepository implements DisciplinaRepository {
  DisciplinaRemoteRepository(this.client);
  RemoteClient client;

  @override
  Future<Disciplina?> byId(String id) async {
    dev.log(DateTime.now().toIso8601String(), name: 'Disciplina.byId');
    final response = await client.get('/api/v1/Disciplina/FindById/$id');
    if (response.statusCode >= 300) {
      throw RemoteClientException('Erro inesperado!');
    }
    if (response.statusCode == 203) return null;

    return DisciplinaParser.fromMap(response.body);
  }

  @override
  Future<List<Disciplina>> getAll() async {
    dev.log(DateTime.now().toIso8601String(), name: 'Disciplina.getAll');
    final response = await client.get('/v1/Disciplina/FindAll');
    final disciplinas = <Disciplina>[];
    if (response.statusCode >= 300) {
      throw RemoteClientException('Erro inesperado!');
    }
    if (response.statusCode != 203) {
      for (var disciplina in (response.body['data'] as List)) {
        disciplinas.add(DisciplinaParser.fromMap(disciplina));
      }
    }
    return disciplinas;
  }

  @override
  Future<String?> update(Disciplina model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
