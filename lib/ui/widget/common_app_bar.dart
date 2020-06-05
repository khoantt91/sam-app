import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samapp/utils/dimen.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final _height = AppBar().preferredSize.height;
  final double statusBarHeight;

  final String _title;

  final bool showSearchIcon;
  final bool showBackIcon;
  final bool showShareIcon;

  CommonAppBar(
    this._title, {
    this.showSearchIcon = false,
    this.showBackIcon = false,
    this.showShareIcon = false,
    this.statusBarHeight = 0,
  });

  @override
  _CommonAppBarState createState() => _CommonAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(_height + statusBarHeight);
}

class _CommonAppBarState extends State<CommonAppBar> {
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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget._title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: Dimen.spacingNormal,
                    ),
                    widget.showBackIcon
                        ? Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )
                        : SizedBox(),
                    Expanded(flex: 1, child: SizedBox()),
                    widget.showSearchIcon
                        ? Icon(
                            Icons.search,
                            color: Colors.white,
                          )
                        : SizedBox(),
                    widget.showShareIcon
                        ? const SizedBox(
                            width: Dimen.spacingSmall,
                          )
                        : const SizedBox(
                            width: Dimen.spacingNormal,
                          ),
                    widget.showShareIcon
                        ? Icon(
                            Icons.share,
                            color: Colors.white,
                          )
                        : SizedBox(),
                    widget.showShareIcon
                        ? const SizedBox(
                            width: Dimen.spacingNormal,
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
