import 'package:flutter/material.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/utils/constant/app_color.dart';
import 'package:samapp/utils/constant/dimen.dart';

class PortfolioOverviewWidget extends BaseStateFulWidget {
  final BoxConstraints _constraints;

  PortfolioOverviewWidget(this._constraints);

  @override
  _PortfolioOverviewWidgetState createState() => _PortfolioOverviewWidgetState();
}

class _PortfolioOverviewWidgetState extends BaseState<PortfolioOverviewWidget> {
  @override
  Widget getLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* Title */
        Container(
            margin: EdgeInsets.only(left: Dimen.spacingSmall, top: Dimen.spacingNormal, bottom: Dimen.spacingTiny),
            child: Text(
              'Tổng quan',
              style: Theme.of(context).textTheme.bodyText1,
            )),
        /* Content */
        _buildPortfolioStatistic(widget._constraints),
      ],
    );
  }

  Container _buildPortfolioStatistic(BoxConstraints constraint) {
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
}
