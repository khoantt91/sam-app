import 'package:samapp/ui/common/base_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:samapp/ui/widget/portfolio_kpi_widget.dart';
import 'package:samapp/ui/widget/portfolio_overview_widget.dart';
import 'package:samapp/ui/widget/portfolio_statistic_widget.dart';

class HomePortfolioScreen extends BaseStateLessWidget {
  final BoxConstraints _constraints;

  HomePortfolioScreen(this._constraints);

  @override
  Widget getLayout(BuildContext context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PortfolioOverviewWidget(_constraints),
            PortfolioKpiWidget(_constraints),
            PortfolioStatisticWidget(_constraints),
          ],
        ),
      );
}
