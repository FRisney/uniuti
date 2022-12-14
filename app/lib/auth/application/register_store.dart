import 'package:http_client/http_client.dart';
import 'package:uniuti_core/uniuti_core.dart';

class RegisterStore {
  RegisterState state = RegisterInitial();
  final _cursoRepos = <String, CursoRepository>{
    'localDb': MockCursoRepository(),
  };
  final _alunoRepos = <String, AlunoRepository>{
    'localDb': MockAlunoRepository(),
  };
  final _instituicaoRepos = <String, InstituicaoRepository>{
    'localDb': MockInstituicaoRepository(),
  };

  RegisterStore(RemoteClient client) {
    _alunoRepos['remote'] = AlunoRemoteRepository(client);
    _cursoRepos['remote'] = CursoRemoteRepository(client);
    _instituicaoRepos['remote'] = InstituicaoRemoteRepository(client);
  }

  Future<List<Curso>> getAllCursos() async {
    List<Curso> cursos = [];
    cursos = await _cursoRepos['remote']!.getAll();
    return cursos;
  }

  Future<RegisterState> register(Aluno aluno) async {
    String? message;
    try {
      message = await _alunoRepos['remote']!.performRegister(aluno);
    } on RemoteClientException catch (e) {
      message = e.message;
    }
    if (message != null) {
      return RegisterFail(message);
    }
    return RegisterSuccess();
  }

  Future<List<Instituicao>> getAllInstituicoes() async {
    List<Instituicao> instituicoes = [];
    instituicoes = await _instituicaoRepos['remote']!.getAll();
    return instituicoes;
  }
}

abstract class RegisterState {}

class RegisterSuccess implements RegisterState {}

class RegisterFail implements RegisterState {
  final String message;

  RegisterFail(this.message);
}

class RegisterInitial implements RegisterState {}
