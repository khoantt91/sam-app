import 'package:flutter/material.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/utils/constant/dimen.dart';

import 'deal_item.dart';

class DealListView extends StatefulWidget {
  final List<Deal> _dealList;

  DealListView(this._dealList);

  @override
  _DealListViewState createState() => _DealListViewState();
}

class _DealListViewState extends State<DealListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget._dealList.length + 1,
        itemBuilder: (context, index) {
          if (widget._dealList.isEmpty) return SizedBox();
          return (index == widget._dealList.length)
              ? Center(
                  child: Container(
                    margin: EdgeInsets.all(Dimen.spacingSmall),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                )
              : DealItem(widget._dealList[index]);
        });
  }
}
