import '../common/map_util.dart';

class Chain {
  int? id = 1;
  String? name = "0";

  Chain({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };

  Chain.fromJson(Map<String, dynamic> map) {
    id = getItemFromMapForInt(map, "id");
    name = getItemFromMapForStr(map, "name");
  }

  @override
  String toString() => '${toMap()}';
}