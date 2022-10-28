part of '../../uniuti_core.dart';

abstract class EnderecoRepository implements Repository<Endereco> {}

class MockEndrecoRepository implements EnderecoRepository {
  @override
  Future<Endereco?> byId(int id) async {
    return Endereco(
      id: '',
      cep: '',
      cidade: '',
      estado: '',
      numero: '',
      pais: '',
      rua: '',
    );
  }

  @override
  Future<List<Endereco>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<List<Endereco>> getMany(RepoFilter filter) {
    // TODO: implement getMany
    throw UnimplementedError();
  }
}
