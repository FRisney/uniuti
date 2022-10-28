part of '../../uniuti_core.dart';

abstract class CursoParser {
  static Curso fromMap(Map<String, dynamic> map) {
    return Curso(
      id: map['id'],
      nome: map['nome'],
    );
  }

  static Map<String, dynamic> toMap(Curso curso) {
    return {
      'id': curso.id,
      'nome': curso.nome,
    };
  }

  static Curso fromJson(String json) {
    return fromMap(jsonDecode(json));
  }

  static String toJson(Curso curso) {
    return jsonEncode(toMap(curso));
  }
}
