part of '../../../http_client.dart';

class MonitoriaRemoteRepository implements MonitoriaRepository {
  MonitoriaRemoteRepository(this.client);
  RemoteClient client;

  @override
  Future<Monitoria?> byId(int id) {
    // TODO: implement byId
    throw UnimplementedError();
  }

  @override
  Future<List<Monitoria>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<List<Monitoria>> getMany(RepoFilter filter) {
    // TODO: implement getMany
    throw UnimplementedError();
  }
}
