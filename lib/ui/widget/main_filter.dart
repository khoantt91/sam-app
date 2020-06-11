import 'package:flutter/material.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/utils/constant/dimen.dart';

class MainFilter extends StatefulWidget {
  final String totalItems;
  final bool hasFilter;
  final int numberFilterUser;

  MainFilter(this.totalItems, this.hasFilter, this.numberFilterUser);

  @override
  _MainFilterState createState() => _MainFilterState();
}

class _MainFilterState extends State<MainFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: Dimen.spacingNormal),
          Expanded(
              child: Text(
            widget.totalItems,
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
          )),
          const Expanded(child: const SizedBox(width: Dimen.spacingNormal)),
          Expanded(
              child: Text(
            S.of(context).common_filter_data,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.end,
          )),
          SizedBox(width: Dimen.spacingTiny),
          Container(
            width: 32,
            height: 32,
            child: Stack(
              children: [
                if (widget.hasFilter)
                  Align(
                    child: ClipOval(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          '\u25CF',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimen.fontTiny,
                          ),
                        ),
                      ),
                    ),
                    alignment: Alignment.topRight,
                  ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 24,
                    height: 24,
                    child: Image.asset('assets/images/ic_filter.png'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Dimen.spacingTiny),
          Container(
            width: 32,
            height: 32,
            child: Stack(
              children: [
                if (widget.numberFilterUser > 0)
                  Align(
                    alignment: Alignment.topRight,
                    child: ClipOval(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                        child: FittedBox(
                          child: Text(
                            '${widget.numberFilterUser}',
                            style: Theme.of(context).textTheme.overline.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimen.fontTiny,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 24,
                    height: 24,
                    child: Image.asset('assets/images/ic_filter_user.png'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Dimen.spacingNormal),
        ],
      ),
    );
  }
}
