import 'package:web3_example/shared/responsive.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/callback/callback.dart';

Widget getToggle (BuildContext context, title, value, {
  textColor,
  ViewCallback? callback,
  expand = false,
}) {
  textColor = textColor ?? Colors.green.shade300;
  return Row(
    children: [
      SizedBox(
        child: EasyRichText(
          title,
          defaultStyle: TextStyle(fontSize: !Responsive.isDesktop(context) ? 10 : 15),
        ),
      ),
      const SizedBox(
        width: 5.0,
      ),
      Switch(
        value: (value == 1) ? true : false,
        onChanged: (value) {
          callback!(value);
        },
      ),
    ],
  );
}