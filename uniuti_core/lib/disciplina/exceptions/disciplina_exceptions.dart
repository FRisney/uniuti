part of '../../uniuti_core.dart';

class DisciplinaException extends UniUtiException {
  DisciplinaException(super.message);
}

class DisciplinaNaoEncontradaException extends DisciplinaException {
  DisciplinaNaoEncontradaException()
      : super('Não foi possível encontrar esta disciplina!');
}
