import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/widget/common_app_bar.dart';
import 'package:samapp/ui/widget/deal_item.dart';
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
                Container(
                  height: 36,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: Dimen.spacingNormal),
                      Expanded(
                          child: Text(
                        S.of(context).common_count_deal(56),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                      )),
                      const Expanded(child: const SizedBox(width: Dimen.spacingNormal)),
                      Expanded(
                          child: Text(
                        S.of(context).common_filter_data,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.end,
                      )),
                      SizedBox(width: Dimen.spacingTiny),
                      Container(
                        width: 32,
                        height: 32,
                        child: Stack(
                          children: [
                            Align(
                              child: ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: Text(
                                    '\u25CF',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Dimen.fontTiny,
                                    ),
                                  ),
                                ),
                              ),
                              alignment: Alignment.topRight,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 24,
                                height: 24,
                                child: Image.asset('assets/images/ic_filter.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Dimen.spacingTiny),
                      Container(
                        width: 32,
                        height: 32,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                  child: FittedBox(
                                    child: Text(
                                      '24',
                                      style: Theme.of(context).textTheme.overline.copyWith(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: Dimen.fontTiny,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 24,
                                height: 24,
                                child: Image.asset('assets/images/ic_filter_user.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimen.spacingNormal),
                    ],
                  ),
                ),
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
                          print('LOAD MORE');
                          _loadMore();
                        }
                        return;
                      },
                      child: ListView.builder(
                          itemCount: _dealList.length + 1,
                          itemBuilder: (context, index) {
                            if (_dealList.isEmpty) return SizedBox();
                            return (index == _dealList.length)
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
                                : DealItem(_dealList[index]);
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
