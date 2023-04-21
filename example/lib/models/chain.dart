import '../common/map_util.dart';

class Chain {
  String? balance = "0";

  Chain({
    this.balance,
  });

  Map<String, dynamic> toMap() => {
    "balance": balance,
  };

  Chain.fromJson(Map<String, dynamic> map) {
    balance = getItemFromMapForStr(map, "balance");
  }

  @override
  String toString() => '${toMap()}';
}