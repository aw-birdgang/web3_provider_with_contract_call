import 'package:web3_example/common/constrant.dart';
import 'package:web3_example/providers/type/list_provider.dart';
import 'package:flutter/widgets.dart';

abstract class PagingListProvider extends ListProvider {
  TextEditingController pageController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String selectedSearchFilter = SEARCH_FILTER_ADDRESS;
  List<String> searchFilterList = [SEARCH_FILTER_ADDRESS, SEARCH_FILTER_USER_ID];

  @override
  void init() {
    pageController.text = "1";
    searchController.text = "";
    currentPage = 1;
    fetchList();
  }

  int getPageRange() {
    return totalCount ~/ batchSize + 1;
  }

  void onSearch() {
    switch(selectedSearchFilter) {
      case SEARCH_FILTER_ALL:
        fetchList();
        break;
      case SEARCH_FILTER_ADDRESS:
        String address = searchController.text;
        print("## onSearch > value :: $address");
        findByAddress(searchController.text);
        break;
      case SEARCH_FILTER_USER_ID:
        String userId = searchController.text;
        print("## onSearch > value :: $userId");
        findByUserId(searchController.text);
        break;
      default:
        fetchList();
        break;
    }
    return;
  }

  void onSearchFilterChanged(String filter) {
    selectedSearchFilter = filter;
    notify();
  }

  void onForwardClicked() {
    print('## onForwardClicked() >> currentPage: $currentPage');
    if(currentPage <= 1) return;
    currentPage--;
    pageController.text = currentPage.toString();
    fetchList();
    return;
  }

  void onBackwardClicked() {
    print('## onBackwardClicked() >> currentPage: $currentPage');
    if(currentPage >= getPageRange()) return;
    currentPage++;
    pageController.text = currentPage.toString();
    fetchList();
    return;
  }

  void onPageChanged(int page) {
    print('## onPageChanged()');
    if(page < 1 || page > getPageRange()) return;
    if(currentPage != page) {
      currentPage = page;
      fetchList();
    }
    notify();
  }
}