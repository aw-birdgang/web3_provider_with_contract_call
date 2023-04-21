import 'package:web3_example/shared/responsive.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/callback/callback.dart';

Widget getToggleJustOne (BuildContext context, title, value, {
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
      (value == 0) ? Switch(
        value: false,
        onChanged: (value) {
          callback!(value);
        },
      ) : Switch(
        onChanged: null,
        value: true,
        inactiveThumbColor: Colors.tealAccent,
        inactiveTrackColor: Colors.tealAccent.withOpacity(0.5),
      ),
    ],
  );
}