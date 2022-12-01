part of '../../uniuti_core.dart';

abstract class AlunoRepository implements Repository<Aluno> {
  Future<String?> performRegister(Aluno aluno);
}

class MockAlunoRepository implements AlunoRepository {
  @override
  Future<Aluno?> byId(String id) async {
    final usuario = await MockUsuarioRepository().byId('-1');
    final curso = await MockCursoRepository().byId('-1');
    final instituicao = await MockInstituicaoRepository().byId('-1');
    final endereco = await MockEndrecoRepository().byId('-1');
    return Aluno(
      id: '',
      nome: 'Mock',
      usuario: usuario!,
      celular: Celular('1234456789'),
      curso: curso!,
      instituicao: instituicao!,
      endereco: endereco!,
    );
  }

  @override
  Future<List<Aluno>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<String?> performRegister(Aluno aluno) async {
    return null;
  }

  @override
  Future<String?> update(Aluno model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
