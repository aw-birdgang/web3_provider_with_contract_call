import 'package:web3_example/components/paging_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../models/chain.dart';
import '../../providers/chain_provider.dart';
import 'components/chain_item.dart';

class ChainPage extends StatelessWidget {
  const ChainPage({Key? key}) : super(key: key);

  Widget itemWidget(Chain item) {
    return ChainItem(item, key: Key("chain_${item.id}"));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChainProvider>(
      create: (context) => ChainProvider(),
      child: Consumer<ChainProvider>(
        builder: (context, provider, child) {
          return PagingListView(provider, itemWidget, isSearch: true,);
        },
      ),
    );
  }
}
