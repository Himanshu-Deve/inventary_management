part of 'internet_bloc.dart';

abstract class InternetEvent {}

class InternetObserveEvent extends InternetEvent {}

class InternetNotifyEvent extends InternetEvent {
  final bool isConnected;
  InternetNotifyEvent(this.isConnected);
}
