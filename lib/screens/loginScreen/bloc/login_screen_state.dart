part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenState {}


final class LoginScreenInitial extends LoginScreenState {}
final class LoginLoader extends LoginScreenState {}
final class LoginSuccess extends LoginScreenState {}

final class LoginError extends LoginScreenState {
  final String message;
  LoginError(this.message);
}
