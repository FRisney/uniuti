import '../../shared/application/uniuti_client.dart';
import '../../shared/data/repository.dart';
import '../domain/curso.dart';
import '../exceptions/curso_exceptions.dart';

abstract class CursoRepository extends Repository<Curso> {}

class MockCursoRepository extends CursoRepository {
  @override
  Future<List<Curso>> getAll() async {
    return [
      Curso(
        id: 01,
        nome: 'ADS',
        duracao: 'SIM',
      ),
      Curso(
        id: 02,
        nome: 'ADM',
        duracao: 'SIM',
      ),
    ];
  }

  @override
  Future<Curso> byId(int id) async {
    return Curso(id: id, nome: 'Curso', duracao: '1');
  }

  @override
  Future<List<Curso>> getMany(RepoFilter filter) async {
    return await getAll();
  }
}

class RemoteCursoRepository extends CursoRepository {
  final Uri uri;
  final UniUtiHttpClient client;
  RemoteCursoRepository(this.uri, {required this.client}) : super();

  @override
  Future<Curso?> byId(int id) async {
    var response =
        await client.get(endpoint: '/curso/findbyid/$id', params: {});
    Curso? curso;
    curso = Curso.fromMap(response.body);
    return curso;
  }

  @override
  Future<List<Curso>> getAll() async {
    var response = await client.get(endpoint: '/curso/FindAll', params: {});
    List<Curso> cursos = [];
    for (Map<String, dynamic> json in response.body['items']) {
      cursos.add(Curso.fromMap(json));
    }
    return cursos;
  }

  @override
  Future<List<Curso>> getMany(RepoFilter filter) async {
    final response = await client.get(endpoint: 'Curso/FindAll', params: {});
    final cursos = <Curso>[];
    if (response.statusCode == 204) {
      throw CursoNaoEncontradoException();
    }
    return cursos;
  }
}
