import 'package:flutter/material.dart';
import 'package:samapp/ui/common/base_stateless_widget.dart';

class IdBoxWidget extends BaseStateLessWidget {
  final int _id;

  IdBoxWidget(this._id);

  @override
  Widget getLayout(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF717d9b), width: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.all(2),
      child: Text(
        'ID: $_id',
        style: Theme.of(context).textTheme.caption.copyWith(color: Color(0xFF717d9b)),
      ),
    );
  }
}
