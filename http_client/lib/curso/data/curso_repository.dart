part of '../../../http_client.dart';

class CursoRemoteRepository implements CursoRepository {
  final RemoteClient client;
  CursoRemoteRepository(this.client) : super();

  @override
  Future<Curso?> byId(String id) async {
    dev.log(DateTime.now().toIso8601String(), name: 'Curso.getAll');
    var response = await client.get('/v1/Curso/findbyid/$id', params: {});
    Curso? curso;
    curso = CursoParser.fromMap(response.body);
    return curso;
  }

  @override
  Future<List<Curso>> getAll() async {
    dev.log(DateTime.now().toIso8601String(), name: 'Curso.getAll');
    var response = await client.get('/v1/Curso/FindAll', params: {});
    List<Curso> cursos = [];
    if (response.statusCode == 500 || response.statusCode == 204) {
      throw CursoNaoEncontradoException();
    }
    for (Map<String, dynamic> json in response.body['data']) {
      cursos.add(CursoParser.fromMap(json));
    }
    return cursos;
  }

  @override
  Future<String?> update(Curso model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
