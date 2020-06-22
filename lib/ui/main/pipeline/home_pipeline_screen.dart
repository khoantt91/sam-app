import 'package:samapp/ui/common/base_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:samapp/ui/widget/portfolio_kpi_widget.dart';
import 'package:samapp/ui/widget/portfolio_overview_widget.dart';
import 'package:samapp/ui/widget/portfolio_statistic_widget.dart';

class HomePipelineScreen extends BaseStateLessWidget {
  final BoxConstraints _constraints;

  HomePipelineScreen(this._constraints);

  @override
  Widget getLayout(BuildContext context) => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PortfolioStatisticWidget(_constraints),
      ],
    ),
  );
}
