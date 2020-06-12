import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/tab_deal_bloc.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/main/chat_tab_screen.dart';
import 'package:samapp/ui/main/deal_tab_screen.dart';
import 'package:samapp/ui/main/home_tab_screen.dart';
import 'package:samapp/ui/main/listing_tab_screen.dart';
import 'package:samapp/ui/main/notification_tab_screen.dart';
import 'package:samapp/ui/widget/faded_index_stack.dart';

class MainTabScreen extends StatefulWidget {
  static const routerName = '/main-screen/';

  @override
  _MainTabScreen createState() => _MainTabScreen();
}

class _MainTabScreen extends State<MainTabScreen> {
  var _selectedIndexPage = 0;
  final List<Widget> _pages = [HomeTabScreen()];

  int get _indexPageInList {
    switch (_selectedIndexPage) {
      /* Home Page */
      case 0:
        return _pages.indexWhere((page) => page is HomeTabScreen);
      case 1:
        return _pages.indexWhere((page) => page is ListingTabScreen);
      case 2:
        return _pages.indexWhere((page) => page is DealTabScreen);
      case 3:
        return _pages.indexWhere((page) => page is ChatTabScreen);
      case 4:
        return _pages.indexWhere((page) => page is NotificationTabScreen);
      default:
        return 0;
    }
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        if (_pages.indexWhere((page) => page is HomeTabScreen) == -1) _pages.add(HomeTabScreen());
        break;
      case 1:
        if (_pages.indexWhere((page) => page is ListingTabScreen) == -1) _pages.add(ListingTabScreen());
        break;
      case 2:
        if (_pages.indexWhere((page) => page is DealTabScreen) == -1) _pages.add(DealTabScreen());
        break;
      case 3:
        if (_pages.indexWhere((page) => page is ChatTabScreen) == -1) _pages.add(ChatTabScreen());
        break;
      case 4:
        if (_pages.indexWhere((page) => page is NotificationTabScreen) == -1) _pages.add(NotificationTabScreen());
        break;
    }
    setState(() {
      _selectedIndexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Theme.of(context).secondaryHeaderColor));

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<TabDealBloc>(
            create: (context) => TabDealBloc(RepositoryProvider.of<RepositoryImp>(context)),
          ),
        ],
        child: Container(
          child: FadeIndexedStack(
            index: _indexPageInList,
            children: _pages,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _navigateToPage,
        backgroundColor: Theme.of(context).accentColor,
        unselectedItemColor: Color(0x4D000000),
        selectedItemColor: Theme.of(context).primaryColor,
        showUnselectedLabels: true,
        currentIndex: _selectedIndexPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Theme.of(context).accentColor,
            title: Text(S.of(context).bottom_main_menu_home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            backgroundColor: Theme.of(context).accentColor,
            title: Text(S.of(context).bottom_main_menu_listing),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.departure_board),
            backgroundColor: Theme.of(context).accentColor,
            title: Text(S.of(context).bottom_main_menu_deal),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            backgroundColor: Theme.of(context).accentColor,
            title: Text(S.of(context).bottom_main_menu_chat),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            backgroundColor: Theme.of(context).accentColor,
            title: Text(S.of(context).bottom_main_menu_notification),
          ),
        ],
      ),
    );
  }
}
