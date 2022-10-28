import 'package:http_client/http_client.dart';
import 'package:uniuti_core/uniuti_core.dart';

class RegisterController {
  RegisterState state = RegisterInitial();
  final _cursoRepos = <String, CursoRepository>{
    'localDb': MockCursoRepository(),
  };
  final _alunoRepos = <String, AlunoRepository>{
    'localDb': MockAlunoRepository(),
  };

  RegisterController(RemoteClient client) {
    _alunoRepos['remote'] = AlunoRemoteRepository(client);
    _cursoRepos['remote'] = CursoRemoteRepository(client);
  }

  Future<List<Curso>> getAllCursos() async {
    List<Curso> cursos = [];
    cursos = await ((_cursoRepos['remote']! as CursoRemoteRepository).getAll());
    return cursos;
  }

  Future<RegisterState> register(Aluno aluno) async {
    final registered = await _alunoRepos['remote']!.performRegister(aluno);
    return RegisterSuccess(registered);
  }
}

abstract class RegisterState {}

class RegisterSuccess implements RegisterState {
  final Aluno aluno;

  RegisterSuccess(this.aluno);
}

class RegisterFail implements RegisterState {
  final String message;

  RegisterFail(this.message);
}

class RegisterInitial implements RegisterState {}
