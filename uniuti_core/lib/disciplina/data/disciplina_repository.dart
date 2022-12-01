part of '../../uniuti_core.dart';

abstract class DisciplinaRepository implements Repository<Disciplina> {}

class MockDisciplinaRepository implements DisciplinaRepository {
  @override
  Future<Disciplina> byId(String id) async {
    return Disciplina(
      id: id,
      nome: 'DisciplinaMock',
      descricao: 'Disciplina teste',
    );
  }

  @override
  Future<List<Disciplina>> getAll() async {
    return [
      await byId('0'),
      await byId('1'),
      await byId('2'),
      await byId('3'),
      await byId('4'),
    ];
  }

  @override
  Future<String?> update(Disciplina model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
