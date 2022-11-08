part of '../../uniuti_core.dart';

class EnderecoParser {
  static Endereco fromMap(Map<String, dynamic> map) => Endereco(
        id: map['id'],
        cep: map['cep'],
        cidade: map['cidade'],
        estado: map['estado'],
        numero: map['numero'],
        pais: map['pais'],
        rua: map['rua'],
      );

  static Map<String, dynamic> toMap(Endereco endereco) => {
        'id': endereco.id,
        'cep': endereco.cep,
        'cidade': endereco.cidade,
        'estado': endereco.estado,
        'numero': endereco.numero,
        'pais': endereco.pais,
        'rua': endereco.rua,
      };

  static String toJson(Endereco endereco) => jsonEncode(toMap(endereco));

  static Endereco fromJson(String source) => fromMap(jsonDecode(source));
}
