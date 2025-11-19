import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _subscription;

  InternetBloc() : super(InternetState.initial()) {
    on<InternetObserveEvent>(_onObserve);
    on<InternetNotifyEvent>(_onNotify);
  }

  // 🔥 START OBSERVING CONNECTIVITY
  Future<void> _onObserve(
      InternetObserveEvent event, Emitter<InternetState> emit) async {

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      // connectivity_plus 6.0.3 returns a LIST
      final hasInternet = !results.contains(ConnectivityResult.none);

      add(InternetNotifyEvent(hasInternet));
    });
  }

  // 🔥 UPDATE STATE
  void _onNotify(
      InternetNotifyEvent event, Emitter<InternetState> emit) {
    emit(state.copyWith(isConnected: event.isConnected));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
