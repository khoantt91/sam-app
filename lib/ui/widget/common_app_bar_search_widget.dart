import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samapp/utils/constant/app_color.dart';
import 'package:samapp/utils/constant/dimen.dart';

class CommonSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final _height = AppBar().preferredSize.height;
  final double statusBarHeight;

  final String _title;

  final bool showSearchIcon;
  final bool showBackIcon;
  final bool showShareIcon;
  final Function cancelSearch;
  final Function searchText;
  final TextEditingController controller;

  CommonSearchAppBar(this._title, {
    this.showSearchIcon = false,
    this.showBackIcon = false,
    this.showShareIcon = false,
    this.statusBarHeight = 0,
    this.cancelSearch,
    this.searchText,
    this.controller
  });

  @override
  _CommonSearchAppBar createState() => _CommonSearchAppBar();

  @override
  Size get preferredSize => Size.fromHeight(_height + statusBarHeight);
}

class _CommonSearchAppBar extends State<CommonSearchAppBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height,
      decoration: BoxDecoration(
        color: Color(0xFF2774BE),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Container(
          margin: EdgeInsets.only(top: widget.statusBarHeight),
          child: Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: double.infinity,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: TextField(
                        controller: widget.controller,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) {
                          widget.searchText(widget.controller.text.toString());
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white30,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Nhập tên hoặc id',
                          hintStyle: TextStyle(color: Colors.white30),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(Dimen.spacingSmall),
                    child: Text(
                      'Hủy',
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  onTap: widget.cancelSearch,
                ),
              ],
            ),
          )),
    );
  }
}
