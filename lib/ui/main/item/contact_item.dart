import 'package:flutter/material.dart';
import 'package:samapp/ui/common/base_stateless_widget.dart';
import 'package:samapp/utils/constant/dimen.dart';

class ContactItem extends BaseStateLessWidget {
  @override
  Widget getLayout(BuildContext context) => Column(
        children: [
          Row(
            children: [
              /* Avatar */
              Container(
                margin: EdgeInsets.only(top: Dimen.spacingSuperTiny, left: Dimen.spacingNormal, right: Dimen.spacingSmall),
                width: 44,
                height: 44,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/ic_default_image.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Nhung Trần'),
                    Row(
                      children: [
                        Icon(
                          Icons.lens,
                          size: 6,
                          color: Colors.green,
                        ),
                        Container(
                            color: Colors.red,
                            child: SizedBox(
                              width: Dimen.spacingSuperTiny,
                            )),
                        Text('online'),
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(right: Dimen.spacingNormal),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              left: Dimen.spacingNormal,
              right: Dimen.spacingNormal,
            ),
            child: Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
            ),
          ),
        ],
      );
}
