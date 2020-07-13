import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/chat/chat_screen.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/ui/main/item/contact_item.dart';
import 'package:samapp/ui/widget/common_app_bar.dart';
import 'package:samapp/ui/widget/common_app_search_widget.dart';
import 'package:samapp/utils/constant/app_color.dart';
import 'package:samapp/utils/constant/dimen.dart';
import 'package:samapp/utils/log/log.dart';

class ChatTabScreen extends BaseStateFulWidget {
  @override
  _ChatTabScreenState createState() => _ChatTabScreenState();
}

class _ChatTabScreenState extends BaseState<ChatTabScreen> {
  List<User> _userList = [];

  @override
  void initState() {
    super.initState();
    _getUserChatList();
  }

  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }

  @override
  Widget getLayout() {
    return LayoutBuilder(builder: (ctx, constraint) {
      /* Common App Bar */
      final appBar = CommonAppBar(
        'Chat',
        showSearchIcon: false,
        showShareIcon: false,
        statusBarHeight: MediaQuery.of(context).padding.top,
      );

      return Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            Container(
              height: 48,
              child: Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: AppSearchWidget(),
                  ),
                ],
              )),
            ),
            Container(
              height: 48,
              padding: EdgeInsets.only(left: Dimen.spacingNormal),
              width: double.infinity,
              color: AppColor.colorSolitude,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Danh sách liên hệ',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              height: constraint.maxHeight - 48 * 2 - appBar.preferredSize.height,
              child: _userList.isEmpty
                  ? Text('No user')
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: _userList.length,
                      itemBuilder: (ctx, index) {
                        return ContactItem(_userList[index], (User user) {
                          Log.w('Select user ${user.name}');
                          Navigator.of(context).pushNamed(ChatScreen.routerName, arguments: user);
                        });
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ),
            )
          ],
        ),
      );
    });
  }

  void _getUserChatList() async {
    final repository = RepositoryProvider.of<RepositoryImp>(context);
    final currentUserResult = await repository.getCurrentUser();
    repository.getUserChatList(currentUserResult.success).then((result) {
      Log.d('Result get user chat list = ${result.success.list.length}');
      if (result.error != null) return Log.e('Error ${result.error.message}');
      setState(() {
        _userList = result.success.list;
      });
    });

    _observerUserList(repository);
  }

  StreamSubscription stream;

  void _observerUserList(RepositoryImp repository) {
    stream = repository.observerUserList().listen((userResult) {
      final index = _userList.indexWhere((user) => user.userId == userResult.success.userId);

      if (index == -1) return;
      setState(() {
        _userList[index].isOnline = userResult.success.isOnline;
      });
    });
  }
}
