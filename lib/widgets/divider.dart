import 'package:flutter/material.dart';

class DividerDefault extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Divider(
        color: Theme.of(context).hoverColor,
        height: 1,
      );
}
