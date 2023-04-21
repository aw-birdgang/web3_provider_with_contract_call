import '../../models/chain.dart';

abstract class IrepositoryChain {
  Future<List<Chain>> getChains();
  Future<dynamic> registerChain(Chain request,);
}