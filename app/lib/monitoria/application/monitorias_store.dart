import 'package:http_client/http_client.dart';
import 'package:uniuti_core/uniuti_core.dart';

import '../presentation/recents_list_item.dart';

class MonitoriaStore {
  MonitoriaStore(RemoteClient client)
      : _monitoriaRepos = {
          'localDb': MockMonitoriaRepository(),
          'remote': MonitoriaRemoteRepository(client),
        },
        _alunoRepos = {
          'localDb': MockAlunoRepository(),
          'remote': AlunoRemoteRepository(client),
        } {
    _monitoriaRepos['remote']!.getAluno = _alunoRepos['remote']!.byId;
  }
  final Map<String, MonitoriaRepository> _monitoriaRepos;
  final Map<String, AlunoRepository> _alunoRepos;

  Future<List<RecentsListItem>> getMonitorias() async {
    var list = await _monitoriaRepos['remote']!.getAll();
    return list.map((e) => RecentsListItem(model: e)).toList();
  }
}
