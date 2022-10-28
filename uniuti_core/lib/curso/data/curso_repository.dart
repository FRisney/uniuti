part of '../../uniuti_core.dart';

abstract class CursoRepository implements Repository<Curso> {}

class MockCursoRepository implements CursoRepository {
  @override
  Future<List<Curso>> getAll() async {
    return [
      Curso(id: 01, nome: 'ADS'),
      Curso(id: 02, nome: 'ADM'),
    ];
  }

  @override
  Future<Curso?> byId(int id) async {
    return Curso(id: id, nome: 'Curso');
  }
}
