import 'package:http_client/http_client.dart';
import 'package:uniuti_core/uniuti_core.dart';

class FormMonitoriaController {
  final _disciplinaRepos = <String, DisciplinaRepository>{
    'localDb': MockDisciplinaRepository(),
  };
  final Aluno _aluno;

  FormMonitoriaController(this._aluno, RemoteClient client) {
    _disciplinaRepos['remote'] = DisciplinaRemoteRepository(client);
  }

  Future<List<Disciplina>> getDisciplinas() async {
    late List<Disciplina> disciplinas;
    for (var repo in _disciplinaRepos.values) {
      disciplinas = await repo.getAll();
      if (disciplinas.isNotEmpty) {
        break;
      }
    }
    return disciplinas;
  }
}
