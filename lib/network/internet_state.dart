part of 'internet_bloc.dart';

class InternetState {
  final bool isConnected;

  InternetState({required this.isConnected});

  factory InternetState.initial() => InternetState(isConnected: true);

  InternetState copyWith({bool? isConnected}) {
    return InternetState(
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
