import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/ui/common/base_stateless_widget.dart';
import 'package:samapp/utils/constant/dimen.dart';

class ReceiverMessageItem extends BaseStateLessWidget {
  final Message _message;

  ReceiverMessageItem(this._message);

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Bubble(
                          margin: BubbleEdges.only(top: 10),
                          nip: BubbleNip.rightTop,
                          color: Color(0xFF2998ff),
                          child: Text(
                            _message.content.toString(),
                            style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: Dimen.spacingSuperTiny, right: Dimen.spacingNormal),
                    child: Opacity(
                      opacity: 0.5,
                      child: Text(
                        '15:30 20/07/2020',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Theme.of(context).hintColor,
                              fontSize: Dimen.fontTiny,
                            ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      );
}
