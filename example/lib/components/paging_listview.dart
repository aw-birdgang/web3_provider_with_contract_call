import 'package:web3_example/components/page_selector.dart';
import 'package:web3_example/components/search_container.dart';
import 'package:web3_example/providers/type/paging_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PagingListView extends StatelessWidget {
  PagingListProvider parentListProvider;
  Function itemWidgetFunction;
  bool isSearch;
  PagingListView(this.parentListProvider, this.itemWidgetFunction, {
    this.isSearch = false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PageSelector(parentListProvider),
            if (isSearch) SearchContainer(parentListProvider),
          ],
        ),
        SizedBox(height: 8.0),
        Expanded(
            child: parentListProvider.list.isNotEmpty ? SingleChildScrollView(
              padding: EdgeInsets.all(0.0),
              controller: parentListProvider.scrollController,
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: parentListProvider.list.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  dynamic item = parentListProvider.list[index];
                  return itemWidgetFunction(item);
                }
              ),
            ) : Center(child: CircularProgressIndicator()),
        )
      ],
    );
  }
}
