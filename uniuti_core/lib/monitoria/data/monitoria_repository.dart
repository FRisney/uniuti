part of '../../uniuti_core.dart';

abstract class MonitoriaRepository implements Repository<Monitoria> {
  Future<String?> publicar(Monitoria monitoria);
}

class MockMonitoriaRepository implements MonitoriaRepository {
  @override
  Future<Monitoria> byId(String id) async {
    final aluno = await MockAlunoRepository().byId('');
    final disciplina = await MockDisciplinaRepository().byId('');
    final instituicao = await MockInstituicaoRepository().byId('');
    return Monitoria(
      id: '',
      titulo: 'TITULO',
      descricao:
          'Um produto/monitoria com uma Descricao bem descrita e que parece que nao acaba nunca',
      disciplina: disciplina,
      instituicao: instituicao!,
      solicitante: aluno,
      status: Status('OK'),
      criacao: DateTime.now(),
    );
  }

  @override
  Future<List<Monitoria>> getAll() async {
    final monitorias = <Monitoria>[];
    for (var i = 0; i < 5; i++) {
      monitorias.add(await MockMonitoriaRepository().byId(''));
    }
    return monitorias;
  }

  @override
  Future<String?> publicar(Monitoria monitoria) {
    // TODO: implement publicar
    throw UnimplementedError();
  }
}
