import 'package:flutter/material.dart';

abstract class BaseStateLessWidget extends StatelessWidget {
  Widget getLayout(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return getLayout(context);
  }
}
