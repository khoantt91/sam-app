import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/event/login_event.dart';
import 'package:samapp/bloc/state/login_state.dart';
import 'package:samapp/repository/network/network.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPress) {
      if (event.userName.isEmpty) {
        yield LoginErrorUserName('Tên đăng nhập không để trống');
        return;
      }

      if (event.password.isEmpty) {
        yield LoginErrorPassword('Mật khẩu không để trống');
        return;
      }

      if (event.userName.isEmpty || event.password.isEmpty) return;

      print('aksdjhfkajhdfkahsjfd');
      yield LoginLoading();
      final params = {
        "userName": event.userName,
        "password": event.password,
        "osName": "ANDROID",
        "deviceToken": "HelloToken",
      };

      final userLogin = await NetworkAPI.login(params);
      yield LoginSuccess(userLogin);
    }
  }
}
