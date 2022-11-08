import 'package:http_client/http_client.dart';
import 'package:uniuti_core/uniuti_core.dart';

import '../presentation/recents_list_item.dart';

class MonitoriaStore {
  var _alunoRepos;

  MonitoriaStore(RemoteClient client)
      : _monitoriaRepos = {
          'localDb': MockMonitoriaRepository(),
          'remote': MonitoriaRemoteRepository(client),
        };
  final Map<String, MonitoriaRepository> _monitoriaRepos;

  Future<List<RecentsListItem>> getMonitorias() async {
    var list = await _monitoriaRepos['remote']!.getAll();
    list.map((e) => _alunoRepos['remote'].byId(e.solicitante?.id));
    return list.map((e) => RecentsListItem(model: e)).toList();
  }
}
