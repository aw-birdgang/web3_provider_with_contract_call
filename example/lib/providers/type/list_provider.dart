import 'package:web3_example/common/constrant.dart';
import 'package:web3_example/providers/type/view_provider.dart';
import 'package:flutter/cupertino.dart';

abstract class ListProvider extends ViewProvider {
  List<dynamic> list = [];
  ScrollController scrollController = ScrollController();

  int currentPage = 0;
  int totalCount = 0;
  int batchSize = FETCH_SIZE;

  void clear() {
    list.clear();
    notify();
  }

  Future<void> fetchList({int page = 1, int size = FETCH_SIZE});
  Future<void> findByAddress(String address);
  Future<void> findByUserId(String userId);
}