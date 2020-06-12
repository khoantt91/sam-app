import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/state/tab_deal_state.dart';
import 'package:samapp/bloc/tab_deal_bloc.dart';
import 'package:samapp/utils/constant/dimen.dart';

import 'deal_item.dart';

class DealListView extends StatefulWidget {
  @override
  _DealListViewState createState() => _DealListViewState();
}

class _DealListViewState extends State<DealListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabDealBloc, TabDealState>(
      builder: (BuildContext context, TabDealState state) {
        return state is DataLoadDone
            ? ListView.builder(
                itemCount: state.deals.length + 1,
                itemBuilder: (context, index) {
                  if (state.deals.isEmpty) return SizedBox();
                  return (index == state.deals.length)
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
                      : DealItem(state.deals[index]);
                })
            : SingleChildScrollView(
                child: SizedBox(),
              );
      },
    );
  }
}
