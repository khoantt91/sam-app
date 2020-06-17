import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/event/listing_tab_event.dart';
import 'package:samapp/bloc/listing_tab_bloc.dart';
import 'package:samapp/bloc/state/listing_tab_state.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/ui/main/item/listing_item.dart';
import 'package:samapp/utils/constant/dimen.dart';
import 'package:samapp/utils/log/log.dart';

class ListingListViewWidget extends BaseStateFulWidget {
  @override
  _ListingListViewWidgetState createState() => _ListingListViewWidgetState();
}

class _ListingListViewWidgetState extends BaseState<ListingListViewWidget> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  ListingTabBloc _bloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget getLayout() {
    _bloc = BlocProvider.of<ListingTabBloc>(context);
    return BlocBuilder<ListingTabBloc, ListingTabState>(
      condition: (previousState, state) =>
          (state is ListingTabInitial || state is ListingTabGetDataSuccess || state is ListingTabGetDataInProgress) ? true : false,
      builder: (BuildContext context, ListingTabState state) {
        if (state is ListingTabGetDataSuccess && (state as ListingTabGetDataSuccess).listings.isNotEmpty) return _buildListListing(state);
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

  Widget _buildListListing(ListingTabGetDataSuccess state) {
    return ListView.builder(
      itemCount: state.hasReachedMax ? state.listings.length : state.listings.length + 1,
      itemBuilder: (context, index) => index >= state.listings.length ? _buildLoadMoreIndicator(context) : ListingItem(state.listings[index]),
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
      _bloc.add(ListingTabGetMoreData());
    }
  }
}
