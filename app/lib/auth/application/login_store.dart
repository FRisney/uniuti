import 'package:http_client/http_client.dart';
import 'package:uniuti_core/uniuti_core.dart';

class LoginStore {
  LoginStore(RemoteClient client) {
    remoteRepo = UsuarioRemoteRepository(client);
  }
  late final UsuarioRepository remoteRepo;
  Future<LoginState> login(Aluno aluno) async {
    final response = await remoteRepo.performLogin(aluno);
    if (response != null) {
      return FailLoginState(response);
    }
    return SuccessLoginState();
  }
}

abstract class LoginState {
  Object? get data;

  LoginState();
}

class LoadLoginState extends LoginState {
  @override
  String get data => 'Carregando ...';
}

class SuccessLoginState extends LoginState {
  @override
  Object? get data => 'Autenticado com sucesso';
}

class FailLoginState extends LoginState {
  FailLoginState(this.message);
  late String message;

  @override
  String get data => message;
}
