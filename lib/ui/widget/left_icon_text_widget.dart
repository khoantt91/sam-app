import 'package:flutter/material.dart';
import 'package:samapp/ui/common/base_stateless_widget.dart';
import 'package:samapp/utils/constant/dimen.dart';

class LeftIconTextWidget extends BaseStateLessWidget {
  final String text;
  final double spacing;
  final String imageAsset;

  LeftIconTextWidget(this.text, this.spacing, this.imageAsset);

  @override
  Widget getLayout(BuildContext context) => Row(
        children: [
          Container(
            width: 16,
            height: 16,
            child: Image.asset(
              imageAsset,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: spacing,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: Dimen.fontSmall),
          ),
        ],
      );
}
