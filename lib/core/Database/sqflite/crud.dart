abstract class Crud {
  Future<bool> insert(String table, Map<String, Object?> values);

  Future<List<Map<String, Object?>>> search(
    String word,
    String columnName,
    String tableName,
  );

  Future<bool> update(
    String tableName,
    Map<String, Object?> values,
    String? where,
    List<Object?>? whereArgs,
  );

  Future<List<Map<String, Object?>>> select({
    required String table,
    String? where,
    List<Object?>? whereArgs,
  });

  Future<bool> delete(
    String tableName,

    String? where,
    List<Object?>? whereArgs,
  );
}
