import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/ui/widget/deal_scorecard_type_widget.dart';
import 'package:samapp/ui/widget/id_box_widget.dart';
import 'package:samapp/ui/widget/left_icon_text_widget.dart';
import 'package:samapp/utils/constant/app_color.dart';
import 'package:samapp/utils/constant/dimen.dart';

class ListingItem extends StatelessWidget {
  final Listing _listing;

  ListingItem(this._listing);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            /* Label - H, M, L, U */
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 56,
                height: 56,
                child: Image.asset(
                  _listing.getListingLabelImage(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /* Header: Price, Area, IDs */
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
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: AutoSizeText(
                              _listing.formatPrice,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimen.fontHuge6, color: Theme.of(context).primaryColor),
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            height: 20,
                            margin: EdgeInsets.only(left: Dimen.spacingSuperTiny, right: Dimen.spacingSuperTiny),
                            child: VerticalDivider(
                              color: Theme.of(context).dividerColor,
                              thickness: 1,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              _listing.propertyTypeId == 8 ? _listing.formatFloorSize : _listing.formatLotSize,
                              // TYPE CHUNG_CU => show formatFloorSize
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimen.fontHuge6, color: Colors.black),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IdBoxWidget(123456),
                        ],
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
                    '${_listing.classifyName} ${_listing.ownerName}',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: Dimen.spacingTiny,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimen.spacingNormal),
                  child: Text(
                    _listing.address,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(
                  height: Dimen.spacingTiny,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_listing.listingTypeName} ${_listing.propertyTypeName}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        _listing.lastCall != null
                            ? '${DateFormat("HH:mm - dd/MM/yyyy").format(DateTime.fromMillisecondsSinceEpoch(_listing.lastCall.toInt()))}'
                            : '',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(fontStyle: FontStyle.italic),
                      )
                    ],
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
                        /* Deal Scorecard type */
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: _buildDealScorecardTypeWidgets(context),
                          ),
                        ),
                        LeftIconTextWidget(_listing.tour.toString(), Dimen.spacingSuperTiny, 'assets/images/ic_car.png'),
                        Container(
                          height: 16,
                          child: VerticalDivider(
                            color: Theme.of(context).dividerColor,
                            thickness: 1,
                          ),
                        ),
                        LeftIconTextWidget(_listing.numberOfListingView.toString(), Dimen.spacingSuperTiny, 'assets/images/ic_eye.png'),

                        /* More Menu */
                        SizedBox(
                          width: Dimen.spacingSmall,
                        ),
                        Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: GestureDetector(
                              onTap: () => {},
                              child: Icon(Icons.more_vert),
                            )),
                      ],
                    ))
              ],
            ),
          ],
        ));
  }

  List<Widget> _buildDealScorecardTypeWidgets(BuildContext context) {
    final List<Widget> firstRow = [];
    final List<Widget> secondRow = [];
    _listing.dealClassify.forEach((key, value) {
      if (value != null && value > 0 && firstRow.length < 4) {
        firstRow.add(DealScorecardTypeWidget(_listing, DealScorecardTypes.LOW_0.getDealScorecardTypeFromStringId(key)));
      } else {
        secondRow.add(DealScorecardTypeWidget(_listing, DealScorecardTypes.LOW_0.getDealScorecardTypeFromStringId(key)));
      }
    });

    return secondRow.length > 0
        ?
        /* Return 2 row */
        [
            Row(children: firstRow),
            SizedBox(height: Dimen.spacingSuperTiny),
            Row(children: secondRow),
          ]
        :
        /* Return 1 row */
        [Row(children: firstRow)];
  }
}
