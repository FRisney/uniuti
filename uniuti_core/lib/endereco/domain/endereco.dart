part of '../../uniuti_core.dart';

class Endereco {
  String id;
  String cep;
  String rua;
  String numero;
  String cidade;
  String estado;
  String pais;

  Endereco({
    required this.id,
    required this.cep,
    required this.rua,
    required this.numero,
    required this.cidade,
    required this.estado,
    required this.pais,
  });
  @override
  String toString() => '$rua, $numero - $cidade, $estado, $pais';
}
