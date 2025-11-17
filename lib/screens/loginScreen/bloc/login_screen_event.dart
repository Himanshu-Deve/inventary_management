part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenEvent {}

final class SendOtpEvent extends LoginScreenEvent {
  final String userName;
  final String password;
  SendOtpEvent(this.userName,this.password);
}

