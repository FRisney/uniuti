part of '../../../http_client.dart';

class DisciplinaRemoteRepository implements DisciplinaRepository {
  DisciplinaRemoteRepository(this.client);
  RemoteClient client;

  @override
  Future<Disciplina?> byId(int id) {
    // TODO: implement byId
    throw UnimplementedError();
  }

  @override
  Future<List<Disciplina>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<List<Disciplina>> getMany(RepoFilter filter) {
    // TODO: implement getMany
    throw UnimplementedError();
  }
}
