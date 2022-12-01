import 'package:http_client/http_client.dart';
import 'package:uniuti_core/uniuti_core.dart';

class MonitoriaStore {
  MonitoriaStore(RemoteClient client) {
    repo = MonitoriaRemoteRepository(client);
  }

  late final MonitoriaRemoteRepository repo;

  Future<String?> performUpdate(Monitoria monitoria) async {
    return await repo.update(monitoria);
  }
}
