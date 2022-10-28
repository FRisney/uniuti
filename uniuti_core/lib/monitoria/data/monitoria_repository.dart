part of '../../uniuti_core.dart';

abstract class MonitoriaRepository implements Repository<Monitoria> {}

class MockMonitoriaRepository implements MonitoriaRepository {
  @override
  Future<Monitoria> byId(String id) async {
    final aluno = await MockAlunoRepository().byId('');
    final disciplina = await MockDisciplinaRepository().byId('');
    return Monitoria(
      id: '',
      titulo: 'TITULO',
      descricao:
          'Um produto/monitoria com uma Descricao bem descrita e que parece que nao acaba nunca',
      disciplina: disciplina,
      solicitante: aluno,
      status: Status('OK'),
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
}
