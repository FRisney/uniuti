part of '../../uniuti_core.dart';

class MonitoriaException extends UniUtiException {
  MonitoriaException(super.message);
}

class SolicitantePrestadorInvalidosException extends MonitoriaException {
  SolicitantePrestadorInvalidosException()
      : super('Montitoria sem Solicitante ou Prestador.');
}
