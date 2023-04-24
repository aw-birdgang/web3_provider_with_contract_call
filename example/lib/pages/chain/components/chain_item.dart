import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../shared/constants.dart';
import '../../../components/default_text_info_col.dart';
import '../../../models/chain.dart';
import 'chain_detail.dart';

class ChainItem extends StatefulWidget {
  ChainItem(this.chain, {Key? key}) : super(key: key);
  Chain chain;
  @override
  State<ChainItem> createState() => _ChainItemState();
}

class _ChainItemState extends State<ChainItem> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white.withOpacity(0.05),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          print("WalletAccountItem > onTap ");
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChainDetail(widget.chain)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            contentView (),
          ],
        ),
      ),
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
          getTextInfoCol(context, "CHAIN ID", id.toString()),
          getTextInfoCol(context, "CHAIN NAME", name.toString()),
        ],
      ),
    );
  }

  Widget flutterSwitch () {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FlutterSwitch(
            value: status,
            onToggle: (val) {
              setState(() {
                status = val;
              });
            },
          ),
        ],
      ),
    );
  }

}
