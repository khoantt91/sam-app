import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/event/tab_deal_event.dart';
import 'package:samapp/bloc/state/tab_deal_state.dart';
import 'package:samapp/bloc/tab_deal_bloc.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/widget/common_app_bar.dart';
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

  Future<Null> _getDealData() async {
    BlocProvider.of<TabDealBloc>(context).add(GetData());
    await BlocListener<TabDealBloc, TabDealState>(listener: (ctx, state) {
      if (state is DataLoadDone) return null;
    });
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
    return BlocListener<TabDealBloc, TabDealState>(
      listener: (ctx, state) {
        /* Handle Error */
        if (state is DataLoadError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${state.error}',
                style: TextStyle(color: Colors.red),
              ),
              backgroundColor: Colors.white,
              duration: Duration(seconds: 1),
            ),
          );
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
                        child: NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                                /* LOAD MORE */
                                BlocProvider.of<TabDealBloc>(context).add(GetMoreData());
                              }
                              return;
                            },
                            child: DealListView()),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
