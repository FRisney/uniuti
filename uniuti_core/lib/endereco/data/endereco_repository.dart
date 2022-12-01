part of '../../uniuti_core.dart';

abstract class EnderecoRepository implements Repository<Endereco> {}

class MockEndrecoRepository implements EnderecoRepository {
  @override
  Future<Endereco?> byId(String id) async {
    return Endereco(
      id: id,
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
  Future<String?> update(Endereco model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
