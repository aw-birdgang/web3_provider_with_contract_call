import 'package:flutter/material.dart';

import '../models/chain.dart';
import '../services/chain/repository_chian.dart';

class ChainController extends ChangeNotifier {

  RepositoryChain repositoryHost = RepositoryChain();
  List<Chain> listClients = [];
  late Chain client;
  bool isLoading = true;

  ChainController() {
    init();
  }

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
  }

  void getClients() async {
    try {
      isLoading = true;
      notifyListeners();
      listClients = await repositoryHost.getChains();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void registerClient(Chain request, {response}) async {
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
