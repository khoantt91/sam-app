import 'package:flutter/material.dart';

class FooterAppVersion extends StatelessWidget {
  String _version;

  FooterAppVersion(this._version);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/bg_login_footer.png'),
        Positioned.fill(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      _version,
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                )))
      ],
    );
  }
}
