import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/utils/constant/app_color.dart';
import 'package:samapp/utils/constant/dimen.dart';

class PortfolioKpiWidget extends BaseStateFulWidget {
  final BoxConstraints _constraints;

  PortfolioKpiWidget(this._constraints);

  @override
  _PortfolioKpiWidgetState createState() => _PortfolioKpiWidgetState();
}

class _PortfolioKpiWidgetState extends BaseState<PortfolioKpiWidget> {
  double _expandHeight = 184;
  bool _isExpand = false;

  @override
  Widget getLayout() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Title */
          Container(
              margin: EdgeInsets.only(left: Dimen.spacingSmall, top: Dimen.spacingNormal, bottom: Dimen.spacingTiny),
              child: Text(
                'KPI (Month to date)',
                style: Theme.of(context).textTheme.bodyText1,
              )),
          /* Content */
          _buildKPIMonthToDateWidget(widget._constraints),
        ],
      );

  Widget _buildKPIMonthToDateWidget(BoxConstraints constraint) {
    return AnimatedContainer(
      height: _expandHeight,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
      child: Container(
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
              _isExpand == false
                  ? GestureDetector(
                      child: Icon(Icons.arrow_drop_down),
                      onTap: () {
                        setState(() {
                          _isExpand = true;
                          _expandHeight = 276;
                        });
                      },
                    )
                  : _buildKPIMonthToDateExpandedWidget(constraint)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKPIMonthToDateExpandedWidget(BoxConstraints constraint) {
    return Column(
      children: [
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
        GestureDetector(
          child: Icon(Icons.arrow_drop_up),
          onTap: () {
            setState(() {
              _isExpand = false;
              _expandHeight = 184;
            });
          },
        )
      ],
    );
  }
}
