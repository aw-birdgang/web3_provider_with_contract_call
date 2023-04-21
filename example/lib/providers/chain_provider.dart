import 'package:web3_example/api/account_api.dart';
import 'package:web3_example/api/client_api.dart';
import 'package:web3_example/api/token_transfer_api.dart';
import 'package:web3_example/common/constrant.dart';
import 'package:web3_example/providers/type/paging_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:web3_example/models/token_transfer.dart';
import 'package:web3_example/services/tokenTransfer/repository_token_transfer.dart';

class ChainProvider extends PagingListProvider {
  ChainProvider() {
    init();
  }

  @override
  Future<void> fetchList({int? page, int size = FETCH_SIZE}) async {
    try {
      int fetchPage = page ?? currentPage;
      clear();
      startLoading();
      list.addAll(await ChainApi().getClientList(fetchPage, batchSize));
      totalCount = ChainApi().totalCount;
      stopLoading();
    } catch (e) {
      print('## getClientList() error >> ${e.toString()}');
    }
  }

  @override
  Future<void> findByAddress(String address) {
    throw UnimplementedError();
  }

  @override
  Future<void> findByUserId(String userId) {
    throw UnimplementedError();
  }
}
