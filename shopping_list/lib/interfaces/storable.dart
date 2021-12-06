abstract class Storable<TKey> {
  Map<String, dynamic> toJsonMap();
  TKey getPrimaryKey();
}
