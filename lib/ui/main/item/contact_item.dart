import 'package:flutter/material.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/ui/common/base_stateless_widget.dart';
import 'package:samapp/utils/constant/dimen.dart';
import 'package:transparent_image/transparent_image.dart';

class ContactItem extends BaseStateLessWidget {
  final User _user;
  Function _onUserClickListener;

  ContactItem(this._user, this._onUserClickListener);

  @override
  Widget getLayout(BuildContext context) => InkWell(
        onTap: () => _onUserClickListener(_user),
        child: Column(
          children: [
            Row(
              children: [
                /* Avatar */
                Container(
                  margin: EdgeInsets.only(
                      top: Dimen.spacingSuperTiny, left: Dimen.spacingNormal, right: Dimen.spacingSmall, bottom: Dimen.spacingSuperTiny),
                  width: 44,
                  height: 44,
                  child: ClipOval(
                    child: _user.photo == null
                        ? Image.asset(
                            'assets/images/ic_avatar_default.png',
                            fit: BoxFit.contain,
                          )
                        : FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: _user.photo,
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
                      Text(_user.name),
                      Row(
                        children: [
                          Icon(
                            Icons.lens,
                            size: 6,
                            color: _user.isOnline == true ? Colors.green : Colors.grey,
                          ),
                          Container(
                              color: Colors.red,
                              child: SizedBox(
                                width: Dimen.spacingSuperTiny,
                              )),
                          Text(_user.isOnline == true ? 'online' : 'offline'),
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
          ],
        ),
      );
}
