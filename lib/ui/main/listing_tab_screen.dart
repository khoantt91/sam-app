import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/event/listing_tab_event.dart';
import 'package:samapp/bloc/listing_tab_bloc.dart';
import 'package:samapp/bloc/state/listing_tab_state.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/ui/widget/common_app_bar.dart';
import 'package:samapp/ui/widget/listing_listview_widget.dart';
import 'package:samapp/ui/widget/main_filter.dart';
import 'package:samapp/utils/constant/dimen.dart';
import 'package:samapp/utils/log/log.dart';

class ListingTabScreen extends BaseStateFulWidget {
  ListingTabScreen({Key key});

  @override
  _ListingTabScreenState createState() => _ListingTabScreenState();
}

class _ListingTabScreenState extends BaseState<ListingTabScreen> {
  //region Variables
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Completer<Null> _refreshCompleter;

  final TextEditingController _searchTextController = TextEditingController();
  String _oldSearchText = "";

  //endregion

  @override
  void initState() {
    super.initState();
    /* Get data on first time after 200 milliseconds */
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget getLayout() {
    String _currentErrorMessage = '';
    return BlocListener<ListingTabBloc, ListingTabState>(
      listener: (ctx, state) {
        /* Handle Error */
        if (state is ListingTabGetDataFailure) {
          if (!_refreshCompleter.isCompleted) _refreshCompleter.complete(null);
          if (_currentErrorMessage == state.error) return;
          _currentErrorMessage = state.error;
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _currentErrorMessage,
                style: TextStyle(color: Colors.red),
              ),
              backgroundColor: Colors.white,
              duration: Duration(seconds: 1),
            ),
          );
          return;
        }

        /* Handle Load Done => hide refresh indicator */
        if (state is ListingTabGetDataSuccess) {
          if (!_refreshCompleter.isCompleted) _refreshCompleter.complete(null);
          return;
        }
      },
      child: LayoutBuilder(builder: (ctx, constraint) {
        /* Common App Bar */
        final appBar = CommonAppBar(
          S.of(context).listing_screen_title,
          showSearchIcon: true,
          showShareIcon: true,
          statusBarHeight: MediaQuery.of(context).padding.top,
        );
        final height = constraint.maxHeight;

        return Scaffold(
            appBar: appBar,
            body: Container(
              color: Theme.of(context).backgroundColor,
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<ListingTabBloc, ListingTabState>(condition: (previousState, state) {
                    if (state is ListingTabInitial || state is ListingTabGetDataSuccess) return true;
                    return false;
                  }, builder: (ctx, state) {
                    return state is ListingTabGetDataSuccess
                        ? MainFilter(S.of(context).common_count_deal(state.totalItems), false, 0)
                        : MainFilter(S.of(context).common_three_dot, false, 0);
                  }),
                  Container(
                    height: height - appBar.preferredSize.height - 36,
                    margin: EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal),
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: Theme.of(context).primaryColor,
                      onRefresh: _getListingData,
                      child: ListingListViewWidget(),
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }

  Future<Null> _getListingData() async {
    BlocProvider.of<ListingTabBloc>(context).add(ListingTabGetData(keySearch: _searchTextController.text.toString()));
    _refreshCompleter = Completer<Null>();
    return _refreshCompleter.future;
  }
}
