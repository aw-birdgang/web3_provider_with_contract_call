import 'package:flutter/material.dart';

Widget defaultTextField (maxLines, controller, hint) {
  return TextField(
    maxLines: maxLines,
    controller: controller,
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint
    ),
  );
}