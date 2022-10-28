part of '../../../http_client.dart';

class MonitoriaRemoteRepository implements MonitoriaRepository {
  MonitoriaRemoteRepository(this.client);
  RemoteClient client;

  @override
  Future<Monitoria?> byId(String id) {
    // TODO: implement byId
    throw UnimplementedError();
  }

  @override
  Future<List<Monitoria>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
