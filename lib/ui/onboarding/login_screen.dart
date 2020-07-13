import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/login_bloc.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/widget/common_app_password_text_field.dart';
import 'package:samapp/ui/widget/common_app_text_field.dart';
import 'package:samapp/ui/widget/footer_app_version.dart';
import 'package:samapp/ui/widget/login_button.dart';
import 'package:samapp/utils/constant/dimen.dart';

class LoginScreenWidget extends StatefulWidget {
  static const routerName = '/login-screen/';

  @override
  _LoginScreenWidgetState createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  final TextEditingController userNameController = TextEditingController(text: 'nguyennhatquang'); //Just temp for testing
  final TextEditingController passwordController = TextEditingController(text: '123'); //Just temp for testing

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).accentColor,
    );

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(body: LayoutBuilder(builder: (context, viewConstraint) {
      return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(RepositoryProvider.of<RepositoryImp>(context)),
        child: Container(
          height: viewConstraint.maxHeight,
          color: Theme.of(context).accentColor,
          child: Stack(
            children: [
              /* Footer */
              Align(alignment: Alignment.bottomCenter, child: FooterAppVersion(S.of(context).common_app_version('1.0.0 Dev'))),

              /* Header */
              SingleChildScrollView(
                child: Column(
                  children: [
                    /* Welcome Title */
                    SizedBox(
                      height: appBar.preferredSize.height + 40,
                    ),
                    Text(
                      S.of(context).common_welcome_to,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: Dimen.spacingNormal,
                    ),
                    Text(
                      S.of(context).common_full_app_name.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: Dimen.spacingNormal,
                    ),
                    Container(
                        width: screenWidth / 1.5,
                        height: 60,
                        margin: EdgeInsets.only(top: Dimen.spacingLarge, bottom: Dimen.spacingHuge),
                        child: Image.asset(
                          'assets/images/ic_login_logo.png',
                          fit: BoxFit.contain,
                        )),

                    /* Username Input TextField */
                    CommonAppTextField(userNameController, S.of(context).common_username),
                    const SizedBox(
                      height: Dimen.spacingSmall,
                    ),

                    /* Password Input TextField */
                    CommonAppPasswordTextField(passwordController, S.of(context).common_password),
                    const SizedBox(
                      height: Dimen.spacingHuge,
                    ),

                    /* Login Button */
                    LoginButton(userNameController.text.toString(), passwordController.text.toString())
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }
}
