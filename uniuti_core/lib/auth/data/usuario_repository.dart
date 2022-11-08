part of '../../uniuti_core.dart';

abstract class UsuarioRepository implements Repository<Usuario> {
  Future<String?> performLogin(Aluno usuario);
  Future<String?> performRefreshToken(Aluno usuario);
}

class MockUsuarioRepository implements UsuarioRepository {
  @override
  Future<Usuario?> byId(String id) async {
    return Usuario(id: '-1', login: 'mock', senha: 'mock@123', token: '');
  }

  @override
  Future<List<Usuario>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<String?> performLogin(Aluno usuario) async {
    final val = Random().nextInt(2) == 1;
    return val ? null : 'falha na autenticacao';
  }

  @override
  Future<String?> performRefreshToken(Aluno usuario) {
    return performLogin(usuario);
  }
}
