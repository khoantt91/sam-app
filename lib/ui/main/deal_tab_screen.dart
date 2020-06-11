import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/model/deal.dart';
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

  int _page = 0;
  bool _isLoading = false;

  Future<String> getCountryData() async {
    print('REFRESH DATA');
    _page = 1;
    final repository = RepositoryProvider.of<RepositoryImp>(context);
    final result = await repository.getDeals();
    setState(() {
      _dealList = result.success.list;
    });
  }

  void _loadMore() {
    if (_isLoading) return;
    _isLoading = true;
    _page++;
    final repository = RepositoryProvider.of<RepositoryImp>(context);
    repository.getDeals().then((result) {
      setState(() {
        _dealList.addAll(result.success.list);
        _isLoading = false;
      });
    });
  }

  List<Deal> _dealList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
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
                MainFilter(S.of(context).common_three_dot, false, 0),
                Container(
                  height: height - appBar.preferredSize.height - 36,
                  margin: EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal),
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    color: Theme.of(context).primaryColor,
                    onRefresh: () {
                      return getCountryData();
                    },
                    child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                            /* LOAD MORE */
                            _loadMore();
                          }
                          return;
                        },
                        child: DealListView(_dealList)),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
