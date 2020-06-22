import 'package:samapp/model/constant.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:flutter/material.dart';
import 'package:samapp/utils/constant/dimen.dart';

class PortfolioStatisticWidget extends BaseStateFulWidget {

  final BoxConstraints _constraints;

  PortfolioStatisticWidget(this._constraints);

  @override
  _PortfolioStatisticWidgetState createState() => _PortfolioStatisticWidgetState();
}

class _PortfolioStatisticWidgetState extends BaseState<PortfolioStatisticWidget> {
  @override
  Widget getLayout() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: Dimen.spacingSmall, top: Dimen.spacingNormal, bottom: Dimen.spacingTiny),
              child: Text(
                'Thống kê',
                style: Theme.of(context).textTheme.bodyText1,
              )),
          Container(
            margin: EdgeInsets.only(left: Dimen.spacingSmall, right: Dimen.spacingSmall, bottom: Dimen.spacingNormal),
            width: widget._constraints.maxWidth - (Dimen.spacingSmall * 2),
            child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Table(
                  columnWidths: {
                    0: IntrinsicColumnWidth(),
                  },
                  border: TableBorder(
                      horizontalInside: BorderSide(color: Theme.of(context).dividerColor),
                      verticalInside: BorderSide(color: Theme.of(context).dividerColor)),
                  children: [
                    TableRow(children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: Dimen.spacingSmall, bottom: Dimen.spacingSmall, right: Dimen.spacingSmall, left: Dimen.spacingSmall),
                        child: Text(
                          'Loại / Ngày',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Dimen.spacingSmall, bottom: Dimen.spacingSmall),
                        child: Text(
                          '< 30',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Dimen.spacingSmall, bottom: Dimen.spacingSmall),
                        child: Text(
                          '30-60',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Dimen.spacingSmall, bottom: Dimen.spacingSmall),
                        child: Text(
                          '> 60',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                    TableRow(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ListingScorecardTypes.HIGH.colorBg,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              margin: EdgeInsets.only(
                                top: Dimen.spacingTiny,
                                bottom: Dimen.spacingTiny,
                              ),
                              padding: EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal, top: 2, bottom: 2),
                              child: Text(
                                'H',
                                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: Dimen.spacingTiny,
                            bottom: Dimen.spacingTiny,
                          ),
                          child: Text(
                            '...',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: Dimen.spacingTiny,
                            bottom: Dimen.spacingTiny,
                          ),
                          child: Text(
                            '...',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: Dimen.spacingTiny,
                            bottom: Dimen.spacingTiny,
                          ),
                          child: Text(
                            '...',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    TableRow(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ListingScorecardTypes.MEDIUM.colorBg,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            margin: EdgeInsets.only(
                              top: Dimen.spacingTiny,
                              bottom: Dimen.spacingTiny,
                            ),
                            padding: EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal, top: 2, bottom: 2),
                            child: Text(
                              'M',
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '...',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '...',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '...',
                        textAlign: TextAlign.center,
                      ),
                    ]),
                    TableRow(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ListingScorecardTypes.LOW.colorBg,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            margin: EdgeInsets.only(
                              top: Dimen.spacingTiny,
                              bottom: Dimen.spacingTiny,
                            ),
                            padding: EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal, top: 2, bottom: 2),
                            child: Text(
                              'L',
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '...',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '...',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '...',
                        textAlign: TextAlign.center,
                      ),
                    ]),
                    TableRow(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ListingScorecardTypes.UNCLASSIFIED.colorBg,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            margin: EdgeInsets.only(
                              top: Dimen.spacingTiny,
                              bottom: Dimen.spacingTiny,
                            ),
                            padding: EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal, top: 2, bottom: 2),
                            child: Text(
                              'U',
                              style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '...',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '...',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '...',
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ],
                )
            ),
          ),
        ],
      );
}
