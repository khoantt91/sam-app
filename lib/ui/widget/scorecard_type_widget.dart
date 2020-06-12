import 'package:flutter/material.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/utils/constant/dimen.dart';

class ScorecardTypeWidget extends StatelessWidget {
  final Deal _deal;
  final ListingScorecardTypes _listingScorecardTypes;

  ScorecardTypeWidget(this._deal, this._listingScorecardTypes);

  @override
  Widget build(BuildContext context) {
    Widget _widget;
    if (_deal.listingClassify == null ||
        !_deal.listingClassify.containsKey(_listingScorecardTypes.key) ||
        _deal.listingClassify[_listingScorecardTypes.key] == 0) {
      _widget = buildEmptyScorecardTypeWidget(context);
    } else {
      _widget = buildScorecardTypeWidget(context);
    }
    return _widget;
  }

  Container buildScorecardTypeWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: Dimen.spacingSuperTiny),
        decoration: BoxDecoration(
          color: _listingScorecardTypes.colorBg,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.only(left: Dimen.spacingTiny, right: Dimen.spacingTiny, top: 2, bottom: 2),
        child: Text(
          '${_deal.listingClassify != null ? _deal.listingClassify.containsKey(_listingScorecardTypes.key) ? _deal.listingClassify[_listingScorecardTypes.key] : 0 : 0}H',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: Dimen.fontTiny,
                color: Colors.white,
              ),
        ));
  }

  SizedBox buildEmptyScorecardTypeWidget(BuildContext context) => SizedBox();
}
