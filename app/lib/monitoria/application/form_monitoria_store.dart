import 'package:http_client/http_client.dart';
import 'package:uniuti_core/uniuti_core.dart';

class FormMonitoriaStore {
  late final Monitoria monitoria;

  final _monitoriaRepos = <String, MonitoriaRepository>{
    'localDb': MockMonitoriaRepository(),
  };
  final _disciplinaRepos = <String, DisciplinaRepository>{
    'localDb': MockDisciplinaRepository(),
  };
  final _instituicaoRepos = <String, InstituicaoRepository>{
    'localDb': MockInstituicaoRepository(),
  };
  final Aluno _aluno;

  FormMonitoriaStore(this._aluno, RemoteClient client) {
    _disciplinaRepos['remote'] = DisciplinaRemoteRepository(client);
    _monitoriaRepos['remote'] = MonitoriaRemoteRepository(client);
    _instituicaoRepos['remote'] = InstituicaoRemoteRepository(client);
    monitoria = Monitoria(
      id: '',
      descricao: '',
      criacao: DateTime.now(),
      status: Status('Em Aberto'),
      titulo: '',
    );
  }

  Future<List<Instituicao>> getInstituicao() async {
    late List<Instituicao> instituicoes;
    instituicoes = await _instituicaoRepos['remote']!.getAll();
    return instituicoes;
  }

  Future<List<Disciplina>> getDisciplinas() async {
    late List<Disciplina> disciplinas;
    disciplinas = await _disciplinaRepos['remote']!.getAll();
    return disciplinas;
  }

  Future<PublicarState> publicarMonitoria(TipoSolicitacao tipo) async {
    if (tipo == TipoSolicitacao.solicitar) {
      monitoria.solicitante = _aluno;
    } else if (tipo == TipoSolicitacao.ofertar) {
      monitoria.prestador = _aluno;
    }
    final response = await _monitoriaRepos['remote']!.publicar(monitoria);
    return response == null
        ? SuccessPublicarState()
        : FailPublicarState(response);
  }
}

abstract class PublicarState {}

class SuccessPublicarState extends PublicarState {}

class FailPublicarState extends PublicarState {
  FailPublicarState(this.message);

  final String message;
}

class LoadingPublicarState extends PublicarState {}
