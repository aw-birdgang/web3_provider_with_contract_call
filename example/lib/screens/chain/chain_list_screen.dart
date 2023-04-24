import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/chain_controller.dart';
import '../../pages/chain/components/chain_item.dart';
import '../../shared/constants.dart';

class ChainListScreen extends StatefulWidget {
  const ChainListScreen({Key? key}) : super(key: key);
  @override
  State<ChainListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<ChainListScreen> {
  late ChainController accountController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChainController()..getChains(),
      child: _consumer(context),
    );
  }

  Widget _consumer(BuildContext context) {
    return Consumer<ChainController>(
      builder: (context, accountController, child) {
        this.accountController = accountController;
        return _scaffold(context);
      },
    );
  }

  Widget _scaffold(BuildContext context,) {
    return RefreshIndicator(
      backgroundColor: primaryColor,
      color: secondaryColor,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500));
      },
      child: contentView(context,),
    );
  }

  Widget contentView (BuildContext context) {
    return context.watch<ChainController>().isLoading
        ? const CircularProgressIndicator()
        : Column(
      children: [
        // const WalletAccountHeader(),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: context.watch<ChainController>().listChains.length,
            itemBuilder: (context, index) {
              return ChainItem(context
                  .watch<ChainController>()
                  .listChains[index]);
            }),
      ],
    );
  }

}
