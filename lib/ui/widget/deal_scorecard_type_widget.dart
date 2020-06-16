import 'package:flutter/material.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/ui/common/base_stateless_widget.dart';
import 'package:samapp/utils/constant/dimen.dart';

class DealScorecardTypeWidget extends BaseStateLessWidget {
  final Listing _listing;
  final DealScorecardTypes _dealScorecardTypes;

  DealScorecardTypeWidget(this._listing, this._dealScorecardTypes);

  @override
  Widget getLayout(BuildContext context) {
    Widget _widget;
    if (_listing.dealClassify == null ||
        !_listing.dealClassify.containsKey(_dealScorecardTypes.stringId) ||
        _listing.dealClassify[_dealScorecardTypes.stringId] == null ||
        _listing.dealClassify[_dealScorecardTypes.stringId] == 0) {
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
        color: _dealScorecardTypes.colorBg,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.only(left: Dimen.spacingTiny, right: Dimen.spacingTiny, top: 2, bottom: 2),
      child: Text(
        '${_listing.dealClassify != null ? _listing.dealClassify.containsKey(_dealScorecardTypes.stringId) ? _listing.dealClassify[_dealScorecardTypes.stringId] : 0 : 0}${this._dealScorecardTypes.stringId}',
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: Dimen.fontTiny,
              color: Colors.white,
            ),
      ),
    );
  }

  SizedBox buildEmptyScorecardTypeWidget(BuildContext context) => SizedBox();
}
