import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/ui/onboarding/splash_screen.dart';
import 'package:samapp/utils/constant/dimen.dart';

class MainAppBarWidget extends BaseStateFulWidget {
  final double _height;
  final Function _navigateToPage;
  final BoxConstraints _constraints;

  MainAppBarWidget(this._height, this._navigateToPage, this._constraints);

  @override
  _MainAppBarWidgetState createState() => _MainAppBarWidgetState();
}

class _MainAppBarWidgetState extends BaseState<MainAppBarWidget> {
  String _title = '...';

  @override
  Widget getLayout() {
    return Container(
      height: widget._height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bg_home_header.png',
            fit: BoxFit.fill,
          ),
          Row(
            children: [
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Container(
                  width: 68,
                  height: 68,
                  margin: EdgeInsets.only(left: Dimen.spacingNormal, bottom: Dimen.spacingNormal),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/ic_default_image.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Container(
                  height: 68,
                  margin: EdgeInsets.only(left: Dimen.spacingSmall, bottom: Dimen.spacingNormal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Nguyễn Nhật Quang',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                      ),
                      _buildRolePopupMenu(),
                    ],
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: Dimen.spacingNormal),
              child: FloatingActionButton(child: Image.asset('assets/images/ic_logout.png'), onPressed: () => {_logout(context)}),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRolePopupMenu() => PopupMenuButton<int>(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.only(
            left: Dimen.spacingSmall,
            right: Dimen.spacingSmall,
          ),
          child: Row(
            children: [
              Text(
                _title,
                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black),
                textAlign: TextAlign.left,
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Buyer Advisor"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Seller Advisor"),
          ),
        ],
        onSelected: (value) {
          if (value == 1)
            _title = 'Buyer Advisor';
          else
            _title = 'Seller Advisor';
          widget._navigateToPage(value == 1 ? 0 : 1, widget._constraints);
        },
      );

  //region Event Listener
  void _logout(BuildContext context) async {
    final repository = RepositoryProvider.of<RepositoryImp>(context);
    final logoutResult = await repository.logout('Android');
    if (logoutResult.success != null) {
      showToast('Đăng xuất thành công');
      Navigator.of(context).pushReplacementNamed(SplashScreenWidget.routerName);
    } else {
      showErrorSnackbar('Đăng xuất thất bại!');
    }
  }
//endregion

}
