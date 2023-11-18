import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetBloc extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;

  InternetBloc({required this.connectivity}) : super(InternetLoadingState()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        emitInternetConnected(Connection.on);
      } else {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(Connection connection) =>
      emit(InternetConnectedState(connection));

  void emitInternetDisconnected() => emit(InternetDisconnectedState());

  @override
  Future<void> close() {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
