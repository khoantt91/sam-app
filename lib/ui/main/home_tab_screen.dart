import 'package:flutter/material.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/ui/main/pipeline/home_pipeline_screen.dart';
import 'package:samapp/ui/main/portfolio/home_portfolio_screen.dart';
import 'package:samapp/ui/widget/faded_index_stack.dart';
import 'package:samapp/ui/widget/main_header_app_bar_widget.dart';

class HomeTabScreen extends BaseStateFulWidget {
  @override
  State<StatefulWidget> createState() => _HomeTabScreen();
}

class _HomeTabScreen extends BaseState<HomeTabScreen> {
  var _selectedIndexPage = 0;
  final List<Widget> _pages = [];

  int get _indexPageInList {
    switch (_selectedIndexPage) {
      /* Home Page */
      case 0:
        return _pages.indexWhere((page) => page is HomePortfolioScreen);
      case 1:
        return _pages.indexWhere((page) => page is HomePipelineScreen);
      default:
        return 0;
    }
  }

  void _navigateToPage(int index, BoxConstraints constraints) {
    switch (index) {
      case 0:
        if (_pages.indexWhere((page) => page is HomePortfolioScreen) == -1) _pages.add(HomePortfolioScreen(constraints));
        break;
      case 1:
        if (_pages.indexWhere((page) => page is HomePipelineScreen) == -1) _pages.add(HomePipelineScreen(constraints));
        break;
    }
    setState(() {
      _selectedIndexPage = index;
    });
  }

  @override
  Widget getLayout() {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        final appBarHeight = 132 + MediaQuery.of(context).padding.top;
        return Container(
          height: constraint.maxHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MainAppBarWidget(appBarHeight, _navigateToPage, constraint),
              Container(
                height: constraint.maxHeight - appBarHeight,
                width: double.infinity,
                child: _buildFadeIndexedStack(constraint),
              ),
            ],
          ),
        );
      },
    );
  }

  FadeIndexedStack _buildFadeIndexedStack(BoxConstraints constraints) {
    if (_pages.length == 0) _pages.add(HomePortfolioScreen(constraints));
    return FadeIndexedStack(
      index: _indexPageInList,
      children: _pages,
    );
  }
}
