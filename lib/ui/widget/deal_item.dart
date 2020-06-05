import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/utils/dimen.dart';

class DealItem extends StatefulWidget {
  final Deal _deal;

  DealItem(this._deal);

  @override
  _DealItemState createState() => _DealItemState();
}

class _DealItemState extends State<DealItem> {
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
                  widget._deal.getDealLabel(),
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
                      child: Text(
                        '${widget._deal.formatMinPrice} - ${widget._deal.formatMaxPrice}',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: Dimen.fontHuge6, color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF717d9b), width: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Text(
                        'ID: ${widget._deal.dealId}',
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
                    widget._deal.customerName,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: Dimen.spacingTiny,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimen.spacingNormal),
                  child: Text(
                    '${widget._deal.listingTypeName} - ${widget._deal.propertyTypeName} | ${widget._deal.statusName} | ${widget._deal.numberTour}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(
                  height: Dimen.spacingTiny,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimen.spacingNormal),
                  child: Text(
                    '${widget._deal.districtNames}',
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
                        Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF3ba500),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: EdgeInsets.only(left: Dimen.spacingTiny, right: Dimen.spacingTiny, top: 2, bottom: 2),
                            child: Text(
                              '${widget._deal.listingClassify != null ? widget._deal.listingClassify.containsKey('SCORECARD_HIGH') ? widget._deal.listingClassify['SCORECARD_HIGH'] : 0 : 0}H',
                              style: Theme.of(context).textTheme.bodyText2.copyWith(
                                    fontSize: Dimen.fontTiny,
                                    color: Colors.white,
                                  ),
                            )),
                        SizedBox(
                          width: Dimen.spacingSuperTiny,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFff8100),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.only(left: Dimen.spacingTiny, right: Dimen.spacingTiny, top: 2, bottom: 2),
                          child: Text(
                            '${widget._deal.listingClassify != null ? widget._deal.listingClassify.containsKey('SCORECARD_MEDIUM') ? widget._deal.listingClassify['SCORECARD_MEDIUM'] : 0 : 0}M',
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontSize: Dimen.fontTiny,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        SizedBox(
                          width: Dimen.spacingSuperTiny,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFae0303),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.only(left: Dimen.spacingTiny, right: Dimen.spacingTiny, top: 2, bottom: 2),
                          child: Text(
                            '${widget._deal.listingClassify != null ? widget._deal.listingClassify.containsKey('SCORECARD_LOW') ? widget._deal.listingClassify['SCORECARD_LOW'] : 0 : 0}L',
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontSize: Dimen.fontTiny,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        SizedBox(
                          width: Dimen.spacingSuperTiny,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF666666),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.only(left: Dimen.spacingTiny, right: Dimen.spacingTiny, top: 2, bottom: 2),
                          child: Text(
                            '${widget._deal.listingClassify != null ? widget._deal.listingClassify.containsKey('SCORECARD_UNCLASSIFIED') ? widget._deal.listingClassify['SCORECARD_UNCLASSIFIED'] : 0 : 0}U',
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontSize: Dimen.fontTiny,
                                  color: Colors.white,
                                ),
                          ),
                        ),
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
