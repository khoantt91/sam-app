import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/chat_bloc.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/ui/common/base_stateless_widget.dart';
import 'package:samapp/utils/constant/dimen.dart';
import 'package:samapp/utils/log/log.dart';
import 'package:transparent_image/transparent_image.dart';

class SenderMessageItem extends BaseStateLessWidget {
  final Message _message;
  final String _avatar;

  SenderMessageItem(this._message, this._avatar);

  @override
  Widget getLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(top: Dimen.spacingSuperTiny, left: Dimen.spacingSmall),
          child: ClipOval(
            child: _avatar == null
                ? Image.asset(
              'assets/images/ic_avatar_default.png',
              fit: BoxFit.contain,
            )
                : FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: _avatar,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: Dimen.spacingSmall, right: Dimen.spacingSuperTiny),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: EdgeInsets.only(left: Dimen.spacingTiny, right: Dimen.spacingTiny, top: 4, bottom: 4),
                        child: Text(
                          _message.content.toString(),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: Dimen.fontNormal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(top: Dimen.spacingSuperTiny, left: Dimen.spacingNormal),
                  child: Text(
                    '15:30 20/07/2020',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: Dimen.fontTiny,
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
