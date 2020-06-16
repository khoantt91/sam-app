import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/ui/widget/listing_scorecard_type_widget.dart';
import 'package:samapp/utils/constant/dimen.dart';

class DealItem extends StatelessWidget {
  final Deal _deal;

  DealItem(this._deal);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 56,
                height: 56,
                child: Image.asset(
                  _deal.getDealLabelImage(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /* Header */
                const SizedBox(
                  height: Dimen.spacingSmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Dimen.spacingNormal,
                    ),
                    Expanded(
                      flex: 1,
                      child: AutoSizeText(
                        '${_deal.formatMinPrice ?? 'N/A'} - ${_deal.formatMaxPrice ?? 'N/A'}',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimen.fontHuge6, color: Theme.of(context).primaryColor),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF717d9b), width: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Text(
                        'ID: ${_deal.dealId}',
                        style: Theme.of(context).textTheme.caption.copyWith(color: Color(0xFF717d9b)),
                      ),
                    ),
                    SizedBox(
                      width: 44,
                    ),
                  ],
                ),

                /* Content */
                const SizedBox(
                  height: Dimen.spacingSuperTiny,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal),
                  child: Divider(
                    color: Theme.of(context).dividerColor,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: Dimen.spacingTiny,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimen.spacingNormal),
                  child: Text(
                    _deal.customerName ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: Dimen.spacingTiny,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimen.spacingNormal),
                  child: Text(
                    '${_deal.listingTypeName} - ${_deal.propertyTypeName} | ${_deal.statusName} | ${_deal.numberTour}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(
                  height: Dimen.spacingTiny,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimen.spacingNormal),
                  child: Text(
                    '${_deal.districtNames ?? 'N/A'}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),

                /* Footer */
                const SizedBox(
                  height: Dimen.spacingSmall,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    ),
                    padding:
                        EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal, top: Dimen.spacingSmall, bottom: Dimen.spacingSmall),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListingScorecardTypeWidget(_deal, ListingScorecardTypes.HIGH),
                        ListingScorecardTypeWidget(_deal, ListingScorecardTypes.MEDIUM),
                        ListingScorecardTypeWidget(_deal, ListingScorecardTypes.LOW),
                        ListingScorecardTypeWidget(_deal, ListingScorecardTypes.UNCLASSIFIED),
                        Expanded(
                            flex: 1,
                            child: Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: GestureDetector(
                                  onTap: () => {},
                                  child: Icon(Icons.more_vert),
                                ))),
                      ],
                    ))
              ],
            ),
          ],
        ));
  }
}
