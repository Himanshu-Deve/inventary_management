import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_management/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final AuthRepository authRepository= AuthRepository();
  LoginScreenBloc() : super(LoginScreenInitial()) {
    on<SendOtpEvent>(_login);
  }

  Future<void> _login(SendOtpEvent event, Emitter<LoginScreenState> emit) async {
    emit(LoginLoader());
    try {
      final res= await authRepository.login(event.userName,event.password);
      if(res==true) {
        emit(LoginSuccess());
      }else{
      }
    } catch (e) {
      emit(LoginError('Failed to send OTP'));
    }
  }
}
