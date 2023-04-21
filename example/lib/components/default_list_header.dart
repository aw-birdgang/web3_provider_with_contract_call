import 'package:web3_example/shared/constants.dart';
import 'package:web3_example/shared/responsive.dart';
import 'package:flutter/material.dart';

Widget contentHeaderView (BuildContext context, var refleshCallback, var writeCallback) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ElevatedButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
          ),
        ),
        onPressed: () {
          print("ClientListScreen > onPressed ");
          refleshCallback();
        },
        icon: const Icon(Icons.swap_horiz),
        label: const Text("새로 고침"),
      ),
      const SizedBox(width: 10,),
      ElevatedButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
          ),
        ),
        onPressed: () {
          print("ClientListScreen > onPressed ");
          writeCallback();
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientAdd()));
        },
        icon: const Icon(Icons.add),
        label: const Text("추가"),
      ),
    ],
  );
}
