import 'package:flutter/material.dart';

import '../models/chain.dart';
import '../services/chain/repository_chian.dart';

class ChainController extends ChangeNotifier {

  RepositoryChain repositoryHost = RepositoryChain();
  List<Chain> listChains = [];
  late Chain client;
  bool isLoading = true;

  ChainController() {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
  }

  void getChains() async {
    try {
      isLoading = true;
      notifyListeners();
      listChains = await repositoryHost.getChains();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void registerChain(Chain request, {response}) async {
    try {
      isLoading = true;
      notifyListeners();
      client = await repositoryHost.registerChain(request);
      isLoading = false;
      notifyListeners();
      response(client);
    } catch (e) {
      print(e);
    }
  }

}
