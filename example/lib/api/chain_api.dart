import 'package:web3_example/api/base_api.dart';
import 'package:web3_example/models/chain.dart';

class ChainApi {
  static final _instance = ChainApi._internal();
  factory ChainApi() => _instance;

  ChainApi._internal();

  int totalCount = 0;

  Future<List<Chain>> getClientList(int page, int batchSize) async {
    Map<String, dynamic> data = await Api().get("chain/admin", query: {
      "take": batchSize,
      "page": page,
    });
    var results = data['results'];
    totalCount = data['total'];
    List<Chain> chainList = (results as List)
        .map((x) => Chain.fromJson(x))
        .toList();
    return chainList;
  }
}