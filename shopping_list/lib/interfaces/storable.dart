abstract class Storable<TKey> {
  void fromJsonMap(Map<String, dynamic> jsonMap);
  Map<String, dynamic> toJsonMap();
  TKey getPrimaryKey();
}
