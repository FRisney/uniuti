part of '../../uniuti_core.dart';

abstract class Repository<T> {
  Future<T?> byId(String id);
  Future<List<T>> getAll();
  Future<String?> update(T model);
}
