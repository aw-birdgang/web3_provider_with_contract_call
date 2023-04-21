import 'package:web3_example/shared/loading_status.dart';
import 'package:flutter/widgets.dart';

abstract class ViewProvider extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus();

  notify() {
    notifyListeners();
  }

  void init();

  void startLoading() {
    loadingStatus.start();
    notify();
  }

  void stopLoading() {
    loadingStatus.done();
    notify();
  }
}