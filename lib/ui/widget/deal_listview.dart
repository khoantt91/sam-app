import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/event/tab_deal_event.dart';
import 'package:samapp/bloc/state/tab_deal_state.dart';
import 'package:samapp/bloc/tab_deal_bloc.dart';
import 'package:samapp/utils/constant/dimen.dart';

import '../main/item/deal_item.dart';

class DealListView extends StatefulWidget {
  @override
  _DealListViewState createState() => _DealListViewState();
}

class _DealListViewState extends State<DealListView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  TabDealBloc tabDealBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    tabDealBloc = BlocProvider.of<TabDealBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabDealBloc, TabDealState>(
      condition: (previousState, state) => (state is InitialState || state is DataLoadDone || state is DataLoading) ? true : false,
      builder: (BuildContext context, TabDealState state) {
        if (state is DataLoadDone) return _buildListDeal(state);
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        );
      },
    );
  }

  ListView _buildListDeal(DataLoadDone state) {
    return ListView.builder(
      itemCount: state.hasReachedMax ? state.deals.length : state.deals.length + 1,
      itemBuilder: (context, index) => index >= state.deals.length ? _buildLoadMoreIndicator(context) : DealItem(state.deals[index]),
      controller: _scrollController,
    );
  }

  Center _buildLoadMoreIndicator(BuildContext context) {
    return Center(
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
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      tabDealBloc.add(GetMoreData());
    }
  }
}
