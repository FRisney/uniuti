part of '../../../http_client.dart';

class MonitoriaRemoteRepository implements MonitoriaRepository {
  MonitoriaRemoteRepository(this.client);
  RemoteClient client;

  @override
  Future<Monitoria?> byId(String id) async {
    final response = await client.get('/api/v1/Monitoria/FindAll');
    if (response.statusCode >= 300) {
      throw RemoteClientException('Erro inesperado!');
    }
    return MonitoriaParser.fromMap(response.body);
  }

  @override
  Future<List<Monitoria>> getAll() async {
    final response = await client.get('/api/v1/Monitoria/FindAll');
    final disciplinas = <Monitoria>[];
    if (response.statusCode >= 300) {
      throw RemoteClientException('Erro inesperado!');
    }
    if (response.statusCode != 203) {
      for (var disciplina in (response.body['data'] as List)) {
        disciplinas.add(MonitoriaParser.fromMap(disciplina));
      }
    }
    return disciplinas;
  }
}
