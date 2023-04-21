import 'package:web3_example/pages/account/components/chain_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/account_controller.dart';
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
      create: (context) => AccountController()..getAccount(),
      child: _consumer(context),
    );
  }

  Widget _consumer(BuildContext context) {
    return Consumer<AccountController>(
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
    return context.watch<AccountController>().isLoading
        ? const CircularProgressIndicator()
        : Column(
      children: [
        // const WalletAccountHeader(),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: context.watch<AccountController>().listAccount.length,
            itemBuilder: (context, index) {
              return AccountItem(context
                  .watch<AccountController>()
                  .listAccount[index]);
            }),
      ],
    );
  }

}
