part of '../../../http_client.dart';

class MonitoriaRemoteRepository implements MonitoriaRepository {
  MonitoriaRemoteRepository(this.client);
  RemoteClient client;

  @override
  late Future<Aluno?> Function(String) getAluno;

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
    final response = await client.get('/v1/Monitoria/FindAll');
    final monitorias = <Monitoria>[];
    if (response.statusCode >= 300) {
      throw RemoteClientException('Erro inesperado!');
    }
    if (response.statusCode != 203) {
      for (var monitoria in (response.body['data'] as List)) {
        monitorias.add(MonitoriaParser.fromMap(monitoria));
      }
      for (var monitoria in monitorias) {
        final solicitante = (response.body['data'] as List)
            .firstWhere((element) => element['id'] == monitoria.id);
        monitoria.solicitante = await getAluno(solicitante['solicitanteId']);
      }
    }
    return monitorias;
  }

  @override
  Future<String?> publicar(Monitoria monitoria) async {
    final response = await client.post('/v1/Monitoria/Create', body: {
      "solicitanteId": monitoria.solicitante!.id,
      "descricao": monitoria.descricao,
      "tipoSolicitacao": monitoria.tipoSolicitacao,
      "disciplinaId": monitoria.disciplina?.id,
    });
    if (response.statusCode >= 500) {
      return response.body['erro'];
    }
    if (response.statusCode >= 400) {
      String ret = '';
      if (response.body['errors'] is Map) {
        ret = parseErrorsMap(response.body['errors'], ret);
      } else if (response.body['errors'] is List) {
        ret = parseErrorsList(response.body['errors'], ret);
      }
      return ret;
    }
    return null;
  }
}
