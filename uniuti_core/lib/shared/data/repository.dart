part of '../../uniuti_core.dart';

abstract class Repository<T> {
  Future<T?> byId(int id);
  Future<List<T>> getAll();
}
