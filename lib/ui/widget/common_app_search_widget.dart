import 'package:flutter/material.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';

class AppSearchWidget extends BaseStateFulWidget {
  @override
  _AppSearchWidgetState createState() => _AppSearchWidgetState();
}

class _AppSearchWidgetState extends BaseState<AppSearchWidget> {
  @override
  Widget getLayout() => Container(
        height: double.infinity,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) {},
            style: TextStyle(
              color: Colors.black,
            ),
            cursorColor: Theme.of(context).cursorColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              hintText: 'Tìm kiếm',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );
}
