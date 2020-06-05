import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/event/login_event.dart';
import 'package:samapp/bloc/state/login_state.dart';
import 'package:samapp/repository/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RepositoryImp _repository;

  LoginBloc(this._repository);

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

      yield LoginLoading();
      final userLogin = await _repository.login(event.userName, event.password, 'HelloFbToken', Platform.operatingSystem);
      yield LoginSuccess(userLogin);
    }
  }
}
