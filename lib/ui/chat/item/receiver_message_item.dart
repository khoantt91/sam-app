import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:samapp/ui/common/base_stateless_widget.dart';
import 'package:samapp/utils/constant/dimen.dart';

class ReceiverMessageItem extends BaseStateLessWidget {
  @override
  Widget getLayout(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    margin: EdgeInsets.only(top: Dimen.spacingSuperTiny, right: Dimen.spacingTiny),
                    child: Bubble(
                      margin: BubbleEdges.only(top: 10),
                      nip: BubbleNip.rightTop,
                      color: Color(0xFF2998ff),
                      child: Text(
                        'Hi Long, đây là một đoạn text rất là dài và cần phải được wrap_text, xem thử xem nó có warp_text không nhé!',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(top: Dimen.spacingSuperTiny, left: Dimen.spacingTiny),
                    child: Text(
                      '15:30 20/07/2020',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(color: Theme.of(context).hintColor),
                    )),
              ],
            ),
          ),
        ],
      );
}
