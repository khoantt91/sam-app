import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/event/tab_deal_event.dart';
import 'package:samapp/bloc/state/tab_deal_state.dart';
import 'package:samapp/bloc/tab_deal_bloc.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/ui/widget/common_app_bar.dart';
import 'package:samapp/ui/widget/common_app_bar_search_widget.dart';
import 'package:samapp/ui/widget/deal_listview.dart';
import 'package:samapp/ui/widget/main_filter.dart';
import 'package:samapp/utils/constant/dimen.dart';

class DealTabScreen extends StatefulWidget {
  const DealTabScreen({Key key}) : super(key: key);

  @override
  _DealTabScreenState createState() => _DealTabScreenState();
}

class _DealTabScreenState extends State<DealTabScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Completer<Null> _refreshCompleter;

  final TextEditingController _controller = TextEditingController();
  String _oldSearchText = "";

  Future<Null> _getDealData() async {
    BlocProvider.of<TabDealBloc>(context).add(GetData(keySearch: _controller.text.toString()));
    _refreshCompleter = Completer<Null>();
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    String _currentErrorMessage = '';
    return BlocListener<TabDealBloc, TabDealState>(
      listener: (ctx, state) {
        /* Handle Error */
        if (state is DataLoadError) {
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
        if (state is DataLoadDone) {
          if (!_refreshCompleter.isCompleted) _refreshCompleter.complete(null);
          return;
        }
      },
      child: LayoutBuilder(
        builder: (ctx, constraint) {
          final appBar = CommonAppBar(
            S.of(context).deal_screen_title,
            showSearchIcon: true,
            showShareIcon: true,
            statusBarHeight: MediaQuery.of(context).padding.top,
            searchEvent: () {
              BlocProvider.of<TabDealBloc>(context).add(DealStartSearch());
            },
          );

          final appSearchBar = CommonSearchAppBar(
            S.of(context).deal_screen_title,
            showSearchIcon: true,
            showShareIcon: true,
            statusBarHeight: MediaQuery.of(context).padding.top,
            controller: _controller,
            cancelSearch: () {
              BlocProvider.of<TabDealBloc>(context).add(DealStopSearch());
              if (_oldSearchText != _controller.text) {
                _oldSearchText = _controller.text;
                _refreshIndicatorKey.currentState.show();
              }
            },
            searchText: (searchKey) {
              if (_oldSearchText != _controller.text) {
                _oldSearchText = _controller.text;
                _refreshIndicatorKey.currentState.show();
              }
            },
          );
          final height = constraint.maxHeight;
          return BlocBuilder<TabDealBloc, TabDealState>(condition: (previousState, state) {
            if (state is InitialState || state is DataStopSearch || state is DataSearch) return true;
            return false;
          }, builder: (ctx, state) {
            return Scaffold(
                appBar: state is DataSearch ? appSearchBar : appBar,
                body: Container(
                  color: Theme.of(context).backgroundColor,
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlocBuilder<TabDealBloc, TabDealState>(condition: (previousState, state) {
                        if (state is InitialState || state is DataTotalItem) return true;
                        return false;
                      }, builder: (ctx, state) {
                        return state is DataTotalItem
                            ? MainFilter(S.of(context).common_count_deal(state.total), false, 0)
                            : MainFilter(S.of(context).common_three_dot, false, 0);
                      }),
                      Container(
                        height: height - appBar.preferredSize.height - 36,
                        margin: EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal),
                        child: RefreshIndicator(
                          key: _refreshIndicatorKey,
                          color: Theme.of(context).primaryColor,
                          onRefresh: _getDealData,
                          child: DealListView(),
                        ),
                      ),
                    ],
                  ),
                ));
          });
        },
      ),
    );
  }
}
