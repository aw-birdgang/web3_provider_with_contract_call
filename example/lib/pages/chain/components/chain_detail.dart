import 'package:web3_example/components/default_text_info_col.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/constants.dart';
import '../../../components/default_text_info_col.dart';
import '../../../controllers/chain_controller.dart';
import '../../../models/chain.dart';

class ChainDetail extends StatefulWidget {
  ChainDetail(this.chain, {Key? key}) : super(key: key);
  Chain chain;
  @override
  State<ChainDetail> createState() => _ChainDetailState();
}

class _ChainDetailState extends State<ChainDetail> {
  late ChainController accountController;
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChainController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(""),
          backgroundColor: secondaryColor,
        ),
        body: _consumer(context),
      ),
    );
  }

  Widget _consumer(BuildContext context) {
    return Consumer<ChainController>(
      builder: (context, accountController, child) {
        this.accountController = accountController;
        return _scaffold(context, accountController);
      },
    );
  }


  Widget _scaffold(BuildContext context, ChainController accountController,) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          contentHeaderView(),
          contentView(),
          const Divider(thickness: 2,),
        ],
      ),
    );
  }


  Widget contentHeaderView () {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ],
    );
  }

  Widget contentView () {
    String name = widget.chain.name!;
    int id = widget.chain.id!;
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTextInfoCol(context, "CHAIN NAME", name.toString()),
          getTextInfoCol(context, "CHAIN ID", id.toString()),
        ],
      ),
    );
  }

}
