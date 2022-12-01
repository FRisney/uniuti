part of '../../uniuti_core.dart';

abstract class InstituicaoRepository implements Repository<Instituicao> {}

class MockInstituicaoRepository implements InstituicaoRepository {
  Future<List<Instituicao>> byCurso(String id) async {
    return [
      (await byId('0'))!,
      (await byId('1'))!,
      (await byId('2'))!,
      (await byId('3'))!,
      (await byId('4'))!,
    ];
  }

  @override
  Future<Instituicao?> byId(String id) async {
    return Instituicao(
      id: id,
      nome: 'InstituicaoMock',
      contatos: [Contato('123456789')],
      endereco: Endereco(
        id: '',
        cep: '',
        cidade: '',
        estado: '',
        numero: '',
        pais: '',
        rua: '',
      ),
    );
  }

  @override
  Future<List<Instituicao>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<String?> update(Instituicao model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
