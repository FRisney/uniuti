import 'package:uniuti_core/uniuti_core.dart';

class LoginStore {
  LoginStore(this.remoteRepo);
  late final UsuarioRepository remoteRepo;
  Future<LoginState> login(Aluno aluno) async {
    String? response;
    try {
      response = await remoteRepo.performLogin(aluno);
    } catch (e) {
      return FailLoginState(e.toString());
    }
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
