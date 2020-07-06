import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:samapp/ui/common/base_stateless_widget.dart';
import 'package:samapp/utils/constant/dimen.dart';

class SenderMessageItem extends BaseStateLessWidget {
  @override
  Widget getLayout(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(top: Dimen.spacingSuperTiny),
            child: ClipOval(
              child: Image.asset(
                'assets/images/ic_avatar_default.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    margin: EdgeInsets.only(top: Dimen.spacingSuperTiny, left: Dimen.spacingTiny),
                    child: Bubble(
                      margin: BubbleEdges.only(top: 10),
                      nip: BubbleNip.leftTop,
                      child: Text('Hi Long, đây là một đoạn text rất là dài và cần phải được wrap_text, xem thử xem nó có warp_text không nhé!'),
                    )),
                Container(
                    margin: EdgeInsets.only(top: Dimen.spacingSuperTiny, right: Dimen.spacingTiny),
                    child: Text(
                      '15:30 20/07/2020',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(color: Theme.of(context).hintColor),
                    )),
              ],
            ),
          )
        ],
      );
}
