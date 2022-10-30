import 'package:http_client/http_client.dart';
import 'package:uniuti_core/uniuti_core.dart';

import '../presentation/recents_list_item.dart';

class MonitoriaStore {
  MonitoriaStore(RemoteClient client)
      : _monitoriaRepos = {
          'localDb': MockMonitoriaRepository(),
          'remote': MonitoriaRemoteRepository(client),
        };
  final Map<String, MonitoriaRepository> _monitoriaRepos;

  Future<List<RecentsListItem>> getMonitorias() async {
    Monitoria? monitoria;
    for (var repo in _monitoriaRepos.values) {
      monitoria = await repo.byId('-1');
      if (monitoria != null) {
        break;
      }
    }
    if (monitoria == null) return [];
    final list = [RecentsListItem(model: monitoria)];
    for (var i = 0; i < 5; i++) {
      list.add(RecentsListItem(model: monitoria));
    }
    return list;
  }
}
