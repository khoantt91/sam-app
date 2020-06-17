import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/ui/onboarding/splash_screen.dart';
import 'package:samapp/utils/constant/app_color.dart';
import 'package:samapp/utils/constant/dimen.dart';

class HomeTabScreen extends BaseStateFulWidget {
  HomeTabScreen({Key key}) : super(key: key);

  @override
  _HomeTabScreen createState() => _HomeTabScreen();
}

class _HomeTabScreen extends BaseState<HomeTabScreen> {
  @override
  void initState() {
    super.initState();
    final _repository = RepositoryProvider.of<RepositoryImp>(context);
    _showUserInfo(_repository);
  }

  @override
  Widget getLayout() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (ctx, constraint) {
          return Container(
            height: constraint.maxHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 132,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/bg_home_header.png',
                        fit: BoxFit.fill,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Container(
                              width: 68,
                              height: 68,
                              margin: EdgeInsets.only(left: Dimen.spacingNormal, bottom: Dimen.spacingNormal),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/ic_default_image.jpg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Container(
                              height: 68,
                              margin: EdgeInsets.only(left: Dimen.spacingSmall, bottom: Dimen.spacingNormal),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    _userName,
                                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                                  ),
                                  _simplePopup(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(right: Dimen.spacingNormal),
                          child: FloatingActionButton(child: Image.asset('assets/images/ic_logout.png'), onPressed: () => {_logout(context)}),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: constraint.maxHeight - 132,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: Dimen.spacingSmall, top: Dimen.spacingNormal, bottom: Dimen.spacingTiny),
                            child: Text(
                              'Tổng quan',
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
                        _buildPorfolioStatistic(constraint),
                        Container(
                            margin: EdgeInsets.only(left: Dimen.spacingSmall, top: Dimen.spacingNormal, bottom: Dimen.spacingTiny),
                            child: Text(
                              'KPI (Month to date)',
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
                        Container(
                          margin: EdgeInsets.only(
                            left: Dimen.spacingSmall,
                            right: Dimen.spacingSmall,
                          ),
                          width: constraint.maxWidth - (Dimen.spacingSmall * 2),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Dimen.spacingSmall,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(left: Dimen.spacingSmall),
                                        child: Text('Số live listing hiện tại'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: Dimen.spacingSmall),
                                      child: Text(
                                        '10/50',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: Dimen.spacingSmall,
                                    right: Dimen.spacingSmall,
                                    top: Dimen.spacingSuperTiny,
                                  ),
                                  child: LinearPercentIndicator(
                                    lineHeight: 12.0,
                                    percent: 0.8,
                                    backgroundColor: Color(0xFFEEEEEE),
                                    progressColor: AppColor.colorKellyGreen,
                                  ),
                                ),
                                SizedBox(
                                  height: Dimen.spacingSmall,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(left: Dimen.spacingSmall),
                                        child: Text('Số live listing hiện tại'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: Dimen.spacingSmall),
                                      child: Text(
                                        '10/50',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: Dimen.spacingSmall,
                                    right: Dimen.spacingSmall,
                                    top: Dimen.spacingSuperTiny,
                                  ),
                                  child: LinearPercentIndicator(
                                    lineHeight: 12.0,
                                    percent: 0.3,
                                    backgroundColor: Color(0xFFEEEEEE),
                                    progressColor: AppColor.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: Dimen.spacingSmall,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(left: Dimen.spacingSmall),
                                        child: Text('Số live listing hiện tại'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: Dimen.spacingSmall),
                                      child: Text(
                                        '10/50',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: Dimen.spacingSmall,
                                    right: Dimen.spacingSmall,
                                    top: Dimen.spacingSuperTiny,
                                  ),
                                  child: LinearPercentIndicator(
                                    lineHeight: 12.0,
                                    percent: 0.2,
                                    backgroundColor: Color(0xFFEEEEEE),
                                    progressColor: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  height: Dimen.spacingSmall,
                                ),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container _buildPorfolioStatistic(BoxConstraints constraint) {
    return Container(
      width: constraint.maxWidth - (Dimen.spacingSmall * 2),
      margin: EdgeInsets.only(left: Dimen.spacingSmall, right: Dimen.spacingSmall),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            SizedBox(
              height: Dimen.spacingTiny,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Hôm nay',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Tuần',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColor.colorShipCove),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Tháng',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColor.colorShipCove),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Divider(
                    thickness: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Divider(
                    thickness: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Divider(
                    thickness: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimen.spacingTiny,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.only(left: Dimen.spacingSuperTiny, right: Dimen.spacingSuperTiny),
                              child: Text(
                                '200.00%',
                                style: TextStyle(
                                  fontSize: Dimen.fontTiny,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimen.spacingSuperTiny,
                      ),
                      Text(
                        '100,589',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Dimen.spacingTiny, right: Dimen.spacingSuperTiny),
                        child: Divider(
                          thickness: 1,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      Text(
                        'Live Listing',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.colorKellyGreen,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.only(left: Dimen.spacingSuperTiny, right: Dimen.spacingSuperTiny),
                              child: Text(
                                '200.00%',
                                style: TextStyle(
                                  fontSize: Dimen.fontTiny,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimen.spacingSuperTiny,
                      ),
                      Text(
                        '100,589',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Dimen.spacingTiny, right: Dimen.spacingSuperTiny),
                        child: Divider(
                          thickness: 1,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      Text(
                        'GMV (tỷ)',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.colorKellyGreen,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.only(left: Dimen.spacingSuperTiny, right: Dimen.spacingSuperTiny),
                              child: Text(
                                '200.00%',
                                style: TextStyle(
                                  fontSize: Dimen.fontTiny,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimen.spacingSuperTiny,
                      ),
                      Text(
                        '100,589',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Dimen.spacingTiny, right: Dimen.spacingSuperTiny),
                        child: Divider(
                          thickness: 1,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      Text(
                        'Doanh thu (tỷ)',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: Dimen.spacingSmall,
            )
          ],
        ),
      ),
    );
  }

  String _title = 'Buyer Advisor';

  Widget _simplePopup() => PopupMenuButton<int>(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.only(
            left: Dimen.spacingSmall,
            right: Dimen.spacingSmall,
          ),
          child: Row(
            children: [
              Text(
                _title,
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black),
                textAlign: TextAlign.left,
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Buyer Advisor"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Seller Advisor"),
          ),
        ],
        onSelected: (value) {
          setState(() {
            if (value == 1)
              _title = 'Buyer Advisor';
            else
              _title = 'Seller Advisor';
          });
        },
      );

  void _logout(BuildContext context) async {
    final repository = RepositoryProvider.of<RepositoryImp>(context);
    final logoutResult = await repository.logout('Android');
    if (logoutResult.success != null) {
      Fluttertoast.showToast(
        msg: 'Logout successuflly',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.of(context).pushReplacementNamed(SplashScreenWidget.routerName);
    } else {
      Fluttertoast.showToast(
        msg: 'Logout error = ${logoutResult.error.message}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  String _userName = '';

  void _showUserInfo(RepositoryImp repository) async {
    final result = await repository.getCurrentUser();
    if (result.success != null) {
      setState(() {
        _userName = result.success?.name ?? '';
      });
    } else {
      showErrorSnackbar(result.error.message);
    }
  }
}
